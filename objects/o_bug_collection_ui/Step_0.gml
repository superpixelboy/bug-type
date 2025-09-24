// o_bug_collection_ui Step Event - CLEANED UP VERSION

var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

// Handle ESCAPE key for closing only (Tab handled by UI Manager)
if (keyboard_check_pressed(vk_escape)) {
    if (is_open && detail_view_open) {
        // Close detail view first
        detail_view_open = false;
        detail_bug_key = "";
        detail_bug_data = {};
        hovered_card = -1;
        hover_timer = 0;
    } else if (is_open) {
        // Close collection
        is_open = false;
        hovered_card = -1;
        hover_timer = 0;
    }
}

// Only handle hover/navigation when collection is open
if (!is_open) {
    hovered_card = -1;
    hover_timer = 0;
    // Reset button states when closed
    button_hover_states.left_arrow = false;
    button_hover_states.right_arrow = false;
    button_hover_states.close_button = false;
    exit;
}

// Update arrow animation timer
arrow_animation_timer += 0.05; // Slow, gentle oscillation
arrow_hover_offset = sin(arrow_animation_timer) * 2; // 2 pixel movement back and forth

// Calculate grid positioning (MATCH the Draw event exactly)
var left_page_center = ui_width * 0.31;   // Same as draw event
var right_page_center = ui_width * 0.69;  // Same as draw event
var grid_start_y = ui_height * 0.30;      // Same as draw event
var card_spacing_y = ui_height * 0.36;    // Same as draw event
var horizontal_spread = ui_width * 0.15;  // Same as draw event

// Calculate screen center for button positioning_
var screen_center_x = (480 / 2) * gui_scale;
var screen_center_y = (270 / 2) * gui_scale;
var book_scale = gui_scale * .5;

// Calculate adjusted button positions to match where sprites are ACTUALLY drawn
var left_arrow_x = (60 - 20) * gui_scale + arrow_hover_offset;
var left_arrow_y = screen_center_y - (20 - 15) * gui_scale;
var right_arrow_x = (ui_width - 60 + 20) * gui_scale - arrow_hover_offset;
var right_arrow_y = screen_center_y - (20 - 15) * gui_scale;
var close_x = (ui_width - 64) * gui_scale;
var close_y = 12 * gui_scale;

var arrow_size = 20 * gui_scale;
var close_size = 30 * gui_scale;

// Check button hover states
button_hover_states.left_arrow = (total_pages > 1 && page > 0 && 
    point_distance(mouse_gui_x, mouse_gui_y, left_arrow_x, left_arrow_y) < arrow_size);
    
button_hover_states.right_arrow = (total_pages > 1 && page < total_pages - 1 && 
    point_distance(mouse_gui_x, mouse_gui_y, right_arrow_x, right_arrow_y) < arrow_size);
    
button_hover_states.close_button = (mouse_gui_x >= close_x && mouse_gui_x <= close_x + close_size &&
    mouse_gui_y >= close_y && mouse_gui_y <= close_y + close_size);

// If a collection card is showing, only allow ESC to close collection
if (instance_exists(o_bug_card_collection)) {
    if (keyboard_check_pressed(vk_escape)) {
        with(o_bug_card_collection) instance_destroy();
        is_open = false;
        hovered_card = -1;
        hover_timer = 0;
    }
    exit;
}

// Don't handle hover/navigation when detail view is open
if (detail_view_open) {
    if (mouse_check_button_pressed(mb_left)) {
        detail_view_open = false;
        detail_bug_key = "";
        detail_bug_data = {};
        hovered_card = -1;
        hover_timer = 0;
    }
    exit;
}

// === TAB SWITCHING INPUT (EARLY - BEFORE CARD NAVIGATION) ===
if (tab_click_cooldown > 0) {
    tab_click_cooldown--;
}

var _old_tab = current_tab;

