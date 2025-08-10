// Debug version of scr_spawn_bug_by_location
function scr_spawn_bug_by_location(spawn_x, spawn_y, location, rock_type) {
    
    show_debug_message("=== SPAWNING BUG ===");
    show_debug_message("Location: " + string(location));
    show_debug_message("Rock type: " + string(rock_type));
    
    if (!variable_global_exists("bug_data")) {
        show_debug_message("ERROR: global.bug_data not initialized!");
        return instance_create_layer(spawn_x, spawn_y, "Bugs", o_empty_rock);
    }
    
    // Get all bugs that can spawn in this location
    var available_bugs = [];
    var bug_names = variable_struct_get_names(global.bug_data);
    
    for (var i = 0; i < array_length(bug_names); i++) {
        var bug_key = bug_names[i];
        var bug_data = variable_struct_get(global.bug_data, bug_key);
        
        // Check if this bug can spawn in current location
        if (variable_struct_exists(bug_data.locations, location)) {
            var rarity = variable_struct_get(bug_data.locations, location);
            
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
        show_debug_message("No bugs available for location: " + string(location));
        return instance_create_layer(spawn_x, spawn_y, "Bugs", o_empty_rock);
    }
    
    // Randomly select from weighted array
    var selected_bug = available_bugs[irandom(array_length(available_bugs) - 1)];
    show_debug_message("Selected bug: " + string(selected_bug));
    
    // Create the bug instance
    var bug_instance = instance_create_layer(spawn_x, spawn_y, "Bugs", o_bug_parent);
    
    // CRITICAL: Set bug_species FIRST
    bug_instance.bug_species = selected_bug;
    show_debug_message("Set bug_species to: " + string(bug_instance.bug_species));
    
    // Load the bug data
    with (bug_instance) {
        if (variable_struct_exists(global.bug_data, bug_species)) {
            var data = global.bug_data[$ bug_species];
            bug_name = data.name;
            flavor_text = data.flavor_text;
            sprite_index = data.sprite;
            bug_hp = data.hp;
            bug_max_hp = data.hp;
            current_hp = bug_hp;
            essence_value = data.essence;
            
            show_debug_message("Loaded bug data for: " + bug_name);
        } else {
            show_debug_message("ERROR: Could not find bug data for: " + string(bug_species));
        }
    }
    
    return bug_instance;
}