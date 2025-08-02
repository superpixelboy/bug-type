// o_bug_collection_ui - Updated Create Event
// UI state
is_open = false;
page = 0;
bugs_per_page = 4;  // 2x2 grid - very spacious
ui_x = 40;
ui_y = 20;
ui_width = 400;
ui_height = 230;

// NO MORE HARDCODED ARRAYS - Use the global bug data instead!
// The bug data is now dynamic and pulled from global.bug_data

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