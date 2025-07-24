// Room-based spawn chances
switch(room) {
    case rm_spooky_forest:
        // Balanced starter area
        chance_nothing = 50;
        chance_normal = 30;
        chance_mossy = 15;
        chance_cracked = 5;
        break;
        
    case rm_deep_woods:
        // More mossy rocks (nature theme)
        chance_nothing = 40;
        chance_normal = 20;
        chance_mossy = 30;
        chance_cracked = 10;
        break;
        
    case rm_forest_clearing:
        // Balanced but slightly better than starter
        chance_nothing = 45;
        chance_normal = 25;
        chance_mossy = 20;
        chance_cracked = 10;
        break;
        
    case rm_shadow_grove:
        // Rare bug paradise!
        chance_nothing = 30;
        chance_normal = 15;
        chance_mossy = 25;
        chance_cracked = 30;
        break;
        
    default:
        // Fallback to original values
        chance_nothing = 50;
        chance_normal = 25;
        chance_mossy = 15;
        chance_cracked = 10;
        break;
}

// Create unique ID for this node based on position
node_id = "node_" + string(x) + "_" + string(y);

// Make node invisible
visible = false;

// Check if this node has already been processed
if (!ds_map_exists(global.spawned_rocks, node_id)) {
    // First time - roll for what spawns here
    var roll = random(100);
    var rock_type = "";
    
    if (roll < chance_nothing) {
        rock_type = "none";
    } else if (roll < chance_nothing + chance_normal) {
        rock_type = "normal";
    } else if (roll < chance_nothing + chance_normal + chance_mossy) {
        rock_type = "mossy";
    } else {
        rock_type = "cracked";
    }
    
    // Store what this node spawned
    ds_map_set(global.spawned_rocks, node_id, rock_type);
}

// ADD THIS LINE - Get the stored spawn type for this node
var stored_type = ds_map_find_value(global.spawned_rocks, node_id);

// Spawn rock if it's not "none" and hasn't been flipped
if (stored_type != "none") {
    var rock_id = node_id + "_rock";
    
    // Only spawn if this rock hasn't been flipped
    if (ds_list_find_index(global.flipped_rocks, rock_id) == -1) {
        switch(stored_type) {
            case "normal":
                var new_rock = instance_create_layer(x, y, "Instances", o_rock_small);
                new_rock.rock_unique_id = rock_id;
                break;
            case "mossy":
                var new_rock = instance_create_layer(x, y, "Instances", o_rock_small_mossy);
                new_rock.rock_unique_id = rock_id;
                break;
            case "cracked":
                var new_rock = instance_create_layer(x, y, "Instances", o_rock_small_cracked);
                new_rock.rock_unique_id = rock_id;
                break;
        }
    }
}

// Node has done its job
instance_destroy();