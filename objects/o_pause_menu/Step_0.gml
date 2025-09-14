// o_pause_menu Step Event - ENHANCED WITH UNIVERSAL CONTROLS
// SAFETY: This replaces direct keyboard checks with unified input manager calls

if (menu_active) {
    // Animate menu entrance
    animation_timer = min(animation_timer + 1, entrance_duration);
    menu_scale = lerp(0, target_scale, animation_timer / entrance_duration);
    
    // Only handle input after entrance animation completes
    if (animation_timer >= entrance_duration) {
        
        // ===== UNIVERSAL NAVIGATION (WASD + Arrows + Controller + Mouse) =====
        var move_up = input_get_menu_up_pressed();
        var move_down = input_get_menu_down_pressed();
        var confirm = input_get_menu_select_pressed();
        
        // ===== MOUSE HOVER DETECTION (like main menu) =====
        var mouse_gui_x = device_mouse_x_to_gui(0);
        var mouse_gui_y = device_mouse_y_to_gui(0);
        
        // Calculate menu item positions (matching Draw event)
        var screen_center_x = (480 / 2) * 2; // gui_scale is 2
        var screen_center_y = (270 / 2) * 2; 
        var items_start_y = screen_center_y + 0 * menu_scale;
        var item_spacing = 35 * menu_scale;
        
        // Check mouse hover over menu items
        var mouse_over_item = -1;
        for (var i = 0; i < array_length(menu_items); i++) {
            var item_y = items_start_y + (i * item_spacing);
            
            // Get text dimensions for hover detection
            draw_set_font(fnt_flavor_text_2x);
            var text_width = string_width(menu_items[i].text) * menu_scale;
            var text_height = string_height(menu_items[i].text) * menu_scale;
            
            // Check if mouse is over this menu item
            if (mouse_gui_x >= screen_center_x - text_width/2 && 
                mouse_gui_x <= screen_center_x + text_width/2 &&
                mouse_gui_y >= item_y - text_height/2 && 
                mouse_gui_y <= item_y + text_height/2) {
                mouse_over_item = i;
                break;
            }
        }
        
        // Update selection based on mouse hover
        if (mouse_over_item != -1 && mouse_over_item != selected_index) {
            selected_index = mouse_over_item;
            audio_play_sound(sn_bugtap1, 1, false);
        }
        
        // ===== KEYBOARD/CONTROLLER NAVIGATION =====
        if (move_up) {
            selected_index = (selected_index - 1 + array_length(menu_items)) % array_length(menu_items);
            audio_play_sound(sn_bugtap1, 1, false);
        }
        
        if (move_down) {
            selected_index = (selected_index + 1) % array_length(menu_items);
            audio_play_sound(sn_bugtap1, 1, false);
        }
        
        // ===== MENU SELECTION (Multiple input methods) =====
        if (confirm) {
            audio_play_sound(sn_bug_catch1, 1, false);
            
            var selected_action = menu_items[selected_index].action;
            
            switch(selected_action) {
                case "resume":
                    // Resume game
                    global.game_paused = false;
                    instance_destroy();
                    break;
                    
                case "save":
                    // Handle save game action
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
                    // Return to main menu
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