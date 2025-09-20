// o_bug_card_collection Step Event - FIXED OPACITY FLASH
// UPDATED: Everything appears together with eased entrance, proper opacity control
// SAFETY: Removed leftover bug_box_text references that caused crashes


// === ENHANCED INPUT HANDLING ===
// Handle multiple input types to close the card
var close_card_input = false;

// Mouse click (original)
if (mouse_check_button_pressed(mb_left)) {
    close_card_input = true;
}

// ESC key (original)
if (keyboard_check_pressed(vk_escape)) {
    close_card_input = true;
}

// NEW: Add unified input support (Space + Controller A)
if (input_get_interact_pressed()) {
    close_card_input = true;
}

// Process the close input
if (close_card_input && card_state == "displayed") {
    show_debug_message("Card input detected - returning to collection/overworld");
    card_state = "exiting";
    animation_timer = 0;
}


// Handle card animations and state transitions
switch(card_state) {
    case "sliding_in":
        animation_timer++;
        var slide_progress = animation_timer / total_slide_time;
        slide_progress = min(1.0, slide_progress);
        
        // SMOOTH easing for slide - ease out cubic for satisfying motion
        var ease_progress = 1 - power(1 - slide_progress, 3);
        
        // Move card up from bottom with smooth interpolation
        y = lerp(start_y, target_y, ease_progress);
        
        // Fade in content with slide
        content_fade_alpha = lerp(0.0, 1.0, ease_progress);
        
        // Transition to displayed state when animation completes
        if (animation_timer >= total_slide_time) {
            card_state = "displayed";
            animation_timer = 0;
            y = target_y; // Ensure exact final position
            content_fade_alpha = 1.0; // Ensure full opacity
        }
        break;
        
    case "displayed":
        // Card is fully visible and interactive
        // Gentle floating effect while displayed
        gem_float_timer += 0.05;
        gem_glow_timer += 0.03;
        
        // Optional subtle floating animation
        var float_offset = sin(animation_timer * 0.02) * 1; // Very gentle float
        y = target_y + float_offset;
        animation_timer++;
        break;
        
    case "exiting":
        animation_timer++;
        var exit_time = 20; // Slightly longer for smoother exit
        var exit_progress = animation_timer / exit_time;
        exit_progress = min(1.0, exit_progress);
        
        // SMOOTH exit animation - ease in cubic for quick departure
        var ease_exit = power(exit_progress, 2);
        
        // Slide down and fade out smoothly
        y = lerp(target_y, room_height + 100, ease_exit);
        content_fade_alpha = lerp(1.0, 0.0, ease_exit);
        
        if (animation_timer >= exit_time) {
            // Clean up and return to collection
            if (instance_exists(o_bug_collection_ui)) {
                with (o_bug_collection_ui) {
                    hovered_card = -1;
                    hover_timer = 0;
                }
            }
            instance_destroy();
        }
        break;
}

// FIXED: Update coin count every frame like the collection UI does
// This ensures the collection card always shows the current count
if (type_id != "unknown") {
    var fresh_count = get_bug_catch_count(type_id);
    
    // Only update if the count has changed to avoid unnecessary operations
    if (coin_value != fresh_count) {
        coin_value = fresh_count;
        coin_sprite = get_coin_sprite_from_count(coin_value);
        
        show_debug_message("Collection card coin refreshed for " + type_id + ": count updated to " + string(coin_value));
        
        // SAFETY: Ensure minimum value of 1 for displayed cards
        if (coin_value == 0) {
            coin_value = 1;
            coin_sprite = s_coin_copper;
        }
    }
}

