// o_bug_card Step Event - Debug version
switch(card_state) {
    case "waiting":
        show_debug_message("Card state: waiting, delay_timer: " + string(delay_timer));
        // Count down delay timer
        if (delay_timer > 0) {
            delay_timer--;
        } else {
            // Start the flip animation
            card_state = "flipping_in";
            animation_timer = 0;
            show_debug_message("Starting flip animation!");
        }
        break;
        
    case "hidden":
        // Card starts hidden, waiting to be triggered
        show_debug_message("Card state: hidden");
        break;
        
    case "flipping_in":
        show_debug_message("Card flipping in! Timer: " + string(animation_timer) + ", Y: " + string(y));
        animation_timer++;
        flip_progress = animation_timer / total_flip_time;
        
        // Smooth easing for the flip
        var ease_progress = 1 - power(1 - flip_progress, 3);  // Ease out cubic
        
        // Move from bottom of screen to center
        y = lerp(start_y, target_y, ease_progress);
        
        // Scale and rotation for flip effect
        if (flip_progress < 0.5) {
            // First half: shrink horizontally (back of card)
            card_scale_x = lerp(1, 0.1, flip_progress * 2);
            card_rotation = lerp(0, 15, flip_progress * 2);  // Slight tilt
        } else {
            // Second half: grow back (front of card with bug)
            card_scale_x = lerp(0.1, 1, (flip_progress - 0.5) * 2);
            card_rotation = lerp(15, 0, (flip_progress - 0.5) * 2);
        }
        
        // Slight bounce at the end
        if (flip_progress > 0.8) {
            var bounce = sin((flip_progress - 0.8) * 5 * pi) * 0.1;
            card_scale_y = 1 + bounce;
        }
        
        if (animation_timer >= total_flip_time) {
            card_state = "showing";
            animation_timer = 0;
            
            // Final values
            y = target_y;
            card_scale_x = 1;
            card_scale_y = 1;
            card_rotation = 0;
            
            // Start content animations
            content_ready = true;
            bug_pop_timer = 0;
            gem_pop_timer = 8;
            if (show_coin) {
                coin_pop_timer = 0;
            }
            
            show_debug_message("Card now showing at Y: " + string(y));
        }
        break;
        
    case "showing":
        animation_timer++;
        
        // Gentle floating animation
        var float_offset = sin(animation_timer * 0.1) * 2;
        y = target_y + float_offset;
        
        // Bug pop-in animation
        if (content_ready && bug_pop_timer < 20) {
            bug_pop_timer++;
            var pop_progress = bug_pop_timer / 20;
            if (pop_progress < 0.5) {
                bug_pop_scale = lerp(0, 1.3, pop_progress / 0.5);
            } else {
                var snap_progress = (pop_progress - 0.5) / 0.5;
                bug_pop_scale = lerp(1.3, 1.0, snap_progress * snap_progress);
            }
        } else if (content_ready) {
            bug_pop_scale = 1.0;
        }
        
        // Gem pop-in animation
        if (content_ready && gem_pop_timer < 15) {
            gem_pop_timer++;
            var gem_progress = gem_pop_timer / 15;
            if (gem_progress < 0.5) {
                gem_pop_scale = lerp(0, 1.3, gem_progress / 0.5);
            } else {
                var snap_progress = (gem_progress - 0.5) / 0.5;
                gem_pop_scale = lerp(1.3, 1.0, snap_progress * snap_progress);
            }
        } else if (content_ready) {
            gem_pop_scale = 1.0;
        }
        
        // Click to continue
        if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) {
            card_state = "flipping_out";
            animation_timer = 0;
            show_debug_message("Starting flip out");
        }
        break;
        
    case "flipping_out":
        animation_timer++;
        flip_progress = animation_timer / (total_flip_time * 0.7);  // Faster exit
        
        // Quick fade for content
        if (animation_timer < 6) {
            content_fade_alpha = lerp(1.0, 0.0, animation_timer / 6);
        } else {
            content_fade_alpha = 0.0;
        }
        
        // Move up and fade
        var ease_progress = power(flip_progress, 2);
        y = lerp(target_y, target_y - 100, ease_progress);
        card_scale_x = lerp(1, 0.6, ease_progress);
        card_scale_y = lerp(1, 0.6, ease_progress);
        
        //
    
    // Fade out card background
    image_alpha = lerp(1, 0, ease_progress);
    
    if (flip_progress >= 1) {
        // Return to overworld
        room_goto(global.return_room);
        instance_destroy();
    }
    break;
}