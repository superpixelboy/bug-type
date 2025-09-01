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
// Handle state transitions and animation timing
switch(card_state) {
    case "waiting":
        delay_timer++;
        if (delay_timer >= 30) { // 30-frame delay (half second)
            card_state = "flipping_in";
            animation_timer = 0;
        }
        break;
        
    case "flipping_in":
        animation_timer++;
        flip_progress = animation_timer / total_flip_time;
        
        if (flip_progress >= 0.5 && !content_ready) {
            content_ready = true;
            bug_pop_timer = 0;
            gem_pop_timer = 0;
        }
        
        if (animation_timer >= total_flip_time) {
            card_state = "displaying";
            animation_timer = 0;
        }
        break;
        
    case "displaying":
        animation_timer++;
        if (animation_timer >= display_time) {
            card_state = "flipping_out";
            animation_timer = 0;
        }
        break;
        
    case "flipping_out":
        animation_timer++;
        flip_progress = 1 - (animation_timer / total_flip_time);
        
        // Fade content during flip out
        var fade_progress = animation_timer / total_flip_time;
        content_fade_alpha = lerp(1.0, 0.0, fade_progress);
        
        if (animation_timer >= total_flip_time) {
            global.showing_card = false;
            instance_destroy();
        }
        break;
}

// Bug pop animation (when content appears)
if (content_ready && bug_pop_timer <= 20) {
    bug_pop_timer++;
    var pop_progress = bug_pop_timer / 20;
    bug_pop_scale = lerp(0, 1.2, pop_progress);
    
    if (pop_progress >= 1) {
        bug_pop_scale = lerp(1.2, 1.0, (bug_pop_timer - 20) / 10);
    }
}

// Gem pop animation (slightly delayed)
if (content_ready && gem_pop_timer <= 20) {
    gem_pop_timer++;
    var gem_progress = gem_pop_timer / 20;
    gem_pop_scale = lerp(0, 1.2, gem_progress);
    
    if (gem_progress >= 1) {
        gem_pop_scale = lerp(1.2, 1.0, (gem_pop_timer - 20) / 10);
    }
}

// Gem floating and glow effects
gem_float_timer += 0.05;
gem_glow_timer += 0.03;

// FIXED: Update coin count every frame like the collection UI does
// This ensures the catch card always shows the current count
if (type_id != "unknown") {
    var fresh_count = get_bug_catch_count(type_id);
    
    // Only update if the count has changed to avoid unnecessary operations
    if (coin_value != fresh_count) {
        coin_value = fresh_count;
        coin_sprite = get_coin_sprite_from_count(coin_value);
        
        show_debug_message("Catch card coin refreshed for " + type_id + ": count updated to " + string(coin_value));
        
        // SAFETY: Ensure minimum value of 1
        if (coin_value == 0) {
            coin_value = 1;
            coin_sprite = s_coin_copper;
        }
    }
}

// REMOVED: All pop-in animation code since content appears immediately
// No more bug_pop_timer, gem_pop_timer, or content_ready checks