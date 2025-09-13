// REPLACE your o_game_manager Step Event with this FIXED version:

// ===== UPDATE INPUT MANAGER EVERY FRAME =====
scr_update_input_manager();

// ===== SIMPLE INPUT COOLDOWN SYSTEM =====
// SAFETY: Just reduce cooldown, don't interfere with input detection

// Initialize global input cooldown if not exists
if (!variable_global_exists("input_cooldown")) {
    global.input_cooldown = 0;
}

// Reduce cooldown each frame
if (global.input_cooldown > 0) {
    global.input_cooldown--;
}

// REMOVED: All the complex cooldown logic that was blocking input
// Let o_player handle cooldowns on its own

// ===== GLOBAL PAUSE MENU HANDLING =====
// Check for pause input from any source
var pause_input = false;

// Original pause input (preserve existing)
if (keyboard_check_pressed(vk_escape)) {
    pause_input = true;
}

// NEW: Controller pause input
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
    } else if (!controller_now_connected && global.controller_was_connected) {
        // Controller just disconnected
        show_debug_message("Controller disconnected!");
        global.show_controller_status = true;
    }
    
    global.controller_was_connected = controller_now_connected;
}