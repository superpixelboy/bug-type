// o_start_screen_manager Step Event
// Handle cloud movement and enhanced fade animations

// Move clouds slowly across the screen (unchanged)
cloud_x_offset += cloud_speed;

// NEW ENHANCED TITLE FADE SYSTEM
// First, handle the delay before title starts fading
if (!title_started_fading) {
    title_fade_timer++;
    if (title_fade_timer >= title_fade_delay) {
        title_started_fading = true;
    }
} else {
    // Now handle the actual title fade (only after delay)
    if (title_alpha < 1) {
        title_alpha += title_fade_speed;
        if (title_alpha >= 1) {
            title_alpha = 1;
            title_fully_visible = true;
            // Start menu fade when title is done
            menu_should_start_fading = true;
        }
    }
}

// NEW MENU FADE SYSTEM
// Only start fading menu after title is complete
if (menu_should_start_fading && menu_alpha < 1) {
    menu_alpha += menu_fade_speed;
    if (menu_alpha >= 1) {
        menu_alpha = 1;
    }
}

// Menu navigation (only after menu is visible AND title is done)
if (title_fully_visible && menu_alpha > 0.8 && menu_active) {
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
        }
    }
}