// o_bug_card_collection Step Event - FINAL WITH ANIMATIONS

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
        
        // Quick entry animation (15 frames = 0.25 seconds)
        var entry_progress = animation_timer / 15;
        if (entry_progress >= 1) {
            card_state = "displayed";
            animation_timer = 0;
            content_ready = true;
            show_debug_message("Collection card animation complete");
        }
        break;
        
    case "displayed":
        // Card is fully shown and interactive
        break;
        
    case "exiting":
        animation_timer++;
        
        // Quick fade out
        content_fade_alpha = lerp(1, 0, animation_timer / 10);
        
        var exit_progress = animation_timer / 15;
        if (exit_progress >= 1) {
            show_debug_message("Collection card exit complete");
            instance_destroy();
        }
        break;
}

// Handle content pop animations
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