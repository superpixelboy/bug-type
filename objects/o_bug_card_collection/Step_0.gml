// o_bug_card_collection Step Event - WITH SLIDE ANIMATION

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
    case "flipping_in":
        animation_timer++;
        
        // Slide in animation (20 frames = 0.33 seconds)
        var entry_progress = animation_timer / 20;
        if (entry_progress >= 1) {
            card_state = "displayed";
            animation_timer = 0;
            content_ready = true;
            // Card reaches final position
            slide_offset_y = 0;
            show_debug_message("Collection card slide complete");
        } else {
            // Smooth easing - starts fast, slows down at end
            var eased_progress = 1 - power(1 - entry_progress, 3); // Ease out cubic
            
            // Slide from bottom of screen to center
            var start_offset = display_get_gui_height() * 0.6; // Start 60% down from center
            slide_offset_y = lerp(start_offset, 0, eased_progress);
        }
        break;
        
    case "displayed":
        // Card is fully shown and interactive
        slide_offset_y = 0; // Ensure it stays in position
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

// Handle content pop animations (same as before)
if (content_ready) {
    // Bug sprite pop animation
    if (bug_pop_scale < 1) {
        bug_pop_timer++;
        var pop_progress = bug_pop_timer / 10; // 10 frames
        bug_pop_scale = min(1, pop_progress * pop_progress); // Ease in
    }
    
    // Gem pop animation (slightly delayed)
    if (bug_pop_scale >= 0.5 && gem_pop_scale < 1) {
        gem_pop_timer++;
        var gem_progress = gem_pop_timer / 8; // 8 frames
        gem_pop_scale = min(1, gem_progress * gem_progress); // Ease in
    }
}