// scr_input_manager.gml
// SAFETY: This script creates a unified input system without breaking existing code
// All existing input checks remain intact - this adds new functionality alongside

// ===== GLOBAL INPUT MANAGER =====
// Call this once per frame in o_game_manager Step event or similar persistent object

function scr_update_input_manager() {
    
    // Initialize input state if not exists
    if (!variable_global_exists("input_manager")) {
        global.input_manager = {
            // Movement inputs (combined from all sources)
            move_up: false,
            move_down: false,
            move_left: false,
            move_right: false,
            
            // Action inputs
            interact: false,           // Space, Mouse Click, Controller A
            interact_pressed: false,   // One-frame press detection
            
            // UI inputs
            menu_toggle: false,        // Tab, C, Controller X
            menu_toggle_pressed: false,
            
            // Menu navigation
            menu_up: false,
            menu_down: false,
            menu_left: false,
            menu_right: false,
            menu_up_pressed: false,
            menu_down_pressed: false,
            menu_left_pressed: false,
            menu_right_pressed: false,
            
            // Cancel/Back
            cancel: false,
            cancel_pressed: false,     // Escape, Controller B
            
            // Debug - for existing bug selector system
            debug_mode_switch_left: false,    // Q key
            debug_mode_switch_right: false,   // E key
            debug_enter: false,               // Enter key
            
            // Current input method detection
            last_input_method: "keyboard",    // "keyboard", "mouse", "controller"
            
            // Controller state
            controller_connected: false,
            controller_slot: -1
        };
    }
    
    var inp = global.input_manager;
    
    // ===== CONTROLLER DETECTION =====
    inp.controller_connected = false;
    inp.controller_slot = -1;
    
    // Check for any connected gamepad
    for (var i = 0; i < 12; i++) {
        if (gamepad_is_connected(i)) {
            inp.controller_connected = true;
            inp.controller_slot = i;
            break;
        }
    }
    
    // ===== MOVEMENT INPUT (All sources combined) =====
    // SAFETY: This preserves all existing input while adding new sources
    
    // Keyboard - WASD (existing)
    var kb_up = keyboard_check(ord("W")) || keyboard_check(vk_up);
    var kb_down = keyboard_check(ord("S")) || keyboard_check(vk_down);
    var kb_left = keyboard_check(ord("A")) || keyboard_check(vk_left);
    var kb_right = keyboard_check(ord("D")) || keyboard_check(vk_right);
    
    // Controller - Left stick + D-pad
    var gp_up = false;
    var gp_down = false;
    var gp_left = false;
    var gp_right = false;
    
    if (inp.controller_connected) {
        var gp = inp.controller_slot;
        
        // D-pad
        gp_up = gamepad_button_check(gp, gp_padu);
        gp_down = gamepad_button_check(gp, gp_padd);
        gp_left = gamepad_button_check(gp, gp_padl);
        gp_right = gamepad_button_check(gp, gp_padr);
        
        // Left analog stick (with deadzone)
        var stick_h = gamepad_axis_value(gp, gp_axislh);
        var stick_v = gamepad_axis_value(gp, gp_axislv);
        var deadzone = 0.3;
        
        if (abs(stick_h) > deadzone) {
            if (stick_h < -deadzone) gp_left = true;
            if (stick_h > deadzone) gp_right = true;
        }
        
        if (abs(stick_v) > deadzone) {
            if (stick_v < -deadzone) gp_up = true;
            if (stick_v > deadzone) gp_down = true;
        }
    }
    
    // Combine all movement sources
    inp.move_up = kb_up || gp_up;
    inp.move_down = kb_down || gp_down;
    inp.move_left = kb_left || gp_left;
    inp.move_right = kb_right || gp_right;
    
    // ===== INTERACTION INPUT =====
    // SAFETY: Preserves existing Space + Mouse click functionality
    
    var kb_interact = keyboard_check(vk_space);
    var mouse_interact = mouse_check_button(mb_left);
    var gp_interact = false;
    
    if (inp.controller_connected) {
        gp_interact = gamepad_button_check(inp.controller_slot, gp_face1); // A button
    }
    
    inp.interact = kb_interact || mouse_interact || gp_interact;
    
    // One-frame press detection
    var kb_interact_pressed = keyboard_check_pressed(vk_space);
    var mouse_interact_pressed = mouse_check_button_pressed(mb_left);
    var gp_interact_pressed = false;
    
    if (inp.controller_connected) {
        gp_interact_pressed = gamepad_button_check_pressed(inp.controller_slot, gp_face1);
    }
    
    inp.interact_pressed = kb_interact_pressed || mouse_interact_pressed || gp_interact_pressed;
    
    // ===== MENU TOGGLE INPUT =====
    // Tab, C key, or Controller X button
    
    var kb_menu = keyboard_check(vk_tab) || keyboard_check(ord("C"));
    var kb_menu_pressed = keyboard_check_pressed(vk_tab) || keyboard_check_pressed(ord("C"));
    var gp_menu = false;
    var gp_menu_pressed = false;
    
    if (inp.controller_connected) {
        gp_menu = gamepad_button_check(inp.controller_slot, gp_face3); // X button
        gp_menu_pressed = gamepad_button_check_pressed(inp.controller_slot, gp_face3);
    }
    
    inp.menu_toggle = kb_menu || gp_menu;
    inp.menu_toggle_pressed = kb_menu_pressed || gp_menu_pressed;
    
    // ===== MENU NAVIGATION =====
    // Arrow keys + Controller D-pad for menu navigation
    
    var menu_kb_up = keyboard_check(vk_up);
    var menu_kb_down = keyboard_check(vk_down);
    var menu_kb_left = keyboard_check(vk_left);
    var menu_kb_right = keyboard_check(vk_right);
    
    var menu_kb_up_pressed = keyboard_check_pressed(vk_up);
    var menu_kb_down_pressed = keyboard_check_pressed(vk_down);
    var menu_kb_left_pressed = keyboard_check_pressed(vk_left);
    var menu_kb_right_pressed = keyboard_check_pressed(vk_right);
    
    // Controller menu navigation
    var menu_gp_up = false;
    var menu_gp_down = false;
    var menu_gp_left = false;
    var menu_gp_right = false;
    var menu_gp_up_pressed = false;
    var menu_gp_down_pressed = false;
    var menu_gp_left_pressed = false;
    var menu_gp_right_pressed = false;
    
    if (inp.controller_connected) {
        var gp = inp.controller_slot;
        menu_gp_up = gamepad_button_check(gp, gp_padu);
        menu_gp_down = gamepad_button_check(gp, gp_padd);
        menu_gp_left = gamepad_button_check(gp, gp_padl);
        menu_gp_right = gamepad_button_check(gp, gp_padr);
        
        menu_gp_up_pressed = gamepad_button_check_pressed(gp, gp_padu);
        menu_gp_down_pressed = gamepad_button_check_pressed(gp, gp_padd);
        menu_gp_left_pressed = gamepad_button_check_pressed(gp, gp_padl);
        menu_gp_right_pressed = gamepad_button_check_pressed(gp, gp_padr);
    }
    
    inp.menu_up = menu_kb_up || menu_gp_up;
    inp.menu_down = menu_kb_down || menu_gp_down;
    inp.menu_left = menu_kb_left || menu_gp_left;
    inp.menu_right = menu_kb_right || menu_gp_right;
    
    inp.menu_up_pressed = menu_kb_up_pressed || menu_gp_up_pressed;
    inp.menu_down_pressed = menu_kb_down_pressed || menu_gp_down_pressed;
    inp.menu_left_pressed = menu_kb_left_pressed || menu_gp_left_pressed;
    inp.menu_right_pressed = menu_kb_right_pressed || menu_gp_right_pressed;
    
    // ===== CANCEL/BACK INPUT =====
    // Escape key or Controller B button
    
    var kb_cancel = keyboard_check(vk_escape);
    var kb_cancel_pressed = keyboard_check_pressed(vk_escape);
    var gp_cancel = false;
    var gp_cancel_pressed = false;
    
    if (inp.controller_connected) {
        gp_cancel = gamepad_button_check(inp.controller_slot, gp_face2); // B button
        gp_cancel_pressed = gamepad_button_check_pressed(inp.controller_slot, gp_face2);
    }
    
    inp.cancel = kb_cancel || gp_cancel;
    inp.cancel_pressed = kb_cancel_pressed || gp_cancel_pressed;
    
    // ===== DEBUG INPUTS (preserve existing bug selector functionality) =====
    inp.debug_mode_switch_left = keyboard_check_pressed(ord("Q"));
    inp.debug_mode_switch_right = keyboard_check_pressed(ord("E"));
    inp.debug_enter = keyboard_check_pressed(vk_enter);
    
    // ===== INPUT METHOD DETECTION =====
    // Track what input method was used last for UI hints
    
    if (mouse_check_button(mb_any) || point_distance(mouse_x, mouse_y, xprevious, yprevious) > 2) {
        inp.last_input_method = "mouse";
    } else if (keyboard_check(vk_anykey) || 
               keyboard_check(ord("W")) || keyboard_check(ord("A")) || 
               keyboard_check(ord("S")) || keyboard_check(ord("D")) ||
               keyboard_check(vk_space) || keyboard_check(vk_tab) ||
               keyboard_check(ord("C")) || keyboard_check(vk_escape)) {
        inp.last_input_method = "keyboard";
    } else if (inp.controller_connected) {
        var gp = inp.controller_slot;
        if (gamepad_button_check(gp, gp_face1) || gamepad_button_check(gp, gp_face2) ||
            gamepad_button_check(gp, gp_face3) || gamepad_button_check(gp, gp_face4) ||
            gamepad_button_check(gp, gp_padu) || gamepad_button_check(gp, gp_padd) ||
            gamepad_button_check(gp, gp_padl) || gamepad_button_check(gp, gp_padr) ||
            abs(gamepad_axis_value(gp, gp_axislh)) > 0.3 ||
            abs(gamepad_axis_value(gp, gp_axislv)) > 0.3) {
            inp.last_input_method = "controller";
        }
    }
}

