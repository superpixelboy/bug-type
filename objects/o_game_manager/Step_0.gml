// ===========================================
// o_game_manager Step Event - COMPLETE VERSION
// ===========================================

// CRITICAL: Update music system every frame
scr_music_update();

// DEBUG COMMANDS (add these for testing):

// DEBUG: Press M to manually test music
if (keyboard_check_pressed(ord("M"))) {
    show_debug_message("=== MANUAL MUSIC TEST ===");
    scr_music_play("menu");
}

// DEBUG: Press N to stop music
if (keyboard_check_pressed(ord("N"))) {
    show_debug_message("=== STOPPING MUSIC ===");
    if (global.current_music != noone) {
        audio_stop_sound(global.current_music);
        global.current_music = noone;
        global.current_music_asset = noone;
        global.target_music = noone;
    }
}

// DEBUG: Press B to test basic audio (bypassing music system)
if (keyboard_check_pressed(ord("B"))) {
    show_debug_message("=== BASIC AUDIO TEST ===");
    show_debug_message("Playing sn_main_theme directly...");
    var test_id = audio_play_sound(sn_main_theme, 1, false);
    show_debug_message("Direct audio ID: " + string(test_id));
}

// DEBUG: Press V to test volume
if (keyboard_check_pressed(ord("V"))) {
    show_debug_message("=== MUSIC STATUS ===");
    show_debug_message("Music enabled: " + string(global.music_enabled));
    show_debug_message("Current music: " + (global.current_music == noone ? "none" : string(global.current_music)));
    show_debug_message("Current asset: " + (global.current_music_asset == noone ? "none" : audio_get_name(global.current_music_asset)));
    show_debug_message("Target music: " + (global.target_music == noone ? "none" : audio_get_name(global.target_music)));
    show_debug_message("Volume: " + string(global.music_volume));
    if (global.current_music != noone) {
        show_debug_message("Is playing: " + string(audio_is_playing(global.current_music)));
        show_debug_message("Current gain: " + string(audio_sound_get_gain(global.current_music)));
    }
}


// ===== UPDATE INPUT MANAGER EVERY FRAME =====
// This must run before any objects that use input
scr_update_input_manager();

// ===== GLOBAL PAUSE MENU HANDLING =====
// SAFETY: Enhanced pause system that works with all input methods

// Check for pause input from any source
var pause_input = false;

// Original pause input (preserve existing)
if (keyboard_check_pressed(vk_escape)) {
    pause_input = true;
}

// NEW: Controller pause input (usually Start button or equivalent)
if (variable_global_exists("input_manager")) {
    if (input_get_cancel_pressed()) {
        pause_input = true;
    }
    
    // Alternative: Controller Start button for pause (if you want this)
    if (global.input_manager.controller_connected) {
        var gp = global.input_manager.controller_slot;
        if (gamepad_button_check_pressed(gp, gp_start)) {
            pause_input = true;
        }
    }
}

// Handle pause menu toggling
if (pause_input) {
    // Don't allow pause during certain states
    var can_pause = true;
    
    // Don't pause during collection UI
    if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
        can_pause = false;
    }
    
    // Don't pause during NPC dialogue
    with (o_npc_parent) {
        if (dialogue_active) {
            can_pause = false;
            break;
        }
    }
    
    // Don't pause during cutscenes or intro
    if (instance_exists(o_player) && o_player.movement_mode == "disabled") {
        can_pause = false;
    }
    
    if (can_pause) {
        if (!instance_exists(o_pause_menu)) {
            // Create pause menu
            instance_create_layer(0, 0, "UI", o_pause_menu);
            if (variable_global_exists("game_paused")) {
                global.game_paused = true;
            }
        } else {
            // Close pause menu
            with (o_pause_menu) {
                instance_destroy();
            }
            if (variable_global_exists("game_paused")) {
                global.game_paused = false;
            }
        }
    }
}

// ===== INPUT METHOD DETECTION & UI HINTS =====
// SAFETY: Optional feature to show different UI hints based on input method

if (variable_global_exists("input_manager")) {
    var current_method = input_get_last_method();
    
    // Store globally for UI elements to use
    if (!variable_global_exists("ui_input_method")) {
        global.ui_input_method = "keyboard";
    }
    global.ui_input_method = current_method;
    
    // Optional: Show controller connection status
    if (!variable_global_exists("show_controller_status")) {
        global.show_controller_status = false;
    }
    
    // Detect controller connection/disconnection
    if (!variable_global_exists("controller_was_connected")) {
        global.controller_was_connected = false;
    }
    
    var controller_now_connected = input_controller_connected();
    
    if (controller_now_connected && !global.controller_was_connected) {
        // Controller just connected
        show_debug_message("Controller connected!");
        global.show_controller_status = true;
        // You could show a brief "Controller Connected" message here
    } else if (!controller_now_connected && global.controller_was_connected) {
        // Controller just disconnected
        show_debug_message("Controller disconnected!");
        global.show_controller_status = true;
        // You could show a brief "Controller Disconnected" message here
    }
    
    global.controller_was_connected = controller_now_connected;
}

// Add this to the TOP of your o_game_manager Step Event
// BEFORE the scr_update_input_manager(); call

// ===== GLOBAL INPUT COOLDOWN SYSTEM =====
// SAFETY: Prevents double-triggering of menu inputs

// Initialize global input cooldown if not exists
if (!variable_global_exists("input_cooldown")) {
    global.input_cooldown = 0;
}

// Reduce cooldown each frame
if (global.input_cooldown > 0) {
    global.input_cooldown--;
}

// UPDATE INPUT MANAGER EVERY FRAME
scr_update_input_manager();

// ===== ENHANCED INPUT MANAGER WITH COOLDOWN =====
// Add cooldown check to menu toggle detection

if (variable_global_exists("input_manager")) {
    // Store previous frame's menu toggle state to detect new presses
    if (!variable_global_exists("prev_menu_toggle")) {
        global.prev_menu_toggle = false;
    }
    
    var current_menu_toggle = global.input_manager.menu_toggle;
    var menu_just_pressed = (current_menu_toggle && !global.prev_menu_toggle);
    
    // Update our enhanced press detection with cooldown
    global.input_manager.menu_toggle_pressed = (menu_just_pressed && global.input_cooldown <= 0);
    
    // If menu was just pressed, set cooldown
    if (menu_just_pressed && global.input_cooldown <= 0) {
        global.input_cooldown = 10; // 10 frame cooldown
    }
    
    global.prev_menu_toggle = current_menu_toggle;
}