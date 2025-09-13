// o_wake_up_prompt - Create Event - Enhanced with Multi-Input Text
// SAFETY: Only changes the prompt text to reflect multiple input options

// Find the hole object to get proper positioning (UNCHANGED)
var hole_obj = instance_find(o_hole, 0);
var hole_center_x = x;
var hole_center_y = y;

if (instance_exists(hole_obj)) {
    hole_center_x = hole_obj.x;
    hole_center_y = hole_obj.y;
    // IMPORTANT: Disable hole's sleep functionality during intro
    hole_obj.intro_active = true;
}

// Position at hole (UNCHANGED)
x = hole_center_x;
y = hole_center_y;

// Text display variables - ENHANCED to show multiple input options
waiting_for_input = true;

// ENHANCED: Dynamic prompt text based on available input methods
if (variable_global_exists("input_manager")) {
    scr_update_input_manager();
    if (global.input_manager.controller_connected) {
        prompt_text = "Press A, SPACE, or CLICK to wake up!";
    } else {
        prompt_text = "Press SPACE or CLICK to wake up!";
    }
} else {
    // Fallback: Check for controller directly
    var controller_found = false;
    for (var i = 0; i < 12; i++) {
        if (gamepad_is_connected(i)) {
            controller_found = true;
            break;
        }
    }
    
    if (controller_found) {
        prompt_text = "Press A, SPACE, or CLICK to wake up!";
    } else {
        prompt_text = "Press SPACE or CLICK to wake up!";
    }
}

text_alpha = 1;
text_pulse_timer = 0;
text_bounce_y = 0;
text_y_offset = -30;  // Position text above the hole

// Set depth to draw on top (UNCHANGED)
depth = -1000;

// Disable player during intro sequence (UNCHANGED)
if (instance_exists(o_player)) {
    o_player.visible = false;
    o_player.movement_mode = "disabled";
}