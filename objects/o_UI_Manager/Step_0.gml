/// @description Insert description here
// You can write your code in this editor
// Fullscreen toggle with Shift+F
if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("F"))) {
    // Toggle fullscreen
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
    } else {
        window_set_fullscreen(true);
    }
}


// Toggle bug collection book with Tab
if (keyboard_check_pressed(vk_tab)) {
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui != noone) {
        collection_ui.is_open = !collection_ui.is_open;
    }
}

// Reduce door cooldown
if (global.door_cooldown > 0) {
    global.door_cooldown--;
}

// Handle screen flash (add to existing Step Event)
if (flash_timer < flash_duration) {
    flash_timer++;
    // Fade the flash over time
    flash_alpha = lerp(0.8, 0, flash_timer / flash_duration);
} else {
    flash_alpha = 0;
}

//DEBUG RESET ROCKS
  if (keyboard_check_pressed(ord("R"))) {
        // Save position globally before starting fade
        global.sleep_x = o_player.x;
        global.sleep_y = o_player.y;
        
        // Create fade controller
        if (!instance_exists(o_fade_controller)) {
            var fade = instance_create_layer(0, 0, "Instances", o_fade_controller);
            fade.action_to_perform = "sleep";
            fade.fade_state = "fade_out";
        }
    }