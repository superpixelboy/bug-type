function scr_spawn_bug_by_rock_type(spawn_x, spawn_y, rock_type) {
    
    // Check for empty rocks first
    var empty_chance = 0;
    switch(rock_type) {
        case "normal":
            empty_chance = global.has_lucky_clover ? 0.4 : 0.5;  // 50% -> 40% with clover
            break;
        case "mossy":
            empty_chance = global.has_lucky_clover ? 0.2 : 0.3;  // 30% -> 20% with clover
            break;
        case "cracked":
            empty_chance = global.has_lucky_clover ? 0.05 : 0.1; // 10% -> 5% with clover
            break;
    }
    
    // Roll for empty rock
    if (random(1) < empty_chance) {
        return instance_create_layer(spawn_x, spawn_y, "Bugs", o_empty_rock);
    }
    
    // LUCKY CLOVER CHECK - Small chance for gem bug if owned (only if not empty)
    if (global.has_lucky_clover && random(1) < 0.08) {  // 8% chance
        return instance_create_layer(spawn_x, spawn_y, "Bugs", o_gem_bug);
    }
    
    switch(rock_type) {
        case "normal":
            // Mostly common bugs
            var bug_roll = random(1);
            if (bug_roll < 0.4) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_moss_grub);
            } else if (bug_roll < 0.7) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_bark_crawler);
            } else if (bug_roll < 0.9) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_shadow_beetle);
            } else {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_whisper_weevil);
            }
            break;
            
        case "mossy":
            // Mix of easy/medium bugs
            var bug_roll = random(1);
            if (bug_roll < 0.3) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_glade_hopper);
            } else if (bug_roll < 0.6) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_gloom_might);
            } else if (bug_roll < 0.8) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_moonlight_moth);
            } else {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_ember_wasp);
            }
            break;
            
        case "cracked":
            // Higher chance for rare/hard bugs
            var bug_roll = random(1);
            if (bug_roll < 0.3) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_centimpede);
            } else if (bug_roll < 0.5) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_ember_wasp);
            } else if (bug_roll < 0.7) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_moonlight_moth);
            } else if (bug_roll < 0.9) {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_ancient_shell_back);
            } else {
                return instance_create_layer(spawn_x, spawn_y, "Bugs", o_gloom_might);
            }
            break;
    }
}