// o_bug_collection_ui Step Event - Enhanced with Multi-Input Navigation
// SAFETY: All existing mouse functionality preserved, keyboard/controller added

if (!is_open) {
    exit; // Don't process anything if closed
}

// ===== INPUT HANDLING =====
// SAFETY: Preserve all existing mouse input, add keyboard/controller

// Original mouse input (PRESERVED)
var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

// NEW: Get unified input from input manager
var menu_up_pressed = false;
var menu_down_pressed = false;
var menu_left_pressed = false;
var menu_right_pressed = false;
var interact_pressed = false;
var cancel_pressed = false;

if (variable_global_exists("input_manager")) {
    menu_up_pressed = input_get_menu_up_pressed();
    menu_down_pressed = input_get_menu_down_pressed();
    menu_left_pressed = input_get_menu_left_pressed();
    menu_right_pressed = input_get_menu_right_pressed();
    interact_pressed = input_get_interact_pressed();
    cancel_pressed = input_get_cancel_pressed();
}

// Original keyboard navigation (PRESERVED for compatibility)
var orig_up = keyboard_check_pressed(vk_up);
var orig_down = keyboard_check_pressed(vk_down);
var orig_left = keyboard_check_pressed(vk_left);
var orig_right = keyboard_check_pressed(vk_right);
var orig_enter = keyboard_check_pressed(vk_enter);
var orig_space = keyboard_check_pressed(vk_space);
var orig_escape = keyboard_check_pressed(vk_escape);

// Combine all navigation inputs
var nav_up = orig_up || menu_up_pressed;
var nav_down = orig_down || menu_down_pressed;
var nav_left = orig_left || menu_left_pressed;
var nav_right = orig_right || menu_right_pressed;
var nav_confirm = orig_enter || orig_space || interact_pressed;
var nav_cancel = orig_escape || cancel_pressed;

// ===== CLOSE COLLECTION UI =====
// SAFETY: Enhanced to support multiple close methods

// Original close methods (PRESERVED)
var tab_close = keyboard_check_pressed(vk_tab);
var c_close = keyboard_check_pressed(ord("C"));

// NEW: Unified menu toggle
var unified_menu_close = false;
if (variable_global_exists("input_manager")) {
    unified_menu_close = input_get_menu_toggle_pressed();
}

// Close with cancel input or menu toggle
if (nav_cancel || tab_close || c_close || unified_menu_close) {
    is_open = false;
    detail_view_open = false;
    detail_bug_key = "";
    detail_bug_data = {};
    hovered_card = -1;
    hover_timer = 0;
    audio_play_sound(sn_bugtap1, 1, false);
    exit;
}

// ===== DETAIL VIEW HANDLING =====
if (detail_view_open) {
    // Close detail view with cancel or interact
    if (nav_cancel || nav_confirm) {
        detail_view_open = false;
        detail_bug_key = "";
        detail_bug_data = {};
        audio_play_sound(sn_bugtap1, 1, false);
    }
    exit; // Don't process main collection navigation while in detail view
}

// ===== PAGE NAVIGATION =====
// SAFETY: Enhanced to support keyboard/controller page switching

// Calculate total pages (EXISTING LOGIC)
var bugs_per_page = 12;
var total_bugs = array_length(global.discovered_bugs);
var total_pages = ceil(total_bugs / bugs_per_page);

// Original page navigation with mouse wheel (PRESERVED)
if (mouse_wheel_up()) {
    page = max(0, page - 1);
    hovered_card = -1;
    hover_timer = 0;
    audio_play_sound(sn_bugtap1, 1, false);
}

if (mouse_wheel_down()) {
    page = min(total_pages - 1, page + 1);
    hovered_card = -1;
    hover_timer = 0;
    audio_play_sound(sn_bugtap1, 1, false);
}

// NEW: Keyboard/Controller page navigation
// Use shoulder buttons or specific keys for page navigation
var page_left = false;
var page_right = false;

if (variable_global_exists("input_manager")) {
    // Check for shoulder buttons on controller
    if (global.input_manager.controller_connected) {
        var gp = global.input_manager.controller_slot;
        page_left = gamepad_button_check_pressed(gp, gp_shoulderl);
        page_right = gamepad_button_check_pressed(gp, gp_shoulderr);
    }
}

// Also allow Q/E keys for page navigation (when not in debug mode)
if (!instance_exists(o_bug_selector) || !o_bug_selector.menu_active) {
    page_left = page_left || keyboard_check_pressed(ord("Q"));
    page_right = page_right || keyboard_check_pressed(ord("E"));
}

