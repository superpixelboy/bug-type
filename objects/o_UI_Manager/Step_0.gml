// Clean o_UI_Manager Step Event - CENTRALIZED ESC HANDLING

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

// Orb burst detection WITH FILL RESET + SPEED BOOST
var current_milestone = floor(global.essence / 100);
var previous_milestone = floor(last_essence_amount / 100);

if (current_milestone > previous_milestone && global.essence > 0) {
    show_debug_message(">>> BURST TRIGGERING WITH FILL RESET <<<");
    show_debug_message("Essence BEFORE burst: " + string(global.essence));
    
    // Effects - NO ESSENCE CHANGES
    scr_spawn_orb_burst_particles(80, 75);
    audio_play_sound(sn_bug_ready, 1, false);
    flash_alpha = 0.8;
    flash_duration = 30;
    flash_timer = 0;
    
    // ✨ Reset the visual fill to 0 AND make it fill faster temporarily
    essence_fill_percentage = 0;
    fill_lerp_speed = 0.15;  // Much faster refill after burst
    
    show_debug_message("Fill percentage RESET to 0, speed boosted");
    show_debug_message("Essence AFTER burst: " + string(global.essence));
    show_debug_message(">>> BURST COMPLETE <<<");
} else {
    // Normal speed when not bursting
    fill_lerp_speed = 0.05;  // Back to normal speed
}

// Update tracking (last line)
last_essence_amount = global.essence;

// ESC COOLDOWN: Countdown timer
if (esc_cooldown > 0) {
    esc_cooldown--;
}

// CENTRALIZED ESC HANDLING - Handles both opening AND closing pause menus
if (keyboard_check_pressed(vk_escape) && esc_cooldown <= 0) {
    show_debug_message("ESC pressed - centralized handling");
    
    // Don't handle ESC if debug console is active
    if (instance_exists(o_bug_selector) && o_bug_selector.menu_active) {
        show_debug_message("Bug selector active - letting it handle ESC");
        exit;
    }
    
    // Don't handle ESC if collection is open (let collection handle ESC)
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui != noone && collection_ui.is_open) {
        show_debug_message("Collection open - letting it handle ESC");
        exit;
    }
    
    // Don't handle ESC during bug catching/card display
    if (instance_exists(o_bug_card) || instance_exists(o_bug_card_collection)) {
        show_debug_message("Bug card active - letting cards handle ESC");
        exit;
    }
    
    // CENTRALIZED LOGIC: If pause menu exists, close it. If not, open it.
    var pause_menu = instance_find(o_pause_menu, 0);
    if (pause_menu != noone) {
        // CLOSE pause menu
        show_debug_message("Closing pause menu via UI_Manager");
        audio_play_sound(sn_bug_catch1, 1, false);
        global.game_paused = false;
        instance_destroy(pause_menu);
    } else {
        // OPEN pause menu
        show_debug_message("Creating pause menu via UI_Manager");
        var new_pause_menu = instance_create_layer(0, 0, "Instances", o_pause_menu);
        show_debug_message("Pause menu instance ID: " + string(new_pause_menu));
        audio_play_sound(sn_bugtap1, 1, false);
    }
    
    // Set cooldown to prevent double-hits
    esc_cooldown = 10;
    show_debug_message("ESC cooldown set to: " + string(esc_cooldown));
}