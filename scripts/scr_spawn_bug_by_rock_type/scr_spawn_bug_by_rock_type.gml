function scr_spawn_bug_by_rock_type(spawn_x, spawn_y, rock_type) {
    
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