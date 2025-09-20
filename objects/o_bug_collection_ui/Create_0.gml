// o_bug_collection_ui - Create Event with Animation Variables
// UI state
is_open = false;
page = 0;
// FIXED: Match the actual grid layout used in Draw event
cards_per_page = 8;  // 4x2 grid = 8 cards per page (was incorrectly 4)

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
        // FIXED: Use correct cards per page (8, not 4)
        total_pages = ceil(total_bugs / cards_per_page);
    } else {
        total_bugs = 0;
        total_pages = 1;
    }
}

// Initialize counts
update_collection_counts();
depth = -10000;  // Very negative = draws on top

// FIXED: Hover system - removed conflicting variables
hovered_card = -1; // Which card index is being hovered (-1 = none)
hover_timer = 0; // Timer for smooth scale/shadow animation (0-20 frames)

// Detail view system
detail_view_open = false; // Is the detail view currently open?
detail_bug_key = ""; // Which bug is being shown in detail
detail_bug_data = {}; // The bug data for detail view

// NEW: Button animation system
arrow_hover_offset = 0; // Gentle back-and-forth movement for arrows
arrow_animation_timer = 0; // Timer for smooth animation
button_hover_states = {
    left_arrow: false,
    right_arrow: false,
    close_button: false
}


// ===== NEW: KEYBOARD/GAMEPAD CARD SELECTION =====
keyboard_selected_card = -1; // Which card is selected via keyboard (-1 = none)
last_input_method = "mouse"; // Track if user is using "mouse" or "keyboard"
keyboard_navigation_active = false; // Is keyboard navigation currently active?


// === TAB SYSTEM ===
// SAFETY: These variables control tab switching - don't change names as they'll be referenced in Step/Draw
current_tab = 0; // 0 = collection, 1 = items
total_tabs = 2;

// Tab hover/click detection
tab_hover_index = -1; // Which tab is being hovered (-1 = none)
tab_click_cooldown = 0; // Prevent rapid tab switching