// Gamepad ONLY: L/R triggers to switch tabs (removed keyboard arrow keys)
if (gamepad_is_connected(0)) {
    if (gamepad_button_check_pressed(0, gp_shoulderlb) && tab_click_cooldown == 0) {
        current_tab--;
        if (current_tab < 0) current_tab = total_tabs - 1;
        tab_click_cooldown = 10;
    }
    if (gamepad_button_check_pressed(0, gp_shoulderrb) && tab_click_cooldown == 0) {
        current_tab++;
        if (current_tab >= total_tabs) current_tab = 0;
        tab_click_cooldown = 10;
    }
}

// Mouse: Click detection on tabs
var _gui_mouse_x = device_mouse_x_to_gui(0);
var _gui_mouse_y = device_mouse_y_to_gui(0);

// Tab positions (must match Draw GUI positions exactly!)
var _collection_x = 50; // Moved left and up
var _collection_y = 70; // Moved up

var _items_x = 50; // Moved left and up
var _items_y = 200; // Moved up

var _todo_x = 50;   // New third tab
var _todo_y = 330;  // Below items

// Get sprite dimensions for click detection
var _tab_width = sprite_get_width(s_collection_tab);
var _tab_height = sprite_get_height(s_collection_tab);

tab_hover_index = -1;

// Check Collection tab (tab 0)
if (point_in_rectangle(_gui_mouse_x, _gui_mouse_y,
    _collection_x, _collection_y,
    _collection_x + _tab_width, _collection_y + _tab_height)) {
    tab_hover_index = 0;
    
    if (mouse_check_button_pressed(mb_left) && tab_click_cooldown == 0) {
        current_tab = 0;
        tab_click_cooldown = 10;
    }
}

// Check Items tab (tab 1)
if (point_in_rectangle(_gui_mouse_x, _gui_mouse_y,
    _items_x, _items_y,
    _items_x + _tab_width, _items_y + _tab_height)) {
    tab_hover_index = 1;
    
    if (mouse_check_button_pressed(mb_left) && tab_click_cooldown == 0) {
        current_tab = 1;
        tab_click_cooldown = 10;
    }
}

// Check To Do tab (tab 2) - NEW
if (point_in_rectangle(_gui_mouse_x, _gui_mouse_y,
    _todo_x, _todo_y,
    _todo_x + _tab_width, _todo_y + _tab_height)) {
    tab_hover_index = 2;
    
    if (mouse_check_button_pressed(mb_left) && tab_click_cooldown == 0) {
        current_tab = 2;
        tab_click_cooldown = 10;
    }
}

// If tab changed, play sound and reset to page 0
if (_old_tab != current_tab) {
    audio_play_sound(sn_rock_click, 1, false);
    
    // SAFETY: Reset to first page when switching tabs
    page = 0;
    selected_card_index = 0;
    hovered_card = -1;
    hover_timer = 0;
    keyboard_selected_card = -1;
}


// ===== KEYBOARD/GAMEPAD CARD NAVIGATION =====
// Detect input method for seamless switching
if (!variable_instance_exists(id, "prev_mouse_gui_x")) {
    prev_mouse_gui_x = mouse_gui_x;
    prev_mouse_gui_y = mouse_gui_y;
}

var mouse_moved = (mouse_gui_x != prev_mouse_gui_x || mouse_gui_y != prev_mouse_gui_y);
if (mouse_moved) {
    last_input_method = "mouse";
    keyboard_navigation_active = false;
    prev_mouse_gui_x = mouse_gui_x;
    prev_mouse_gui_y = mouse_gui_y;
}

// Get WASD/D-pad input for card navigation
var nav_up = input_get_menu_up_pressed();
var nav_down = input_get_menu_down_pressed(); 
var nav_left = input_get_menu_left_pressed();
var nav_right = input_get_menu_right_pressed();

