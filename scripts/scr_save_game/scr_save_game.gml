/// @description scr_save_game - Save all game progress to file
function scr_save_game() {
    show_debug_message("=== STARTING SAVE GAME ===");
    show_debug_message("💾 SAVE GAME CALLED");
	show_debug_message("  Saving tutorial state: " + string(global.met_baba_yaga));

    // Create save data map
    var save_data = ds_map_create();
    
    // === CORE PROGRESS DATA ===
    ds_map_add(save_data, "bugs_caught", global.bugs_caught);
    ds_map_add(save_data, "essence", global.essence);
    
    // === PLAYER POSITION ===
    ds_map_add(save_data, "return_x", global.return_x);
    ds_map_add(save_data, "return_y", global.return_y);
    
    // === ITEMS ===
    ds_map_add(save_data, "has_oak_wand", global.has_oak_wand);
    ds_map_add(save_data, "has_lucky_clover", global.has_lucky_clover);
    ds_map_add(save_data, "has_rabbit_foot", global.has_rabbit_foot);
    ds_map_add(save_data, "has_horseshoe", global.has_horseshoe);
    
    // === BUG CATCH COUNTS (DS_MAP) ===
    if (ds_exists(global.bug_catch_counts, ds_type_map)) {
        var bug_counts_string = ds_map_write(global.bug_catch_counts);
        ds_map_add(save_data, "bug_catch_counts", bug_counts_string);
        show_debug_message("Saved bug catch counts: " + string(ds_map_size(global.bug_catch_counts)) + " entries");
    }
    
    // === DISCOVERED BUGS (DS_MAP) ===
    if (variable_global_exists("discovered_bugs") && ds_exists(global.discovered_bugs, ds_type_map)) {
        var discovered_string = ds_map_write(global.discovered_bugs);
        ds_map_add(save_data, "discovered_bugs", discovered_string);
        show_debug_message("Saved discovered bugs: " + string(ds_map_size(global.discovered_bugs)) + " entries");
    }
    
    // === FLIPPED ROCKS (DS_LIST) ===
    if (ds_exists(global.flipped_rocks, ds_type_list)) {
        var flipped_rocks_string = ds_list_write(global.flipped_rocks);
        ds_map_add(save_data, "flipped_rocks", flipped_rocks_string);
        show_debug_message("Saved flipped rocks: " + string(ds_list_size(global.flipped_rocks)) + " entries");
    }
    
    // === SPAWNED ROCKS (DS_MAP) ===
    if (ds_exists(global.spawned_rocks, ds_type_map)) {
        var spawned_rocks_string = ds_map_write(global.spawned_rocks);
        ds_map_add(save_data, "spawned_rocks", spawned_rocks_string);
        show_debug_message("Saved spawned rocks: " + string(ds_map_size(global.spawned_rocks)) + " entries");
    }
	
	
	// Add this line in the "CORE PROGRESS DATA" section:
	ds_map_add(save_data, "met_baba_yaga", global.met_baba_yaga);

	// === ADD TO scr_load_game.gml ===  
	// Add this in the "LOAD CORE PROGRESS" section:
	if (ds_map_exists(save_data, "met_baba_yaga")) {
	    global.met_baba_yaga = ds_map_find_value(save_data, "met_baba_yaga");
	    show_debug_message("Loaded met_baba_yaga: " + string(global.met_baba_yaga));
	}


    
    // === SAVE VERSION (for future compatibility) ===
    ds_map_add(save_data, "save_version", "1.0");
    ds_map_add(save_data, "save_timestamp", date_current_datetime());
    
    // === WRITE TO FILE ===
    var save_string = ds_map_write(save_data);
    var file = file_text_open_write("witchbug_save.dat");
    
    if (file != -1) {
        file_text_write_string(file, save_string);
        file_text_close(file);
        show_debug_message("=== SAVE SUCCESSFUL ===");
        show_debug_message("Save file: witchbug_save.dat");
        show_debug_message("Data size: " + string(string_length(save_string)) + " characters");
        
        // Clean up
        ds_map_destroy(save_data);
        return true;
    } else {
        show_debug_message("ERROR: Could not create save file!");
        ds_map_destroy(save_data);
        return false;
    }
}