// ===== HELPER FUNCTIONS FOR EASY ACCESS =====
// SAFETY: These don't replace existing input checks, just provide alternatives

function input_get_move_up() {
    return global.input_manager.move_up;
}

function input_get_move_down() {
    return global.input_manager.move_down;
}

function input_get_move_left() {
    return global.input_manager.move_left;
}

function input_get_move_right() {
    return global.input_manager.move_right;
}

function input_get_interact() {
    return global.input_manager.interact;
}

function input_get_interact_pressed() {
    return global.input_manager.interact_pressed;
}

function input_get_menu_toggle_pressed() {
    return global.input_manager.menu_toggle_pressed;
}

function input_get_cancel_pressed() {
    return global.input_manager.cancel_pressed;
}

function input_get_last_method() {
    return global.input_manager.last_input_method;
}

// Menu navigation helpers
function input_get_menu_up_pressed() {
    return global.input_manager.menu_up_pressed;
}

function input_get_menu_down_pressed() {
    return global.input_manager.menu_down_pressed;
}

function input_get_menu_left_pressed() {
    return global.input_manager.menu_left_pressed;
}

function input_get_menu_right_pressed() {
    return global.input_manager.menu_right_pressed;
}

function input_controller_connected() {
    return global.input_manager.controller_connected;
}