// o_bug_collection_ui Step Event - FIXED HOVER SYSTEM
// Let o_collection_button handle all opening/closing

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
    exit;
}


// In o_bug_collection_ui Step_0 Event - Matching fine-tuned positioning

// Calculate grid positioning (MATCH the Draw event exactly)
var left_page_center = ui_width * 0.31;   // Same as draw event (was 0.32)
var right_page_center = ui_width * 0.69;  // Same as draw event (was 0.68)

var grid_start_y = ui_height * 0.30;      // Same as draw event (was 0.29)
var card_spacing_y = ui_height * 0.36;    // Same as draw event

// Calculate horizontal spacing for 2 cards per page
var horizontal_spread = ui_width * 0.15;  // Same as draw event
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

// Check if bug data exists
if (!variable_global_exists("bug_data")) {
    hovered_card = -1;
    hover_timer = 0;
    exit;
}

// Get all bugs from the data system
var all_bug_keys = variable_struct_get_names(global.bug_data);
var total_bugs = array_length(all_bug_keys);

// Define grid layout (same as draw event)
var cards_per_row = 4;
var rows = 2;
var cards_per_page_grid = cards_per_row * rows; // 8 cards per page
var total_pages = ceil(total_bugs / cards_per_page_grid);
var start_bug = page * cards_per_page_grid;





// Collection scale
var collection_scale = 0.4;
var card_w_scaled = sprite_get_width(s_card_template) * collection_scale * gui_scale;
var card_h_scaled = sprite_get_height(s_card_template) * collection_scale * gui_scale;

// === HOVER DETECTION ===
// Reset hovered card
var old_hovered = hovered_card;
hovered_card = -1;

// Check each card for mouse hover
for (var i = 0; i < cards_per_page_grid; i++) {
    var bug_index = start_bug + i;
    if (bug_index >= total_bugs) break;
    
    // Get bug data to check if unlocked
    var bug_key = all_bug_keys[bug_index];
    var is_discovered = ds_map_exists(global.discovered_bugs, bug_key);
    
    // Only check hover for unlocked cards
    if (!is_discovered) continue;
    
 // Calculate row and column
    var row = floor(i / cards_per_row);
    var col = i % cards_per_row;
    
    // Calculate card position (MATCH draw event exactly)
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
    
    // Check if mouse is over this card
    var card_left = card_x - (card_w_scaled * 0.5);
    var card_right = card_x + (card_w_scaled * 0.5);
    var card_top = card_y_pos - (card_h_scaled * 0.5);
    var card_bottom = card_y_pos + (card_h_scaled * 0.5);
    
    if (mouse_gui_x >= card_left && mouse_gui_x <= card_right &&
        mouse_gui_y >= card_top && mouse_gui_y <= card_bottom) {
        hovered_card = i;
        break;
    }
}

// FIXED: Update hover timer with snappier timing
if (hovered_card != -1) {
    if (hover_timer < 12) { // 12 frames to reach full hover effect (snappier)
        hover_timer += 1.5; // Faster fade-in
    }
} else {
    if (hover_timer > 0) {
        hover_timer -= 3; // Even faster fade-out for snappy feel
    }
}

// === KEYBOARD NAVIGATION ===
if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
    if (page > 0) {
        page--;
        hovered_card = -1;
        hover_timer = 0;
    }
}

if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
    if (page < total_pages - 1) {
        page++;
        hovered_card = -1;
        hover_timer = 0;
    }
}

// === MOUSE NAVIGATION ===
if (mouse_check_button_pressed(mb_left)) {
    var mouse_handled = false;
    
    // Check if clicking on a hovered unlocked card first
    if (hovered_card != -1 && !mouse_handled) {
        var bug_index = start_bug + hovered_card;
        if (bug_index < total_bugs) {
            var bug_key = all_bug_keys[bug_index];
            var is_discovered = ds_map_exists(global.discovered_bugs, bug_key);
            
            if (is_discovered) {
                // Create and show the bug card popup (like when catching)
                if (scr_collection_show_card(bug_key)) {
                    // DON'T close the collection - just hide it temporarily
                    // Collection will become visible again when card is closed
                    hovered_card = -1;
                    hover_timer = 0;
                }
                mouse_handled = true;
            }
        }
    }
    
    // Left arrow click (matches your draw event positioning)
    if (!mouse_handled && total_pages > 1 && page > 0) {
        var left_arrow_x = 60 * gui_scale;
        var left_arrow_y = (ui_height/2) * gui_scale;
        var arrow_size = 20 * gui_scale;
        
        if (point_distance(mouse_gui_x, mouse_gui_y, left_arrow_x, left_arrow_y) < arrow_size) {
            page--;
            hovered_card = -1;
            hover_timer = 0;
            mouse_handled = true;
        }
    }
    
    // Right arrow click (matches your draw event positioning)
    if (!mouse_handled && total_pages > 1 && page < total_pages - 1) {
        var right_arrow_x = (ui_width - 30) * gui_scale;
        var right_arrow_y = (ui_height/2) * gui_scale;
        var arrow_size = 20 * gui_scale;
        
        if (point_distance(mouse_gui_x, mouse_gui_y, right_arrow_x, right_arrow_y) < arrow_size) {
            page++;
            hovered_card = -1;
            hover_timer = 0;
            mouse_handled = true;
        }
    }
    
    // Close button click (matches your draw event positioning)
	if (!mouse_handled) {
	    var close_x = (ui_width - 35) * gui_scale;
	    var close_y = 5 * gui_scale;  // Updated to match draw event
	    var close_size = 20 * gui_scale;
    
	    if (mouse_gui_x >= close_x && mouse_gui_x <= close_x + close_size &&
	        mouse_gui_y >= close_y && mouse_gui_y <= close_y + close_size) {
	        is_open = false;
	        hovered_card = -1;
	        hover_timer = 0;
	        mouse_handled = true;
	    }
	}
}