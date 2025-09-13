/// @description scr_initialize_new_game - Reset all game data for new game
function scr_initialize_new_game() {
    show_debug_message("=== INITIALIZING NEW GAME ===");
    show_debug_message("🆕 INITIALIZE NEW GAME CALLED - THIS RESETS TUTORIAL!");
	show_debug_message("  Call stack: " + string(debug_get_callstack()));

    // === CORE PROGRESS ===
    global.bugs_caught = 0;
    global.essence = 0;
    global.showing_card = false;
	global.met_baba_yaga = false;
    
    // === PLAYER POSITION ===
    global.return_x = 626;
    global.return_y = 525;
    
    // === DOOR SYSTEM ===
    global.door_cooldown = 0;
    global.door_entrance_x = undefined;
    global.door_entrance_y = undefined;
    
    // === ITEMS ===
    global.has_oak_wand = false;
    global.has_lucky_clover = false;
    global.has_rabbit_foot = false;
    global.has_horseshoe = false;
    
    // === ROCK SYSTEM ===
    global.last_rock_used = false;
    global.current_rock_id = "";
    global.next_forced_bug = -1;
	


    
    // === SLEEP SYSTEM ===
    if (variable_global_exists("is_sleeping")) {
        global.is_sleeping = false;
    }
    
    // === CLEAN UP EXISTING DATA STRUCTURES ===
    
    // Clean up bug catch counts
    if (variable_global_exists("bug_catch_counts") && ds_exists(global.bug_catch_counts, ds_type_map)) {
        ds_map_destroy(global.bug_catch_counts);
    }
    global.bug_catch_counts = ds_map_create();
    
    // Clean up discovered bugs
    if (variable_global_exists("discovered_bugs") && ds_exists(global.discovered_bugs, ds_type_map)) {
        ds_map_destroy(global.discovered_bugs);
    }
    global.discovered_bugs = ds_map_create();
    
    // Clean up flipped rocks
    if (variable_global_exists("flipped_rocks") && ds_exists(global.flipped_rocks, ds_type_list)) {
        ds_list_destroy(global.flipped_rocks);
    }
    global.flipped_rocks = ds_list_create();
    
    // Clean up spawned rocks
    if (variable_global_exists("spawned_rocks") && ds_exists(global.spawned_rocks, ds_type_map)) {
        ds_map_destroy(global.spawned_rocks);
    }
    global.spawned_rocks = ds_map_create();
    
    show_debug_message("=== NEW GAME INITIALIZED ===");
}