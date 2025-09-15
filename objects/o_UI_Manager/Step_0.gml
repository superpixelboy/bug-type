// o_UI_Manager Step Event - SINGLE F1 HANDLER ONLY
// Handle F1 debug console FIRST (works in all rooms)
if (keyboard_check_pressed(vk_f1)) {
    show_debug_message("=== F1 Debug Console Toggle ===");
    if (!instance_exists(o_bug_selector)) {
        instance_create_layer(0, 0, "Instances", o_bug_selector);
        show_debug_message("Created bug selector");
    } else {
        with(o_bug_selector) {
            menu_active = !menu_active;
            show_debug_message("Toggled bug selector: " + string(menu_active));
        }
    }
}

if (keyboard_check_pressed(vk_f2)) scr_debug_essence_save();
if (keyboard_check_pressed(vk_f3)) scr_test_full_save_load();

// Fullscreen toggle (works everywhere)
if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("F"))) {
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
    } else {
        window_set_fullscreen(true);
    }
}

// === MAIN MENU SPECIFIC BEHAVIOR ===
if (room == rm_main_menu) {
    // EXIT EARLY - Don't run game systems in main menu
    exit;
}

// === GAME SYSTEMS (Only runs outside main menu) ===

// TAB key toggle
/*
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
        }
    }
}*/


// COLLECTION TOGGLE - Tab, C, and Controller X
var collection_input = keyboard_check_pressed(vk_tab) || 
                      keyboard_check_pressed(ord("C"));

// Add controller X if available
if (variable_global_exists("input_manager") && global.input_manager.controller_connected) {
    var gp = global.input_manager.controller_slot;
    collection_input = collection_input || gamepad_button_check_pressed(gp, gp_face3);
}

if (collection_input) {
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
        audio_play_sound(sn_bugtap1, 1, false);
    }
}

// ===== STEP 2: REMOVE COLLECTION LOGIC FROM o_player Step Event =====
// Delete/comment out the ENTIRE "COLLECTION UI TOGGLE" section in o_player

// ===== STEP 3: REMOVE COMPLEX COOLDOWN FROM o_game_manager =====
// Replace the complex cooldown section with just this:

// Simple cooldown system (REMOVE the complex logic)
if (!variable_global_exists("input_cooldown")) {
    global.input_cooldown = 0;
}
if (global.input_cooldown > 0) {
    global.input_cooldown--;
}
scr_update_input_manager();

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
// Use universal input system that supports Controller B button too
// Use the dedicated pause input (ESC + Controller Start) for pause menu

// ===== SIMPLE PAUSE MENU - ESC OR START BUTTON =====
/*
var pause_pressed = keyboard_check_pressed(vk_escape);

// Add Start button if controller connected
for (var i = 0; i < 12; i++) {
    if (gamepad_is_connected(i)) {
        if (gamepad_button_check_pressed(i, gp_start)) {
            pause_pressed = true;
            break;
        }
    }
}

if (pause_pressed) {
    show_debug_message("Pause pressed - checking conditions...");
    
    // Don't open pause menu if debug console is active
    if (instance_exists(o_bug_selector) && o_bug_selector.menu_active) {
        show_debug_message("Bug selector active - ignoring pause");
        exit; // Let bug selector handle ESC
    }
    
    // Don't open pause menu if collection is open
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui != noone && collection_ui.is_open) {
        show_debug_message("Collection open - ignoring pause");
        exit; // Let collection handle ESC
    }
    
    // Don't open during bug catching/card display
    if (instance_exists(o_bug_card) || instance_exists(o_bug_card_collection)) {
        show_debug_message("Bug card active - ignoring pause");
        exit; // Let cards handle their own closing
    }
    
    // Check if pause menu already exists
    if (!instance_exists(o_pause_menu)) {
        show_debug_message("Creating pause menu...");
        var pause_menu = instance_create_layer(0, 0, "Instances", o_pause_menu);
        show_debug_message("Pause menu instance ID: " + string(pause_menu));
        audio_play_sound(sn_bugtap1, 1, false);
    } else {
        // Close pause menu (resume game)
        show_debug_message("Closing pause menu...");
        with(o_pause_menu) {
            global.game_paused = false;
            instance_destroy();
        }
        audio_play_sound(sn_bugtap1, 1, false);
    }
}*/
// === ADD TO o_UI_Manager Step Event (create if doesn't exist) ===

global.tutorial_debug_frame_count++;

// Check if tutorial flag changed unexpectedly
if (global.met_baba_yaga != global.tutorial_debug_last_value) {
    show_debug_message("🚨 TUTORIAL FLAG CHANGED!");
    show_debug_message("  From: " + string(global.tutorial_debug_last_value));
    show_debug_message("  To: " + string(global.met_baba_yaga));
    show_debug_message("  Frame: " + string(global.tutorial_debug_frame_count));
    show_debug_message("  Room: " + string(room_get_name(room)));
    
    // Print call stack to see what caused the change
    show_debug_message("  Call stack: " + string(debug_get_callstack()));
    
    global.tutorial_debug_last_value = global.met_baba_yaga;
}