// o_pause_menu Step Event - WITH SAVE ACTION ADDED
if (menu_active) {
    // Animate menu entrance
    animation_timer = min(animation_timer + 1, entrance_duration);
    menu_scale = lerp(0, target_scale, animation_timer / entrance_duration);
    
    // Only handle input after entrance animation completes
    if (animation_timer >= entrance_duration) {
        
        // Navigation
        if (keyboard_check_pressed(vk_up)) {
            selected_index = (selected_index - 1 + array_length(menu_items)) % array_length(menu_items);
            audio_play_sound(sn_bugtap1, 1, false);
        }
        
        if (keyboard_check_pressed(vk_down)) {
            selected_index = (selected_index + 1) % array_length(menu_items);
            audio_play_sound(sn_bugtap1, 1, false);
        }
        
        // Selection
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
            audio_play_sound(sn_bug_catch1, 1, false);
            
            var selected_action = menu_items[selected_index].action;
            
            switch(selected_action) {
                case "resume":
                    // Resume game - let UI_Manager handle this via ESC
                    global.game_paused = false;
                    instance_destroy();
                    break;
                    
                case "save":
                    // ADDED: Handle save game action
                    show_debug_message("Manual save requested");
                    if (scr_save_game()) {
                        show_debug_message("Manual save successful");
                        // Could show "Game Saved!" message briefly here
                        // For now, just resume after saving
                        global.game_paused = false;
                        instance_destroy();
                    } else {
                        show_debug_message("Manual save failed");
                        // Could show error message to player
                    }
                    break;
                    
                case "collection":
                    // Open collection menu
                    var collection_ui = instance_find(o_bug_collection_ui, 0);
                    if (collection_ui != noone) {
                        collection_ui.is_open = true;
                        collection_ui.page = 0;
                        // Keep game paused but hide this menu
                        menu_active = false;
                    }
                    break;
                    
                case "settings":
                    // Toggle fullscreen as placeholder settings
                    if (window_get_fullscreen()) {
                        window_set_fullscreen(false);
                    } else {
                        window_set_fullscreen(true);
                    }
                    break;
                    
                case "main_menu":
                    // FIXED: Properly return to main menu
                    show_debug_message("Returning to main menu...");
                    
                    // Clean up game state first
                    global.game_paused = false;
                    
                    // Stop all audio
                    audio_stop_all();
                    
                    // CRITICAL: Destroy this pause menu instance BEFORE room transition
                    instance_destroy();
                    
                    // Go to main menu
                    room_goto(rm_main_menu);
                    break;
                    
                case "quit":
                    // Quit game
                    game_end();
                    break;
            }
        }
        
        // NOTE: NO ESC HANDLING HERE! UI_Manager handles ALL ESC logic now.
    }
} else {
    // Menu is hidden but still managing pause state
    // Check if collection menu was closed
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui == noone || !collection_ui.is_open) {
        // Collection closed, show pause menu again
        menu_active = true;
    }
    
    // NOTE: NO ESC HANDLING HERE EITHER! UI_Manager is in charge.
}