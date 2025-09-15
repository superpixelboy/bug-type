// o_bug_collection_ui Step Event - ORIGINAL CODE with just repositioned buttons

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
// Move left arrow down and left, right arrow down and right
var left_arrow_x = (60 - 20) * gui_scale + arrow_hover_offset; // Move LEFT by 20 pixels
var left_arrow_y = screen_center_y - (20 - 15) * gui_scale; // Move DOWN by 15 pixels (was -20, now -5)
var right_arrow_x = (ui_width - 60 + 20) * gui_scale - arrow_hover_offset; // Move RIGHT by 20 pixels  
var right_arrow_y = screen_center_y - (20 - 15) * gui_scale; // Move DOWN by 15 pixels (was -20, now -5)
var close_x = (ui_width - 64) * gui_scale; // Match Draw Event exactly
var close_y = 12 * gui_scale; // Match Draw Event exactly

var arrow_size = 20 * gui_scale; // Hit area for arrows
var close_size = 30 * gui_scale; // Larger hit area for close button (was 20, now 30)

// Check button hover states
button_hover_states.left_arrow = (total_pages > 1 && page > 0 && 
    point_distance(mouse_gui_x, mouse_gui_y, left_arrow_x, left_arrow_y) < arrow_size);
    
button_hover_states.right_arrow = (total_pages > 1 && page < total_pages - 1 && 
    point_distance(mouse_gui_x, mouse_gui_y, right_arrow_x, right_arrow_y) < arrow_size);
    
button_hover_states.close_button = (mouse_gui_x >= close_x && mouse_gui_x <= close_x + close_size &&
    mouse_gui_y >= close_y && mouse_gui_y <= close_y + close_size);

// If a collection card is showing, only allow ESC to close collection
if (instance_exists(o_bug_card_collection)) {
    // Still allow ESC to close the entire collection
    if (keyboard_check_pressed(vk_escape)) {
        // Close both the card and collection
        with(o_bug_card_collection) instance_destroy();
        is_open = false;
        hovered_card = -1;
        hover_timer = 0;
    }
    exit;
}

// Don't handle hover/navigation when detail view is open
if (detail_view_open) {
    // Handle clicks to close detail view
    if (mouse_check_button_pressed(mb_left)) {
        detail_view_open = false;
        detail_bug_key = "";
        detail_bug_data = {};
        hovered_card = -1;
        hover_timer = 0;
    }
    exit;
}

