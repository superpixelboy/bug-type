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
        
    // Replace the animation section in your Step Event "showing" case:

case "showing":
    animation_timer++;
    
    // Gentle floating animation
    var float_offset = sin(animation_timer * 0.1) * 2;
    y = target_y + float_offset;
    
    // Start content pop-in animations
    if (!content_ready && animation_timer > 5) {
        content_ready = true;
        bug_pop_timer = 0;
        gem_pop_timer = 8;
        
        // NEW: Start coin animation if count > 1
        if (catch_count > 1) {
            show_coin = true;
            coin_pop_timer = 15; // Delay coin after gem
        }
    }
    
    // Bug pop-in animation (existing code...)
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
    
    // Gem pop-in animation (existing code...)
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
    
    // NEW: Coin pop-in animation
    if (show_coin && coin_pop_timer < 15) {
        coin_pop_timer++;
        var coin_progress = coin_pop_timer / 15;
        if (coin_progress < 0.5) {
            coin_pop_scale = lerp(0, 1.4, coin_progress / 0.5); // Even bouncier!
        } else {
            var snap_progress = (coin_progress - 0.5) / 0.5;
            coin_pop_scale = lerp(1.4, 1.0, snap_progress * snap_progress);
        }
    } else if (show_coin) {
        coin_pop_scale = 1.0;
    }
    
    // Click to continue
    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) {
        card_state = "flipping_out";
        animation_timer = 0;
    }
    break;
        
   
case "flipping_out":
    animation_timer++;
    flip_progress = animation_timer / (total_flip_time * 0.7);  // Faster exit
    
    var ease_progress = power(flip_progress, 2);  // Ease in
    
    // QUICK FADE for content (much faster than card movement)
    if (animation_timer < 6) {  // Fade content in first 10 frames
        content_fade_alpha = lerp(1.0, 0.0, animation_timer / 6);
    } else {
        content_fade_alpha = 0.0;  // Fully faded after 10 frames
    }
    
    // Move up and fade (card background only)
    y = lerp(target_y, target_y - 100, ease_progress);
    card_scale_x = lerp(0.8, 0.6, ease_progress);
    card_scale_y = lerp(0.8, 0.6, ease_progress);
    
    // Fade out card background
    image_alpha = lerp(1, 0, ease_progress);
    
    if (flip_progress >= 1) {
        // Return to overworld
        room_goto(global.return_room);
        instance_destroy();
    }
    break;
}