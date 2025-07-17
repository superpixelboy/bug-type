// Simplified state machine
switch(state) {
    case "idle":
        // Cycle between frames 0 and 1 (breathing animation)
        anim_timer++;
        if (anim_timer >= 45) {
            image_index = (image_index == 0) ? 1 : 0;
            anim_timer = 0;
        }
        break;
        
    case "recovering":
        // Show frame 2 (hit/stunned frame) 
        image_index = 2;
        
        // KEEP THE RECOVERY TIMER LOGIC!
        recovery_timer++;
        if (recovery_timer >= recovery_window) {
            state = "idle";
            recovery_timer = 0;
        }
        break;
        
    case "ready_to_catch":
        // Show frame 3 (dazed/vulnerable frame)
        image_index = 3;
        
        // Gentle ready glow effect
        if ((current_time * 0.01) % 40 < 20) {
            is_flashing = true;
        } else {
            is_flashing = false;
        }
        break;
        
    case "capturing":
        // Keep showing dazed frame during capture
        image_index = 3;
        
        capture_timer++;
        
        // Bug shrinks and flies toward essence counter
        var progress = capture_timer / 60;
        
        // Use capture_scale for shrinking
        capture_scale = lerp(1, 0, progress);
        
        // Move toward upper left corner
        x = lerp(xstart, 60, progress);
        y = lerp(ystart, 30, progress);
        
        // Set alpha for fading
        image_alpha = lerp(1, 0, progress);
        
        if (capture_timer >= 60) {
            state = "caught";
            
            // Make invisible but huge for easy clicking
            image_alpha = 0;           // Invisible
            capture_scale = 10;        // Huge click area
            x = room_width / 2;        // Center of screen
            y = room_height / 2;
        }
        break;
        
    case "caught":
        // Keep showing dazed frame
        image_index = 3;
        break;
}

// Keep all the bounce and visual effects below!
// Handle flash effect
if (flash_timer > 0) {
    flash_timer--;
    is_flashing = true;
} else {
    if (state != "ready_to_catch") {
        is_flashing = false;
    }
}

// Scale bounce effect (satisfying feedback) - KEEP THIS!
if (scale_bounce_x < 0) {
    scale_bounce_x *= 0.7;
    scale_bounce_y *= 0.7;
    
    if (scale_bounce_x > -0.1) {
        scale_bounce_x = 0.3;
        scale_bounce_y = 0.3;
    }
} else if (scale_bounce_x > 0) {
    scale_bounce_x *= 0.8;
    scale_bounce_y *= 0.8;
    
    if (scale_bounce_x < 0.05) {
        scale_bounce_x = 0;
        scale_bounce_y = 0;
    }
}

// Handle bounce decay - KEEP THIS!
if (abs(bounce_offset_x) > 0.1 || abs(bounce_offset_y) > 0.1) {
    bounce_offset_x *= bounce_decay;
    bounce_offset_y *= bounce_decay;
} else {
    bounce_offset_x = 0;
    bounce_offset_y = 0;
}