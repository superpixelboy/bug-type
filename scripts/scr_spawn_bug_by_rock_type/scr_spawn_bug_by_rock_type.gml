function scr_spawn_bug_by_rock_type(spawn_x, spawn_y, rock_type) {
     // ADD THIS CHECK FIRST - Demo bug selection
    if (global.next_forced_bug != -1) {
        var bug_instance = instance_create_layer(spawn_x, spawn_y, "Bugs", o_bug_parent);
        bug_instance.bug_species = global.next_forced_bug;
        
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
            }
        }
        
        global.next_forced_bug = -1;  // Reset after use
        return bug_instance;
    }
    // Base empty chance (30-50% range)
   var empty_chance = 0.4;  // 40% base empty rate

    
    // Lucky items reduce empty chance
    if (global.has_lucky_clover) empty_chance -= 0.1;    // -10%
    if (global.has_rabbit_foot) empty_chance -= 0.20;    // -20%
    if (global.has_horseshoe) empty_chance -= 0.3;      // -30%
    // Could stack to nearly eliminate empty rocks
    
    empty_chance = max(empty_chance, 0.05);  // Never go below 5% empty
    
    // Check for empty rocks
    if (random(1) < empty_chance) {
        return instance_create_layer(spawn_x, spawn_y, "Bugs", o_empty_rock);
    }
    
    // SPECIAL RARE ROCKS - 100% rare bug spawn
    if (rock_type == "crystal" || rock_type == "golden" || rock_type == "cursed") {
        return scr_spawn_rare_bug_guaranteed(spawn_x, spawn_y, global.current_location, rock_type);
    }
    
    // Normal location-based spawning for regular rocks
    return scr_spawn_bug_by_location(spawn_x, spawn_y, global.current_location, rock_type);
}