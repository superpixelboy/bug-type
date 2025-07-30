// o_bug_selector - Create Event
bug_list = [];
selected_index = 0;
menu_active = false;
scroll_offset = 0;
bugs_per_page = 8; // Adjust for your 270px height

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
            rarity: 5  // You can calculate average rarity if needed
        };
        
        array_push(bug_list, bug_entry);
    }
}

depth = -10000;  // Draw on top