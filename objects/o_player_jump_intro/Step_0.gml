// o_player_jump_intro - Step Event

jump_timer++;

switch(state) {
    case "rising":
        // Upward motion with easing
        var progress = jump_timer / rise_duration;
        progress = min(progress, 1);
        
        // Ease out for smooth arc
        var eased_progress = 1 - power(1 - progress, 2);
        
        // Move upward
        y = start_y - (target_height * eased_progress);
        
        // Animate through first 3 frames (0, 1, 2)
        image_index = floor(progress * 3);
        image_index = min(image_index, 2);
        
        // Check if rise is complete
        if (jump_timer >= rise_duration) {
            state = "falling";
            jump_timer = 0;  // Reset timer for fall phase
        }
        break;
        
    case "falling":
        // Downward motion with gravity feel
        var progress = jump_timer / fall_duration;
        progress = min(progress, 1);
        
        // Ease in for gravity effect
        var eased_progress = progress * progress;
        
        // Move from peak to landing spot
        var peak_y = start_y - target_height;
        y = lerp(peak_y, landing_y, eased_progress);
        
        // Animate through last 4 frames (3, 4, 5, 6)
        var frame_progress = progress * 4;  // 4 frames for falling
        image_index = 3 + floor(frame_progress);
        image_index = min(image_index, 6);
        
        // Check if landing is complete
        if (jump_timer >= fall_duration) {
            state = "landing";
            jump_timer = 0;
            
            // Play landing sound if you have one
            // audio_play_sound(sn_player_land, 1, false);
        }
        break;
        
    case "landing":
        // Brief pause on landing, then enable player
        image_index = 6;  // Stay on last frame
        
        if (jump_timer >= 10) {  // 10 frame pause
            // Transfer control to main player
            if (instance_exists(o_player)) {
                o_player.x = x;
                o_player.y = y;
                o_player.visible = true;
                o_player.movement_mode = "overworld";  // Re-enable movement
            }
            
            // Clean up - destroy this jump object
            instance_destroy();
        }
        break;
}