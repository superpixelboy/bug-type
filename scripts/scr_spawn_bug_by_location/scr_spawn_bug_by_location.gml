function scr_spawn_bug_by_location(spawn_x, spawn_y, location, rock_type) {
    
    // DEBUG: Check if our data exists
    show_debug_message("Current location: " + string(location));
    show_debug_message("Bug data exists: " + string(variable_global_exists("bug_data")));
    
    if (!variable_global_exists("bug_data")) {
        show_debug_message("ERROR: global.bug_data not initialized!");
        return instance_create_layer(spawn_x, spawn_y, "Bugs", o_empty_rock);
    }
    
    // Get all bugs that can spawn in this location
    var available_bugs = [];
    var bug_names = variable_struct_get_names(global.bug_data);
    
    for (var i = 0; i < array_length(bug_names); i++) {
        var bug_key = bug_names[i];
        var bug_data = variable_struct_get(global.bug_data, bug_key);  // FIXED LINE
        
        // Check if this bug can spawn in current location
        if (variable_struct_exists(bug_data.locations, location)) {
            var rarity = variable_struct_get(bug_data.locations, location);  // ALSO FIXED
            
            // Skip bugs marked with "x" (not found here)
            if (rarity != "x") {
                // Convert rarity to spawn weight
                var weight = 11 - rarity;
                
                // Add multiple entries based on weight for probability
                for (var j = 0; j < weight; j++) {
                    array_push(available_bugs, bug_key);
                }
            }
        }
    }
    
    // If no bugs available, return empty rock
    if (array_length(available_bugs) == 0) {
        return instance_create_layer(spawn_x, spawn_y, "Bugs", o_empty_rock);
    }
    
    // Randomly select from weighted array
    var selected_bug = available_bugs[irandom(array_length(available_bugs) - 1)];
    
    // Create the bug instance
	var bug_instance = instance_create_layer(spawn_x, spawn_y, "Bugs", o_bug_parent);
bug_instance.bug_type = selected_bug;

// Load the bug data directly
with (bug_instance) {
    if (variable_struct_exists(global.bug_data, bug_type)) {
        var data = global.bug_data[$ bug_type];
        bug_name = data.name;
        flavor_text = data.flavor_text;
        sprite_index = data.sprite;
        bug_hp = data.hp;
        bug_max_hp = data.hp;
        current_hp = bug_hp;
        essence_value = data.essence;
    }
}
    return bug_instance;
}