if (page_left && page > 0) {
    page--;
    hovered_card = -1;
    hover_timer = 0;
    audio_play_sound(sn_bugtap1, 1, false);
}

if (page_right && page < total_pages - 1) {
    page++;
    hovered_card = -1;
    hover_timer = 0;
    audio_play_sound(sn_bugtap1, 1, false);
}

// ===== CARD NAVIGATION SYSTEM =====
// SAFETY: New keyboard/controller card selection without breaking mouse

// Initialize card selection if not set
if (!variable_instance_exists(id, "selected_card")) {
    selected_card = -1; // -1 means no card selected
}

// Calculate cards on current page
var start_index = page * bugs_per_page;
var end_index = min(start_index + bugs_per_page, total_bugs);
var cards_on_page = end_index - start_index;

// NEW: Keyboard/Controller card navigation
if (nav_up || nav_down || nav_left || nav_right) {
    // If no card selected, select the first one
    if (selected_card == -1 && cards_on_page > 0) {
        selected_card = 0;
        audio_play_sound(sn_bugtap1, 1, false);
    } else if (selected_card != -1) {
        var cards_per_row = 4; // Assuming 4 cards per row
        var current_row = selected_card div cards_per_row;
        var current_col = selected_card mod cards_per_row;
        
        var new_row = current_row;
        var new_col = current_col;
        
        if (nav_up) new_row--;
        if (nav_down) new_row++;
        if (nav_left) new_col--;
        if (nav_right) new_col++;
        
        // Clamp to valid ranges
        new_row = clamp(new_row, 0, ceil(cards_on_page / cards_per_row) - 1);
        new_col = clamp(new_col, 0, cards_per_row - 1);
        
        var new_selection = new_row * cards_per_row + new_col;
        
        // Make sure the new selection is valid
        if (new_selection >= 0 && new_selection < cards_on_page) {
            selected_card = new_selection;
            audio_play_sound(sn_bugtap1, 1, false);
        }
    }
}

// NEW: Confirm selection with keyboard/controller
if (nav_confirm && selected_card != -1 && selected_card < cards_on_page) {
    var bug_index = start_index + selected_card;
    if (bug_index >= 0 && bug_index < array_length(global.discovered_bugs)) {
        var bug_key = global.discovered_bugs[bug_index];
        var bug_data = global.bug_data[? bug_key];
        
        if (bug_data != undefined) {
            detail_view_open = true;
            detail_bug_key = bug_key;
            detail_bug_data = bug_data;
            audio_play_sound(sn_bugtap1, 1, false);
        }
    }
}

// ===== MOUSE HOVER SYSTEM (EXISTING LOGIC PRESERVED) =====
// Calculate card positions and check for mouse hover
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

var collection_width = 400;
var collection_height = 300;
var collection_x = (gui_width - collection_width) / 2;
var collection_y = (gui_height - collection_height) / 2;

var card_size = 80;
var card_padding = 10;
var cards_per_row = 4;

hovered_card = -1;

for (var i = 0; i < cards_on_page; i++) {
    var card_row = i div cards_per_row;
    var card_col = i mod cards_per_row;
    
    var card_x = collection_x + 20 + (card_col * (card_size + card_padding));
    var card_y = collection_y + 40 + (card_row * (card_size + card_padding));
    
    // Check mouse hover (EXISTING LOGIC)
    if (mouse_gui_x >= card_x && mouse_gui_x <= card_x + card_size &&
        mouse_gui_y >= card_y && mouse_gui_y <= card_y + card_size) {
        hovered_card = i;
        
        // Mouse hover overrides keyboard selection
        selected_card = i;
        
        // Handle mouse click (EXISTING LOGIC)
        if (mouse_check_button_pressed(mb_left)) {
            var bug_index = start_index + i;
            if (bug_index >= 0 && bug_index < array_length(global.discovered_bugs)) {
                var bug_key = global.discovered_bugs[bug_index];
                var bug_data = global.bug_data[? bug_key];
                
                if (bug_data != undefined) {
                    detail_view_open = true;
                    detail_bug_key = bug_key;
                    detail_bug_data = bug_data;
                    audio_play_sound(sn_bugtap1, 1, false);
                }
            }
        }
        break;
    }
}

// Update hover timer (EXISTING LOGIC)
if (hovered_card != -1) {
    hover_timer++;
} else {
    hover_timer = 0;
}