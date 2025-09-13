// o_collection_button Step Event - Updated with Multi-Input Support
// SAFETY: All existing mouse functionality preserved, keyboard/controller added

// Reduce global input cooldown (EXISTING LOGIC PRESERVED)
if (variable_global_exists("input_cooldown") && global.input_cooldown > 0) {
    global.input_cooldown--;
}

// Don't process hover/input when collection is open (PRESERVED ORIGINAL LOGIC)
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// Don't process hover/input when pause menu is active (EXISTING LOGIC)
if (instance_exists(o_pause_menu)) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// Don't process hover/input when ANY NPC dialogue is active (EXISTING LOGIC)
with (o_npc_parent) {
    if (dialogue_active) {
        other.is_hovered = false;
        other.hover_scale = lerp(other.hover_scale, 1.0, 0.1);
        exit;
    }
}

// Don't process input during global cooldown (EXISTING LOGIC)
var input_blocked = (variable_global_exists("input_cooldown") && global.input_cooldown > 0);
if (input_blocked) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// ===== MOUSE HOVER DETECTION (EXISTING LOGIC PRESERVED) =====
// SAFETY: Get GUI mouse coordinates for proper detection
var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Calculate actual position to match Draw event exactly (EXISTING LOGIC)
var btn_x = gui_width - btn_margin - (btn_sprite_width * base_scale / 2);
var btn_y = gui_height - btn_margin - (btn_sprite_height * base_scale / 2);

// Calculate button bounds for hover detection (EXISTING LOGIC)
var button_width = btn_sprite_width * base_scale;
var button_height = btn_sprite_height * base_scale;

// Check if mouse is within button bounds (EXISTING LOGIC)
var mouse_hovering = (mouse_gui_x >= btn_x - button_width/2 && 
                      mouse_gui_x <= btn_x + button_width/2 && 
                      mouse_gui_y >= btn_y - button_height/2 && 
                      mouse_gui_y <= btn_y + button_height/2);

// ===== ENHANCED HOVER STATE =====
// SAFETY: Enhanced to show "hover" state for keyboard/controller focus

// NEW: Check if this button should be "focused" by keyboard/controller
var keyboard_focused = false;
var controller_focused = false;

if (variable_global_exists("input_manager")) {
    var last_input = input_get_last_method();
    
    // For keyboard/controller users, always show the button as "focused" 
    // when they're in the game world (not in menus)
    if (last_input == "keyboard" || last_input == "controller") {
        var player_in_world = instance_exists(o_player) && 
                             (!instance_exists(o_bug_collection_ui) || !o_bug_collection_ui.is_open) &&
                             !instance_exists(o_pause_menu);
        
        if (player_in_world) {
            if (last_input == "keyboard") keyboard_focused = true;
            if (last_input == "controller") controller_focused = true;
        }
    }
}

// Combine hover states: mouse hover OR keyboard/controller focus
is_hovered = mouse_hovering || keyboard_focused || controller_focused;

// Smooth hover animation (EXISTING LOGIC PRESERVED)
if (is_hovered) {
    hover_scale = lerp(hover_scale, 1.1, 0.1);
} else {
    hover_scale = lerp(hover_scale, 1.0, 0.1);
}

// ===== MULTI-INPUT CLICK HANDLING WITH COOLDOWN =====
// SAFETY: Mouse only for collection button, let o_player handle C/X

// Original mouse click (PRESERVED) - This is the ONLY input this object should handle
var mouse_clicked = mouse_check_button_pressed(mb_left) && mouse_hovering;

// REMOVED: Keyboard/Controller inputs - let o_player handle these
// This prevents double-triggering between objects

if (mouse_clicked) {
    // Toggle collection menu (EXISTING LOGIC PRESERVED)
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui != noone) {
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
    
    // Play feedback sound (EXISTING LOGIC)
    audio_play_sound(sn_bugtap1, 1, false);
}