// Better input method detection
if (nav_up || nav_down || nav_left || nav_right) {
    var using_keyboard = keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down) || 
                        keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) ||
                        keyboard_check_pressed(ord("W")) || keyboard_check_pressed(ord("A")) ||
                        keyboard_check_pressed(ord("S")) || keyboard_check_pressed(ord("D"));
    
    if (using_keyboard) {
        last_input_method = "keyboard";
    } else {
        last_input_method = "gamepad";
    }
    
    keyboard_navigation_active = true;
    
    // Initialize keyboard selection if not set
    if (keyboard_selected_card == -1) {
        keyboard_selected_card = 0;
    }
    
    // Calculate current row/col from keyboard_selected_card (0-7)
    var current_row = floor(keyboard_selected_card / 4);
    var current_col = keyboard_selected_card % 4;
    
    // Handle navigation with grid wrapping
    if (nav_up && current_row > 0) {
        current_row--;
    } else if (nav_down && current_row < 1) {
        current_row++;
    } else if (nav_left && current_col > 0) {
        current_col--;
    } else if (nav_right && current_col < 3) {
        current_col++;
    }
    
    // Convert back to card index (0-7)
    var new_selected = current_row * 4 + current_col;
    
    // Make sure we don't select a card that doesn't exist on this page
    if (variable_global_exists("bug_data")) {
        var all_bug_keys = variable_struct_get_names(global.bug_data);
        var total_bugs = array_length(all_bug_keys);
        var cards_per_page_grid = 8;
        var start_bug = page * cards_per_page_grid;
        var max_card_on_page = min(cards_per_page_grid, total_bugs - start_bug) - 1;
        
        if (new_selected <= max_card_on_page) {
            keyboard_selected_card = new_selected;
        }
    }
}

// ===== COMBINED HOVER DETECTION =====
if (variable_global_exists("bug_data")) {
    var all_bug_keys = variable_struct_get_names(global.bug_data);
    var total_bugs = array_length(all_bug_keys);
    var cards_per_page_grid = 8;
    var start_bug = page * cards_per_page_grid;
    
    var old_hovered_card = hovered_card;
    var mouse_hovered_card = -1;
    
    // Mouse hover detection
    for (var i = 0; i < cards_per_page_grid && start_bug + i < total_bugs; i++) {
        var bug_index = start_bug + i;
        var row = floor(i / 4);
        var col = i % 4;
        
        var card_x, card_y_pos;
        if (col < 2) {
            var local_col = col;
            card_x = (left_page_center + ((local_col - 0.5) * horizontal_spread)) * gui_scale;
        } else {
            var local_col = col - 2;
            card_x = (right_page_center + ((local_col - 0.5) * horizontal_spread)) * gui_scale;
        }
        card_y_pos = (grid_start_y + (row * card_spacing_y)) * gui_scale;
        
        var card_w = sprite_get_width(s_card_template) * 0.4 * gui_scale;
        var card_h = sprite_get_height(s_card_template) * 0.4 * gui_scale;
        
        if (mouse_gui_x >= card_x - card_w/2 && mouse_gui_x <= card_x + card_w/2 &&
            mouse_gui_y >= card_y_pos - card_h/2 && mouse_gui_y <= card_y_pos + card_h/2) {
            mouse_hovered_card = i;
            break;
        }
    }
    
    // COMBINED HOVER STATE LOGIC
    if (last_input_method == "mouse") {
        hovered_card = mouse_hovered_card;
        if (mouse_hovered_card == -1) {
            keyboard_selected_card = -1;
        }
    } else if (last_input_method == "keyboard" || last_input_method == "gamepad") {
        if (keyboard_navigation_active) {
            hovered_card = keyboard_selected_card;
        }
    } else {
        hovered_card = -1;
    }
    
    // Hover timer logic
    if (hovered_card != -1) {
        if (old_hovered_card == hovered_card) {
            hover_timer = min(20, hover_timer + 1);
        } else {
            hover_timer = 0;
        }
    } else {
        hover_timer = max(0, hover_timer - 2);
    }
}

