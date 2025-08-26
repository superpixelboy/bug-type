// o_bug_card_collection Step Event - FIXED OPACITY FLASH
// UPDATED: Everything appears together with eased entrance, proper opacity control

// Handle mouse clicks to close the card
if (mouse_check_button_pressed(mb_left)) {
    if (card_state == "displayed") {
        show_debug_message("Collection card clicked - returning to collection");
        card_state = "exiting";
        animation_timer = 0;
    }
}

// Handle ESC key to close
if (keyboard_check_pressed(vk_escape)) {
    if (card_state == "displayed") {
        show_debug_message("ESC pressed - returning to collection");
        card_state = "exiting";
        animation_timer = 0;
    }
}

// Handle card animations
switch(card_state) {
    case "sliding_in":
        animation_timer++;
        
        // Smooth slide entrance with ease-out
        var entry_progress = animation_timer / total_slide_time;
        if (entry_progress >= 1) {
            card_state = "displayed";
            animation_timer = 0;
            slide_offset_y = 0;
            content_fade_alpha = 1.0;  // FIXED: Ensure full opacity when complete
            show_debug_message("Collection card entrance complete");
        } else {
            // Smooth ease-out cubic animation
            var eased_progress = 1 - power(1 - entry_progress, 3);
            
            // FIXED: Fade in opacity along with slide animation
            content_fade_alpha = eased_progress;
            
            // Slide from below screen to center
            var start_offset = display_get_gui_height() * 0.6; // Start 60% below center
            slide_offset_y = lerp(start_offset, 0, eased_progress);
        }
        break;
        
    case "displayed":
        // Card is fully shown and interactive
        slide_offset_y = 0; // Ensure it stays in position
        content_fade_alpha = 1.0;  // FIXED: Ensure opacity stays at 1.0
        
        // Optional: Add subtle floating animation
        gem_float_timer += 0.05;
        // This can be used in Draw event for gentle gem bobbing if desired
        break;
        
    case "exiting":
        animation_timer++;
        
        // Quick fade and slide down
        content_fade_alpha = lerp(1, 0, animation_timer / 12);
        
        var exit_progress = animation_timer / 15;
        if (exit_progress >= 1) {
            show_debug_message("Collection card exit complete");
            instance_destroy();
        } else {
            // Slide down while fading
            var eased_progress = power(exit_progress, 2); // Ease in
            var end_offset = display_get_gui_height() * 0.4; // Slide down 40% from center
            slide_offset_y = lerp(0, end_offset, eased_progress);
        }
        break;
}

// REMOVED: All pop-in animation code since content appears immediately
// No more bug_pop_timer, gem_pop_timer, or content_ready checks