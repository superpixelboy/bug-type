function scr_spawn_bug_by_rock_type(spawn_x, spawn_y, rock_type) {
    
    // Base empty chance (30-50% range)
//    var empty_chance = 0.4;  // 40% base empty rate
var empty_chance = 0.0;  // 40% base empty rate
    
    // Lucky items reduce empty chance
    if (global.has_lucky_clover) empty_chance -= 0.1;    // -10%
    if (global.has_rabbit_foot) empty_chance -= 0.08;    // -8% 
    if (global.has_horseshoe) empty_chance -= 0.07;      // -7%
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