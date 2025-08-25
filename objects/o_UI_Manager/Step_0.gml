// Clean o_UI_Manager Step Event - NO ESSENCE RESETS

// Fullscreen toggle with Shift+F
if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("F"))) {
    // Toggle fullscreen
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
    } else {
        window_set_fullscreen(true);
    }
}

// TAB key toggle
if (keyboard_check_pressed(vk_tab)) {
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui != noone) {
        if (collection_ui.is_open && collection_ui.detail_view_open) {
            collection_ui.detail_view_open = false;
            collection_ui.detail_bug_key = "";
            collection_ui.detail_bug_data = {};
            collection_ui.hovered_card = -1;
            collection_ui.hover_timer = 0;
        } else {
            collection_ui.is_open = !collection_ui.is_open;
            if (collection_ui.is_open) {
                collection_ui.page = 0;
            }
            collection_ui.detail_view_open = false;
            collection_ui.detail_bug_key = "";
            collection_ui.detail_bug_data = {};
            collection_ui.hovered_card = -1;
            collection_ui.hover_timer = 0;
        }
    }
}

// Door cooldown
if (global.door_cooldown > 0) {
    global.door_cooldown--;
}

// Screen flash
if (flash_timer < flash_duration) {
    flash_timer++;
    flash_alpha = lerp(0.8, 0, flash_timer / flash_duration);
} else {
    flash_alpha = 0;
}

// Bug selector
if (keyboard_check_pressed(vk_f1)) {
    if (!instance_exists(o_bug_selector)) {
        instance_create_layer(0, 0, "Instances", o_bug_selector);
    } else {
        with(o_bug_selector) {
            menu_active = !menu_active;
        }
    }
}

// DEBUG: Track essence changes
if (global.essence != last_essence_amount) {
    show_debug_message("=== ESSENCE CHANGED ===");
    show_debug_message("From: " + string(last_essence_amount) + " To: " + string(global.essence));
}

// Orb burst detection
var current_milestone = floor(global.essence / 100);
var previous_milestone = floor(last_essence_amount / 100);

if (current_milestone > previous_milestone && global.essence > 0) {
    show_debug_message(">>> BURST TRIGGERING <<<");
    show_debug_message("Essence BEFORE burst: " + string(global.essence));
    
    // Effects only - NO ESSENCE CHANGES
    scr_spawn_orb_burst_particles(80, 75);
    audio_play_sound(sn_bug_ready, 1, false);
    flash_alpha = 0.8;
    flash_duration = 30;
    flash_timer = 0;
    
    show_debug_message("Essence AFTER burst: " + string(global.essence));
    show_debug_message(">>> BURST COMPLETE <<<");
}

// Update tracking (last line)
last_essence_amount = global.essence;