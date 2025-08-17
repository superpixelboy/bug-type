// Combined Step Event - Hover Detection + Navigation

// COLLECTION BUTTON CLICK DETECTION (always active)
var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)) {
    // Check collection button click (bottom left corner - ALWAYS active)
    var btn_x = 20;
    var btn_y = room_height - 50;
    var btn_width = 100;
    var btn_height = 30;
    
    if (mouse_gui_x >= btn_x && mouse_gui_x <= btn_x + btn_width &&
        mouse_gui_y >= btn_y && mouse_gui_y <= btn_y + btn_height) {
        // Toggle collection
        is_open = !is_open;
        if (!is_open) {
            // Reset everything when closing
            detail_view_open = false;
            detail_bug_key = "";
            detail_bug_data = {};
            hovered_card = -1;
            hover_timer = 0;
        }
    }
}

// Handle TAB key for closing only (not opening)
if (keyboard_check_pressed(vk_tab) || keyboard_check_pressed(vk_escape)) {
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
    // Don't handle opening here - let the button handle that
}

// Only handle hover/navigation when collection is open
if (!is_open) {
    hovered_card = -1;
    hover_timer = 0;
    exit;
}

// Don't handle hover/navigation when detail view is open
if (detail_view_open) {
    hovered_card = -1;
    hover_timer = 0;
    exit;
}

// Check if bug data exists
if (!variable_global_exists("bug_data")) {
    hovered_card = -1;
    hover_timer = 0;
    exit;
}

// Get mouse position in GUI coordinates (already got it above)
// var mouse_gui_x = device_mouse_x_to_gui(0);
// var mouse_gui_y = device_mouse_y_to_gui(0);

// Get all bugs from the data system
var all_bug_keys = variable_struct_get_names(global.bug_data);
var total_bugs = array_length(all_bug_keys);

// Define grid layout (same as draw event)
var cards_per_row = 4;
var rows = 2;
var cards_per_page_grid = cards_per_row * rows; // 8 cards per page
var total_pages = ceil(total_bugs / cards_per_page_grid);
var start_bug = page * cards_per_page_grid;

// Calculate grid positioning (same as draw event)
var grid_start_x = ui_width * 0.2;
var grid_start_y = ui_height * 0.25;
var card_spacing_x = (ui_width * 0.6) / (cards_per_row - 1);
var card_spacing_y = ui_height * 0.35;

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
    
    // Calculate card position
    var card_x = (grid_start_x + (col * card_spacing_x)) * gui_scale;
    var card_y_pos = (grid_start_y + (row * card_spacing_y)) * gui_scale;
    
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

// Update hover timer for wiggle animation
if (hovered_card != -1) {
    if (hover_timer < wiggle_duration) {
        hover_timer += wiggle_speed;
    }
} else {
    hover_timer = 0;
}

// === KEYBOARD NAVIGATION ===
if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
    if (page > 0) {
        page--;
        // Reset hover when changing pages
        hovered_card = -1;
        hover_timer = 0;
    }
}

if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
    if (page < total_pages - 1) {
        page++;
        // Reset hover when changing pages
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
                // Open detail view for this bug
                detail_view_open = true;
                detail_bug_key = bug_key;
                detail_bug_data = global.bug_data[$ bug_key];
                hovered_card = -1; // Clear hover
                hover_timer = 0;
                mouse_handled = true;
            }
        }
    }
    
    // Left arrow click
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
    
    // Right arrow click
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
    
    // Close button click
    if (!mouse_handled) {
        var close_x = (ui_width - 35) * gui_scale;
        var close_y = 15 * gui_scale;
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