// o_bug_collection_ui - Fixed Create Event
// UI state
is_open = false;
page = 0;
bugs_per_page = 4;  // 4 cards horizontally across the book pages

// Base UI dimensions (these are the "design" dimensions)
ui_x = 0;      // Start from left edge
ui_y = 0;      // Start from top edge  
ui_width = 480;   // Full width to match your game resolution
ui_height = 270;  // Full height to match your game resolution

// GUI scale factor for high-resolution display
gui_scale = 2;

// Card positioning (centered on screen)
card_width = 60;        // Smaller card width
card_height = 90;       // Smaller card height
card_start_x = 98;     // Move cards back left a bit to center better
card_y = 135;           // Middle of screen (270/2 = 135)
card_spacing = 95;      // Spacing between cards (fits 4 cards better)

// Track discovered bugs
if (!variable_global_exists("discovered_bugs")) {
    global.discovered_bugs = ds_map_create();
}

// Calculate total bugs and pages dynamically
function update_collection_counts() {
    if (variable_global_exists("bug_data")) {
        var all_bug_keys = variable_struct_get_names(global.bug_data);
        total_bugs = array_length(all_bug_keys);
        total_pages = ceil(total_bugs / bugs_per_page);
    } else {
        total_bugs = 0;
        total_pages = 1;
    }
}

// Initialize counts
update_collection_counts();
depth = -10000;  // Very negative = draws on top

// Add these variables to your existing Create event

// Add these variables to your existing Create event
// Add these variables to your existing Create event

// Hover system
hovered_card = -1; // Which card index is being hovered (-1 = none)
hover_timer = 0; // Timer for wiggle animation
wiggle_speed = 4; // How fast the wiggle animates (halved from 8)
wiggle_amount = 1; // How much the card wiggles in pixels (halved from 2)
wiggle_duration = 30; // How long wiggle lasts (30 frames = 0.5 seconds at 60fps)

// Detail view system
detail_view_open = false; // Is the detail view currently open?
detail_bug_key = ""; // Which bug is being shown in detail
detail_bug_data = {}; // The bug data for detail view