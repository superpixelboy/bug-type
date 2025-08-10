// Fixed version of scr_spawn_bug_by_location
function scr_spawn_bug_by_location(spawn_x, spawn_y, location, rock_type) {
    
    show_debug_message("=== SPAWNING BUG ===");
    show_debug_message("Location: " + string(location));
    show_debug_message("Rock type: " + string(rock_type));
    
    // Check if bug data exists
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
                // Convert rarity to spawn weight (lower rarity = higher weight)
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
    
    // CRITICAL: Initialize ALL variables BEFORE using them
    with (bug_instance) {
        // Set default values FIRST
        bug_species = "unknown";
        bug_name = "Unknown Bug";
        flavor_text = "";
        sprite_index = s_bug_test;  // Default sprite
        bug_hp = 10;
        bug_max_hp = 10;
        current_hp = 10;
        essence_value = 1;
        
        // NOW set the actual bug species
        bug_species = selected_bug;
        show_debug_message("Set bug_species to: " + string(bug_species));
        
        // Load the actual bug data
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

// Helper function to get location name from room
function get_location_from_room() {
    switch(room) {
        case rm_spooky_forest:
        case rm_forest_clearing:
            return "Apple_Grove";
            
        case rm_deep_woods:
            return "Dead_Woods";
            
        case rm_shadow_grove:
            return "Graveyard";
            
        // Add more room-to-location mappings as needed
        default:
            return "Apple_Grove";
    }
}

// Function to spawn rare bugs (for special rocks)
function scr_spawn_rare_bug_guaranteed(spawn_x, spawn_y, location, rock_type) {
    // Get only rare bugs (rarity 7-9) from the location
    var rare_bugs = [];
    var bug_names = variable_struct_get_names(global.bug_data);
    
    for (var i = 0; i < array_length(bug_names); i++) {
        var bug_key = bug_names[i];
        var bug_data = variable_struct_get(global.bug_data, bug_key);
        
        if (variable_struct_exists(bug_data.locations, location)) {
            var rarity = variable_struct_get(bug_data.locations, location);
            
            // Only include rare bugs (rarity 7-9)
            if (rarity >= 7 && rarity != "x") {
                array_push(rare_bugs, bug_key);
            }
        }
    }
    
    // If no rare bugs, fall back to normal spawning
    if (array_length(rare_bugs) == 0) {
        return scr_spawn_bug_by_location(spawn_x, spawn_y, location, rock_type);
    }
    
    // Select a random rare bug
    var selected_bug = rare_bugs[irandom(array_length(rare_bugs) - 1)];
    
    // Create and initialize the bug
    var bug_instance = instance_create_layer(spawn_x, spawn_y, "Bugs", o_bug_parent);
    
    with (bug_instance) {
        // Initialize defaults first
        bug_species = "unknown";
        bug_name = "Unknown Bug";
        flavor_text = "";
        sprite_index = s_bug_test;
        bug_hp = 10;
        bug_max_hp = 10;
        current_hp = 10;
        essence_value = 1;
        
        // Set the actual species
        bug_species = selected_bug;
        
        // Load bug data
        if (variable_struct_exists(global.bug_data, bug_species)) {
            var data = global.bug_data[$ bug_species];
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