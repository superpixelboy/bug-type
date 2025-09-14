// Exit early if game is paused
if (variable_global_exists("game_paused") && global.game_paused) {
    exit; // Skip the rest of the Step event - pause bug animation/logic
}

// === NEW: UNIFIED INPUT SUPPORT ===
// Add spacebar and controller support for bug interactions
if (input_get_interact_pressed()) {
    if (state == "caught") {
        // Any interaction returns to overworld (same as mouse click)
        room_goto(global.return_room);
    } else {
        // Normal bug clicking behavior (same as mouse click)
        scr_bug_handle_click();
    }
    
    if (state == "ready_to_catch") {
        scr_bug_handle_catch();
    }
}

// Simplified state machine
switch(state) {
 
		case "idle":
    // Cycle between frames 0 and 1 (breathing animation)
	    anim_timer++;
	    if (anim_timer >= 30) {  // Adjust speed as needed
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
        image_index = 2;
        
        // Gentle ready glow effect
        if ((current_time * 0.01) % 40 < 20) {
            is_flashing = true;
        } else {
            is_flashing = false;
        }
        break;
        
 
// In o_bug_parent Step Event, modify the "capturing" case:

case "capturing":
    // Keep showing dazed frame during capture
    image_index = 2;
    
    capture_timer++;
    
    // Bug shrinks and flies toward essence counter (faster now)
    var progress = capture_timer / 30;  // Reduced from 60 to 30
    
    // Use capture_scale for shrinking
    capture_scale = lerp(1, 0, progress);
    
    // Move toward upper left corner
    x = lerp(xstart, 60, progress);
    y = lerp(ystart, 30, progress);
    
    // Set alpha for fading
    image_alpha = lerp(1, 0, progress);
    
    if (capture_timer >= 30) {  // Reduced from 60
        // Don't go to "caught" state - let the card handle everything
        instance_destroy();
    }
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

// Auto-catch system (only when in idle state)
if (state == "idle" && auto_catch_enabled) {
    auto_catch_timer++;
    
    if (auto_catch_timer >= auto_catch_interval) {
        // Auto-damage every 10 frames
        current_hp -= (global.has_oak_wand ? 2 : 1);
        auto_catch_timer = 0;
        
        // Gentle visual feedback instead of click feedback
        flash_timer = 4;  // Shorter flash
        // NO scale bounce or click particles
        
        // Update progress bar
        catch_progress = 1 - (current_hp / bug_max_hp);
        
        // Check if ready to catch
        if (current_hp <= 0) {
            state = "ready_to_catch";
            current_hp = 0;
            scr_screen_flash();
            audio_play_sound(sn_bug_ready, 1, false);
        }
    }
}