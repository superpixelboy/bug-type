function scr_bug_handle_catch() {
    if (state == "ready_to_catch") {
        state = "capturing";
        
        // Give essence
        global.essence += essence_value;
        
        // ESSENCE PARTICLES instead of catch particles
        scr_spawn_essence_particles(x, y, essence_value);
        
        // Register bug discovery
        var bug_type_name = object_get_name(object_index);
        ds_map_set(global.discovered_bugs, bug_type_name, true);
        
        // Comment out the catch particles
        // scr_spawn_catch_particles(mouse_x, mouse_y);
        
        audio_play_sound(sn_bug_catch1, 1, false);
        
        // Start capture animation
        capture_timer = 0;
    }
}