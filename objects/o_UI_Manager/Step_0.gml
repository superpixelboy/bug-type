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
// Bug selector toggle with F1
if (keyboard_check_pressed(vk_f1)) {
    if (!instance_exists(o_bug_selector)) {
        instance_create_layer(0, 0, "Instances", o_bug_selector);
    } else {
        with(o_bug_selector) {
            menu_active = !menu_active;
        }
    }
}

// Safety check: Reset flag if no cards exist
if (global.showing_card && instance_number(o_bug_card) == 0) {
    global.showing_card = false;
}