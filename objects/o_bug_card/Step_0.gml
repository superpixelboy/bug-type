
switch(card_state) {
    case "waiting":
        // Count down delay timer
        if (delay_timer > 0) {
            delay_timer--;
        } else {
            // Start the flip animation
            card_state = "flipping_in";
            animation_timer = 0;
        }
        break;
        
    case "hidden":
        // Card starts hidden, waiting to be triggered
        break;
        
    case "flipping_in":
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
            card_scale_x = lerp(0.1, 0.8, (flip_progress - 0.5) * 2);  // Scale to 0.8 instead of 1
            card_rotation = lerp(15, 0, (flip_progress - 0.5) * 2);
        }
        
        // Slight bounce at the end
        if (flip_progress > 0.8) {
            var bounce = sin((flip_progress - 0.8) * 5 * pi) * 0.1;
            card_scale_y = 0.8 + bounce;  // Bounce around 0.8 instead of 1
        }
        
        if (animation_timer >= total_flip_time) {
            card_state = "showing";
            animation_timer = 0;
            
            // Final values
            y = target_y;
            card_scale_x = 1;  // Final scale 0.8
            card_scale_y = 1;  // Final scale 0.8
            card_rotation = 0;
            
            // Start bug bounce animation
            bug_bounce_timer = 0;
        }
        break;
        
    case "showing":
        animation_timer++;
        
        // Gentle floating animation while showing
        var float_offset = sin(animation_timer * 0.1) * 2;
        y = target_y + float_offset;
        
        // Bug bounce animation (first 30 frames)
        if (bug_bounce_timer < 30) {
            bug_bounce_timer++;
            // Create a nice bounce curve
            var bounce_progress = bug_bounce_timer / 30;
            var bounce_curve = sin(bounce_progress * pi * 2) * (1 - bounce_progress);
            bug_bounce_scale = 1.0 + (bounce_curve * 0.3); // Bounce up to 1.3x scale
        } else {
            bug_bounce_scale = 1.0; // Return to normal scale
        }
        
        // Subtle pulsing glow effect
        var pulse = 0.9 + sin(animation_timer * 0.15) * 0.1;
        
        // ONLY advance on click - remove auto-advance
        if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) {
            card_state = "flipping_out";
            animation_timer = 0;
        }
        break;
        
    case "flipping_out":
        animation_timer++;
        flip_progress = animation_timer / (total_flip_time * 0.7);  // Faster exit
        
        var ease_progress = power(flip_progress, 2);  // Ease in
        
        // Move up and fade
        y = lerp(target_y, target_y - 100, ease_progress);
        card_scale_x = lerp(0.8, 0.6, ease_progress);  // Scale from 0.8
        card_scale_y = lerp(0.8, 0.6, ease_progress);  // Scale from 0.8
        
        // Fade out
        image_alpha = lerp(1, 0, ease_progress);
        
        if (flip_progress >= 1) {
            // Return to overworld
            room_goto(global.return_room);
            instance_destroy();
        }
        break;
}