// Check for mouse hover over cards using ORIGINAL positioning
if (variable_global_exists("bug_data")) {
    var all_bug_keys = variable_struct_get_names(global.bug_data);
    var total_bugs = array_length(all_bug_keys);
    var cards_per_page_grid = 8; // 4x2 grid
    var start_bug = page * cards_per_page_grid;
    
    var old_hovered_card = hovered_card;
    var mouse_hovered_card = -1; // Track mouse hover separately
    
    // ORIGINAL MOUSE HOVER DETECTION (unchanged)
    for (var i = 0; i < cards_per_page_grid && start_bug + i < total_bugs; i++) {
        var bug_index = start_bug + i;
        var row = floor(i / 4);
        var col = i % 4;
        
        // Use ORIGINAL positioning logic (matching draw event exactly)
        var card_x, card_y_pos;
        if (col < 2) {
            // Left page (columns 0 and 1)
            var local_col = col; // 0 or 1
            card_x = (left_page_center + ((local_col - 0.5) * horizontal_spread)) * gui_scale;
        } else {
            // Right page (columns 2 and 3)
            var local_col = col - 2; // 0 or 1 (relative to right page)
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
    
    // NEW: COMBINED HOVER STATE LOGIC
    // Seamlessly switch between mouse and keyboard selection
    if (last_input_method == "mouse") {
        // Mouse mode: use mouse hover, disable keyboard selection
        hovered_card = mouse_hovered_card;
        if (mouse_hovered_card == -1) {
            keyboard_selected_card = -1; // Clear keyboard selection when mouse isn't hovering
        }
    } else if (last_input_method == "keyboard" && keyboard_navigation_active) {
        // Keyboard mode: use keyboard selection, ignore mouse hover
        hovered_card = keyboard_selected_card;
    } else {
        // Fallback: no selection
        hovered_card = -1;
    }
    
    // ORIGINAL HOVER TIMER LOGIC (unchanged)
    // Update hover timer for smooth scaling
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

// Handle mouse clicks
if (mouse_check_button_pressed(mb_left)) {
    var mouse_handled = false;
    
    // Card clicks
    if (hovered_card != -1 && variable_global_exists("bug_data")) {
        var all_bug_keys = variable_struct_get_names(global.bug_data);
        var cards_per_page_grid = 8;
        var start_bug = page * cards_per_page_grid;
        var bug_index = start_bug + hovered_card;
        
        if (bug_index < array_length(all_bug_keys)) {
            var bug_key = all_bug_keys[bug_index];
            if (ds_map_exists(global.discovered_bugs, bug_key)) {
                if (scr_collection_show_card(bug_key,id)) {
                    hovered_card = -1;
                    hover_timer = 0;
                }
                mouse_handled = true;
            }
        }
    }
    
    // Left arrow click - using NEW position
   if (!mouse_handled && button_hover_states.left_arrow) {
    page--;
    hovered_card = -1;
    hover_timer = 0;
    keyboard_selected_card = -1; // NEW: Reset keyboard selection
    mouse_handled = true;
}

// In your EXISTING right arrow click handler, ADD this line:
if (!mouse_handled && button_hover_states.right_arrow) {
    page++;
    hovered_card = -1;
    hover_timer = 0;
    keyboard_selected_card = -1; // NEW: Reset keyboard selection
    mouse_handled = true;
}
    
    // Close button click - using NEW position
    if (!mouse_handled && button_hover_states.close_button) {
        is_open = false;
        hovered_card = -1;
        hover_timer = 0;
        mouse_handled = true;
    }
}

// Handle keyboard/gamepad page navigation (NEW - minimal addition)
if (total_pages > 1) {
    // Page Left: Left Arrow or Left Bumper
    if (input_get_page_left_pressed() && page > 0) {
        page--;
        hovered_card = -1;
        hover_timer = 0;
        // Optional: Add sound feedback
        // audio_play_sound(sn_bugtap1, 1, false);
    }
    
    // Page Right: Right Arrow or Right Bumper  
    if (input_get_page_right_pressed() && page < total_pages - 1) {
        page++;
        hovered_card = -1;
        hover_timer = 0;
        // Optional: Add sound feedback
        // audio_play_sound(sn_bugtap1, 1, false);
    }
}


// ===== NEW: KEYBOARD/GAMEPAD CARD NAVIGATION =====
// SAFETY: This runs before mouse hover detection to set up keyboard selection

// Detect input method for seamless switching
var mouse_moved = (mouse_gui_x != xprevious || mouse_gui_y != yprevious);
if (mouse_moved) {
    last_input_method = "mouse";
    keyboard_navigation_active = false;
}

// Get WASD/D-pad input for card navigation
var nav_up = input_get_menu_up_pressed();
var nav_down = input_get_menu_down_pressed(); 
var nav_left = input_get_menu_left_pressed();
var nav_right = input_get_menu_right_pressed();

// If any navigation input was pressed, switch to keyboard mode
if (nav_up || nav_down || nav_left || nav_right) {
    last_input_method = "keyboard";
    keyboard_navigation_active = true;
    
    // Initialize keyboard selection if not set
    if (keyboard_selected_card == -1) {
        keyboard_selected_card = 0; // Start at first card
    }
    
    // Calculate current row/col from keyboard_selected_card (0-7)
    var current_row = floor(keyboard_selected_card / 4); // 0 or 1
    var current_col = keyboard_selected_card % 4;         // 0-3
    
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

	if (input_get_page_left_pressed() && page > 0) {
	    page--;
	    hovered_card = -1;
	    hover_timer = 0;
	    keyboard_selected_card = -1; // NEW: Reset keyboard selection
	}

	// Page Right: Right Arrow or Right Bumper  
	if (input_get_page_right_pressed() && page < total_pages - 1) {
	    page++;
	    hovered_card = -1;
	    hover_timer = 0;
	    keyboard_selected_card = -1; // NEW: Reset keyboard selection
	}
}

// Handle Space/A button selection for keyboard users
var select_pressed = input_get_menu_select_pressed();
if (select_pressed && keyboard_navigation_active && keyboard_selected_card != -1) {
    // Use the same card selection logic as mouse clicks
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
}