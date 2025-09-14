// o_escape_button Step Event - Enhanced with R key + B gamepad support
// SAFETY: Adds R key + B button while preserving all existing functionality

// Stay inactive during collection menu AND bug card display
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    is_hovered = false; // Reset hover state
    hover_scale = 1.0;  // Reset scale
    exit; // Don't process hover/input when collection is open
}

// ALSO stay inactive when bug card is showing (final catch phase)
if (instance_exists(o_bug_card)) {
    is_hovered = false;
    hover_scale = 1.0;
    exit; // Don't process during bug card display
}

// Stay disabled once bug is ready to catch - redundant at that point
var should_disable = false;
if (instance_exists(o_bug_parent)) {
    with(o_bug_parent) {
        if (state == "ready_to_catch" || state == "capturing" || state == "caught") {
            should_disable = true;
        }
    }
}

if (should_disable) {
    is_hovered = false;
    hover_scale = 1.0;
    exit; // Stay disabled - clicking anywhere works now
}

// SAFETY: Using GUI mouse coordinates for proper hover detection

// Get GUI mouse coordinates
var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

// Calculate actual GUI position - moved right
var gui_x = gui_x_offset;  // Distance from left edge (now 120px)
var gui_y = display_get_gui_height() - gui_y_offset;  // Distance from bottom

// Calculate button bounds in GUI space
var button_width = sprite_get_width(sprite_index) * base_scale;
var button_height = sprite_get_height(sprite_index) * base_scale;

// Check if mouse is within button bounds (using GUI coordinates)
is_hovered = (mouse_gui_x >= gui_x - button_width/2 && 
              mouse_gui_x <= gui_x + button_width/2 && 
              mouse_gui_y >= gui_y - button_height/2 && 
              mouse_gui_y <= gui_y + button_height/2);

// Set frame based on hover state
if (is_hovered) {
    image_index = 1;  // Lit up frame when hovering
    hover_scale = lerp(hover_scale, 1.1, 0.1);  // Gentle scale up
} else {
    image_index = 0;  // Normal frame when not hovering  
    hover_scale = lerp(hover_scale, 1.0, 0.1);  // Scale back to normal
}

// === ENHANCED EXIT INPUT DETECTION ===
// SAFETY: Combines all exit methods while preserving existing logic

var exit_pressed = false;

// Original ESC key (PRESERVED)
if (keyboard_check_pressed(vk_escape)) {
    exit_pressed = true;
}

// Original mouse click on button (PRESERVED)
if (mouse_check_button_pressed(mb_left) && is_hovered) {
    exit_pressed = true;
}

// NEW: R key for easy keyboard exit during bug catching
if (keyboard_check_pressed(ord("R"))) {
    exit_pressed = true;
}

// NEW: B button on gamepad for easy controller exit during bug catching
// SAFETY: Update input manager first, then check unified input
scr_update_input_manager();
if (input_get_cancel_pressed()) {
    exit_pressed = true;
}

// Execute exit if any input method was used
if (exit_pressed) {
    audio_play_sound(sn_rock_click, 1, false);  // Feedback sound
    room_goto(global.return_room);
}