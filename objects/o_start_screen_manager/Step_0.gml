// o_start_screen_manager Step Event
// Handle cloud movement and title fade

// Move clouds slowly across the screen
cloud_x_offset += cloud_speed;

// Gradually fade in the title
if (title_alpha < 1) {
    title_alpha += title_fade_speed;
    if (title_alpha >= 1) {
        title_alpha = 1;
        title_fully_visible = true;
    }
}

// Menu navigation (only after title is visible)
if (title_fully_visible && menu_active) {
    var move_up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
    var move_down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
    var confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
    
    // Navigation
    if (move_up) {
        selected_index--;
        if (selected_index < 0) selected_index = array_length(menu_items) - 1;
        audio_play_sound(sn_bugtap1, 1, false);
    }
    
    if (move_down) {
        selected_index++;
        if (selected_index >= array_length(menu_items)) selected_index = 0;
         audio_play_sound(sn_bugtap1, 1, false);
    }
    
    // Selection
    if (confirm) {
        var selected_item = menu_items[selected_index];
        if (selected_item.enabled) {
            switch(selected_item.action) {
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
            // TODO: Add selection sound
        }
    }
}