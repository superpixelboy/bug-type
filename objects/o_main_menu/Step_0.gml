// o_main_menu Step Event - MAIN MENU NAVIGATION (CORRECTED VERSION)
if (menu_active) {
    // Animate menu entrance
    animation_timer = min(animation_timer + 1, entrance_duration);
    menu_scale = lerp(0, target_scale, animation_timer / entrance_duration);
    
    // Only handle input after entrance animation completes
    if (animation_timer >= entrance_duration) {
        
        // Navigation
        if (keyboard_check_pressed(vk_up)) {
            // Skip disabled items when navigating
            do {
                selected_index = (selected_index - 1 + array_length(menu_items)) % array_length(menu_items);
            } until (!(menu_items[selected_index].action == "continue" && !has_save_data));
            audio_play_sound(sn_bugtap1, 1, false);
        }
        
        if (keyboard_check_pressed(vk_down)) {
            // Skip disabled items when navigating
            do {
                selected_index = (selected_index + 1) % array_length(menu_items);
            } until (!(menu_items[selected_index].action == "continue" && !has_save_data));
            audio_play_sound(sn_bugtap1, 1, false);
        }
        
        // Selection
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
            var selected_action = menu_items[selected_index].action;
            var is_disabled = (selected_action == "continue" && !has_save_data);
            
            if (!is_disabled) {
                audio_play_sound(sn_bug_catch1, 1, false);
                
                switch(selected_action) {
                    case "continue":
                        // Load saved game and go to main world
                        show_debug_message("Loading saved game...");
                        // TODO: Load your save data here
                        room_goto(rm_spooky_forest); // Or wherever your main game starts
                        break;
                        
                    case "new_game":
                        // Start new game
                        show_debug_message("Starting new game...");
                        // TODO: Reset game data here
                        global.essence = 0;
                        // Clear any existing bug data if needed
                        room_goto(rm_spooky_forest); // Or your starting room
                        break;
                        
                    case "settings":
                        // TODO: Open settings menu (placeholder for now)
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
        
        // Debug console still works in main menu
        if (keyboard_check_pressed(vk_f1)) {
            if (!instance_exists(o_bug_selector)) {
                instance_create_layer(0, 0, "Instances", o_bug_selector);
            } else {
                with(o_bug_selector) {
                    menu_active = !menu_active;
                }
            }
        }
        
        // Fullscreen toggle still works
        if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("F"))) {
            if (window_get_fullscreen()) {
                window_set_fullscreen(false);
            } else {
                window_set_fullscreen(true);
            }
        }
    }
}