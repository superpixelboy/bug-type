// o_pause_menu Step Event - SIMPLE VERSION
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
                    // Resume game
                    global.game_paused = false;
                    instance_destroy();
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
                    // TODO: Open settings menu (placeholder for now)
                    show_debug_message("Settings menu - placeholder");
                    break;
                    
                case "main_menu":
                    // Return to main menu
                    global.game_paused = false;
                    room_goto(rm_main_menu); // Adjust room name as needed
                    break;
                    
                case "quit":
                    // Quit game
                    game_end();
                    break;
            }
        }
        
        // ESC to resume (same as selecting resume)
        if (keyboard_check_pressed(vk_escape)) {
            audio_play_sound(sn_bug_catch1, 1, false);
            global.game_paused = false;
            instance_destroy();
        }
    }
} else {
    // Menu is hidden but still managing pause state
    // Check if collection menu was closed
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui == noone || !collection_ui.is_open) {
        // Collection closed, show pause menu again
        menu_active = true;
    }
    
    // Allow ESC to resume from this state too
    if (keyboard_check_pressed(vk_escape)) {
        audio_play_sound(sn_bug_catch1, 1, false);
        global.game_paused = false;
        instance_destroy();
    }
}


// ESC key for pause menu (only if no other menus are open)
if (keyboard_check_pressed(vk_escape)) {
    show_debug_message("ESC pressed - checking conditions...");
    
    // If pause menu already exists, let IT handle the ESC key (don't interfere)
    if (instance_exists(o_pause_menu)) {
        show_debug_message("Pause menu exists - letting it handle ESC");
        exit; // Let the pause menu's Step event handle closing
    }
    
    // Don't open pause menu if debug console is active
    if (instance_exists(o_bug_selector) && o_bug_selector.menu_active) {
        show_debug_message("Bug selector active - ignoring ESC");
        exit; // Let bug selector handle ESC
    }
    
    // Don't open pause menu if collection is open (let collection handle ESC)
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui != noone && collection_ui.is_open) {
        show_debug_message("Collection open - ignoring ESC");
        exit; // Let collection handle ESC
    }
    
    // Don't open during bug catching/card display
    if (instance_exists(o_bug_card) || instance_exists(o_bug_card_collection)) {
        show_debug_message("Bug card active - ignoring ESC");
        exit; // Let cards handle their own closing
    }
    
    // Only create pause menu if none exists
    show_debug_message("Creating pause menu...");
    var pause_menu = instance_create_layer(0, 0, "Instances", o_pause_menu);
    show_debug_message("Pause menu instance ID: " + string(pause_menu));
    audio_play_sound(sn_bugtap1, 1, false);
}