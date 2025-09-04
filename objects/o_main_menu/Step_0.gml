// o_main_menu Step Event - REMOVED F1 HANDLER (UI_Manager handles it)
if (menu_active) {
    // Animate menu entrance
    animation_timer = min(animation_timer + 1, entrance_duration);
    menu_scale = lerp(0, target_scale, animation_timer / entrance_duration);
    
    // Only handle input after entrance animation completes
    if (animation_timer >= entrance_duration) {
        
        // Navigation - skip disabled items
        if (keyboard_check_pressed(vk_up)) {
            do {
                selected_index = (selected_index - 1 + array_length(menu_items)) % array_length(menu_items);
            } until (menu_items[selected_index].enabled == true);
            audio_play_sound(sn_bugtap1, 1, false);
        }
        
        if (keyboard_check_pressed(vk_down)) {
            do {
                selected_index = (selected_index + 1) % array_length(menu_items);
            } until (menu_items[selected_index].enabled == true);
            audio_play_sound(sn_bugtap1, 1, false);
        }
        
        // Selection
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
            var selected_action = menu_items[selected_index].action;
            
            // Only process if item is enabled
            if (menu_items[selected_index].enabled) {
                audio_play_sound(sn_bug_catch1, 1, false);
                
                switch(selected_action) {
                    case "continue":
                        // FIXED: Actually load the saved game
                        show_debug_message("Loading saved game...");
                        if (scr_load_game()) {
                            show_debug_message("Save loaded successfully!");
                            room_goto(rm_spooky_forest); // Or your main game room
                        } else {
                            show_debug_message("ERROR: Failed to load save!");
                            // Could show error message to player here
                        }
                        break;
                        
                    case "new_game":
                        // FIXED: Properly initialize new game
                        show_debug_message("Starting new game...");
                        scr_initialize_new_game();
                        room_goto(rm_spooky_forest); // Or your starting room
                        break;
                        
                    case "settings":
                        // Toggle fullscreen as placeholder
                        show_debug_message("Settings menu - placeholder");
                        if (window_get_fullscreen()) {
                            window_set_fullscreen(false);
                        } else {
                            window_set_fullscreen(true);
                        }
                        break;
                        
                    case "quit":
                        // Quit game
                        game_end();
                        break;
                }
            }
        }
        
        // REMOVED: F1 handler - UI_Manager handles this now
        // Let UI_Manager be the single source of truth for F1
        
       
    }
}