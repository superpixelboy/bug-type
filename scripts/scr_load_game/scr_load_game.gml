/// @description scr_load_game - Load all game progress from file
function scr_load_game() {
    show_debug_message("=== STARTING LOAD GAME ===");
    
    // Check if save file exists
    if (!file_exists("witchbug_save.dat")) {
        show_debug_message("ERROR: Save file does not exist!");
        return false;
    }
    
    // Read save file
    var file = file_text_open_read("witchbug_save.dat");
    if (file == -1) {
        show_debug_message("ERROR: Could not open save file!");
        return false;
    }
    
    var save_string = file_text_read_string(file);
    file_text_close(file);
    
    // Parse save data
    var save_data = ds_map_create();
    ds_map_read(save_data, save_string);
    
    show_debug_message("Save data loaded: " + string(ds_map_size(save_data)) + " entries");
    
    // === LOAD CORE PROGRESS ===
    if (ds_map_exists(save_data, "bugs_caught")) {
        global.bugs_caught = ds_map_find_value(save_data, "bugs_caught");
        show_debug_message("Loaded bugs caught: " + string(global.bugs_caught));
    }
    
    if (ds_map_exists(save_data, "essence")) {
        global.essence = ds_map_find_value(save_data, "essence");
        show_debug_message("Loaded essence: " + string(global.essence));
    }
    
    // === LOAD PLAYER POSITION ===
    if (ds_map_exists(save_data, "return_x")) {
        global.return_x = ds_map_find_value(save_data, "return_x");
    }
    if (ds_map_exists(save_data, "return_y")) {
        global.return_y = ds_map_find_value(save_data, "return_y");
    }
    
    // === LOAD ITEMS ===
    if (ds_map_exists(save_data, "has_oak_wand")) {
        global.has_oak_wand = ds_map_find_value(save_data, "has_oak_wand");
    }
    if (ds_map_exists(save_data, "has_lucky_clover")) {
        global.has_lucky_clover = ds_map_find_value(save_data, "has_lucky_clover");
    }
    if (ds_map_exists(save_data, "has_rabbit_foot")) {
        global.has_rabbit_foot = ds_map_find_value(save_data, "has_rabbit_foot");
    }
    if (ds_map_exists(save_data, "has_horseshoe")) {
        global.has_horseshoe = ds_map_find_value(save_data, "has_horseshoe");
    }
    
    // === LOAD BUG CATCH COUNTS ===
    if (ds_map_exists(save_data, "bug_catch_counts")) {
        var bug_counts_string = ds_map_find_value(save_data, "bug_catch_counts");
        
        // SAFETY: Clean up existing map first
        if (variable_global_exists("bug_catch_counts") && ds_exists(global.bug_catch_counts, ds_type_map)) {
            ds_map_destroy(global.bug_catch_counts);
        }
        
        // Create new map and load data
        global.bug_catch_counts = ds_map_create();
        ds_map_read(global.bug_catch_counts, bug_counts_string);
        show_debug_message("Loaded bug catch counts: " + string(ds_map_size(global.bug_catch_counts)) + " entries");
    }
    
    // === LOAD DISCOVERED BUGS ===
    if (ds_map_exists(save_data, "discovered_bugs")) {
        var discovered_string = ds_map_find_value(save_data, "discovered_bugs");
        
        // SAFETY: Clean up existing map first
        if (variable_global_exists("discovered_bugs") && ds_exists(global.discovered_bugs, ds_type_map)) {
            ds_map_destroy(global.discovered_bugs);
        }
        
        // Create new map and load data
        global.discovered_bugs = ds_map_create();
        ds_map_read(global.discovered_bugs, discovered_string);
        show_debug_message("Loaded discovered bugs: " + string(ds_map_size(global.discovered_bugs)) + " entries");
    }
    
    // === LOAD FLIPPED ROCKS ===
    if (ds_map_exists(save_data, "flipped_rocks")) {
        var flipped_rocks_string = ds_map_find_value(save_data, "flipped_rocks");
        
        // SAFETY: Clean up existing list first
        if (variable_global_exists("flipped_rocks") && ds_exists(global.flipped_rocks, ds_type_list)) {
            ds_list_destroy(global.flipped_rocks);
        }
        
        // Create new list and load data
        global.flipped_rocks = ds_list_create();
        ds_list_read(global.flipped_rocks, flipped_rocks_string);
        show_debug_message("Loaded flipped rocks: " + string(ds_list_size(global.flipped_rocks)) + " entries");
    }
    
    // === LOAD SPAWNED ROCKS ===
    if (ds_map_exists(save_data, "spawned_rocks")) {
        var spawned_rocks_string = ds_map_find_value(save_data, "spawned_rocks");
        
        // SAFETY: Clean up existing map first
        if (variable_global_exists("spawned_rocks") && ds_exists(global.spawned_rocks, ds_type_map)) {
            ds_map_destroy(global.spawned_rocks);
        }
        
        // Create new map and load data
        global.spawned_rocks = ds_map_create();
        ds_map_read(global.spawned_rocks, spawned_rocks_string);
        show_debug_message("Loaded spawned rocks: " + string(ds_map_size(global.spawned_rocks)) + " entries");
    }
    
	//Quest Progression
	if (ds_map_exists(save_data, "met_baba_yaga")) {
	    global.met_baba_yaga = ds_map_find_value(save_data, "met_baba_yaga");
	    show_debug_message("Loaded met_baba_yaga: " + string(global.met_baba_yaga));
	} else {
	    // Fallback for old save files without tutorial flag
	    global.met_baba_yaga = false;
	    show_debug_message("Old save file - defaulting met_baba_yaga to false");
	}

	// === FIX scr_initialize_new_game.gml ===
	// Add this in the "CORE PROGRESS" section:

	global.met_baba_yaga = false;
    // Clean up
    ds_map_destroy(save_data);
    
    show_debug_message("=== LOAD SUCCESSFUL ===");
    return true;
}