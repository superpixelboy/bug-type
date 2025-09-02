// o_bug_selector - Enhanced Create Event with Essence & Multi-Spawn
bug_list = [];
selected_index = 0;
menu_active = false;
scroll_offset = 0;
bugs_per_page = 6; // Reduced to make room for essence controls

// NEW: Console mode tracking
console_mode = "bugs"; // "bugs", "essence", "auto_unlock"
essence_input_value = string(global.essence);
unlock_count_input = "1";
selected_bug_for_unlock = 0;

// Input state
input_active = false;
input_cursor = 0;
input_blink_timer = 0;

// Load all bugs from your bug data
if (variable_global_exists("bug_data")) {
    var bug_keys = variable_struct_get_names(global.bug_data);
    
    for (var i = 0; i < array_length(bug_keys); i++) {
        var bug_key = bug_keys[i];
        var bug_data = global.bug_data[$ bug_key];
        
        // Create a simplified bug entry for the menu
        var bug_entry = {
            id: bug_key,
            name: bug_data.name,
            essence: bug_data.essence
        };
        
        array_push(bug_list, bug_entry);
    }
}

depth = -10000;  // Draw on top