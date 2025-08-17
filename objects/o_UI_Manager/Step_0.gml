// o_UI_Manager Step Event - FIXED
// Tab key now TOGGLES collection (both opens and closes)

// Fullscreen toggle with Shift+F
if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("F"))) {
    // Toggle fullscreen
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
    } else {
        window_set_fullscreen(true);
    }
}

// TAB key now TOGGLES collection (opens AND closes)
if (keyboard_check_pressed(vk_tab)) {
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui != noone) {
        if (collection_ui.is_open && collection_ui.detail_view_open) {
            // If detail view is open, close detail view first
            collection_ui.detail_view_open = false;
            collection_ui.detail_bug_key = "";
            collection_ui.detail_bug_data = {};
            collection_ui.hovered_card = -1;
            collection_ui.hover_timer = 0;
        } else {
            // Toggle the main collection
            collection_ui.is_open = !collection_ui.is_open;
            
            // Reset states when opening OR closing
            if (collection_ui.is_open) {
                // Opening - reset to first page
                collection_ui.page = 0;
            }
            
            // Always reset these when toggling
            collection_ui.detail_view_open = false;
            collection_ui.detail_bug_key = "";
            collection_ui.detail_bug_data = {};
            collection_ui.hovered_card = -1;
            collection_ui.hover_timer = 0;
        }
    }
}

// Reduce door cooldown
if (global.door_cooldown > 0) {
    global.door_cooldown--;
}

// Handle screen flash
if (flash_timer < flash_duration) {
    flash_timer++;
    // Fade the flash over time
    flash_alpha = lerp(0.8, 0, flash_timer / flash_duration);
} else {
    flash_alpha = 0;
}

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