// Handle Space/A button selection for keyboard users
var select_pressed = input_get_menu_select_pressed();
if (select_pressed && keyboard_navigation_active && keyboard_selected_card != -1) {
    
    if (current_tab == 0) {
        // COLLECTION TAB - Bug cards (existing logic)
        if (variable_global_exists("bug_data")) {
            var all_bug_keys = variable_struct_get_names(global.bug_data);
            var cards_per_page_grid = 8;
            var start_bug = page * cards_per_page_grid;
            var bug_index = start_bug + keyboard_selected_card;
            
            if (bug_index < array_length(all_bug_keys)) {
                var bug_key = all_bug_keys[bug_index];
                if (ds_map_exists(global.discovered_bugs, bug_key)) {
                    if (scr_collection_show_card(bug_key, id)) {
                        keyboard_selected_card = -1;
                        hovered_card = -1;
                        hover_timer = 0;
                    }
                }
            }
        }
        
    } else if (current_tab == 1) {
        // ITEMS TAB - Item cards (NEW)
        var discovered_items = scr_get_discovered_items();
        var cards_per_page_grid = 8;
        var start_item = page * cards_per_page_grid;
        var item_index = start_item + keyboard_selected_card;
        
        if (item_index < array_length(discovered_items)) {
            var item_data = discovered_items[item_index];
            if (scr_collection_show_item_card(item_data)) {
                keyboard_selected_card = -1;
                hovered_card = -1;
                hover_timer = 0;
            }
        }
    }
}

// Handle mouse clicks
if (mouse_check_button_pressed(mb_left)) {
    var mouse_handled = false;
    
    // Card clicks - CHECK CURRENT TAB
    if (hovered_card != -1) {
        
        if (current_tab == 0) {
            // COLLECTION TAB - Bug cards (your existing code)
            if (variable_global_exists("bug_data")) {
                var all_bug_keys = variable_struct_get_names(global.bug_data);
                var cards_per_page_grid = 8;
                var start_bug = page * cards_per_page_grid;
                var bug_index = start_bug + hovered_card;
                
                if (bug_index < array_length(all_bug_keys)) {
                    var bug_key = all_bug_keys[bug_index];
                    if (ds_map_exists(global.discovered_bugs, bug_key)) {
                        if (scr_collection_show_card(bug_key, id)) {
                            hovered_card = -1;
                            hover_timer = 0;
                        }
                        mouse_handled = true;
                    }
                }
            }
            
        } else if (current_tab == 1) {
            // ITEMS TAB - Item cards (NEW)
            var discovered_items = scr_get_discovered_items();
            var cards_per_page_grid = 8;
            var start_item = page * cards_per_page_grid;
            var item_index = start_item + hovered_card;
            
            if (item_index < array_length(discovered_items)) {
                var item_data = discovered_items[item_index];
                if (scr_collection_show_item_card(item_data)) {
                    hovered_card = -1;
                    hover_timer = 0;
                }
                mouse_handled = true;
            }
        }
    }
    
    // Arrow clicks
    if (!mouse_handled && button_hover_states.left_arrow) {
        page--;
        hovered_card = -1;
        hover_timer = 0;
        keyboard_selected_card = -1;
        mouse_handled = true;
    }
    
    if (!mouse_handled && button_hover_states.right_arrow) {
        page++;
        hovered_card = -1;
        hover_timer = 0;
        keyboard_selected_card = -1;
        mouse_handled = true;
    }
    
    // Close button click
    if (!mouse_handled && button_hover_states.close_button) {
        is_open = false;
        hovered_card = -1;
        hover_timer = 0;
        mouse_handled = true;
    }
}

// Handle keyboard/gamepad page navigation
if (total_pages > 1) {
    if (input_get_page_left_pressed() && page > 0) {
        page--;
        hovered_card = -1;
        hover_timer = 0;
        keyboard_selected_card = -1;
    }
    
    if (input_get_page_right_pressed() && page < total_pages - 1) {
        page++;
        hovered_card = -1;
        hover_timer = 0;
        keyboard_selected_card = -1;
    }
}


// ADD this debug code to your Step event right after the hover timer logic

// DEBUG: Show all the key values
if (keyboard_navigation_active) {
    show_debug_message("Nav Active - Selected: " + string(keyboard_selected_card) + 
                      " | Hovered: " + string(hovered_card) + 
                      " | Timer: " + string(hover_timer) +
                      " | Method: " + last_input_method);
}


// DEBUG: Show keyboard navigation state
if (keyboard_navigation_active) {
    show_debug_message("Nav Active - Selected: " + string(keyboard_selected_card) + 
                      " | Hovered: " + string(hovered_card) + 
                      " | Method: " + last_input_method);
}

