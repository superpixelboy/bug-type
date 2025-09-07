// o_fade_controller Step Event (Enhanced)

switch(fade_state) {
    case "fade_out":
        fade_alpha += fade_speed;
        if (fade_alpha >= 1) {
            fade_alpha = 1;
            fade_state = "black";
            
            // Save player position before performing action (existing functionality)
            if (instance_exists(o_player)) {
                saved_player_x = o_player.x;
                saved_player_y = o_player.y;
            }
            
            // Perform different actions based on action_to_perform
            switch(action_to_perform) {
                case "sleep":
                    show_debug_message("Saving progress before sleep...");
                    scr_save_game();
                    scr_reset_rock_spawns();
                    break;
                    
                case "room_transition":
                    // Handle room transitions
                    if (target_room != -1) {
                        room_goto(target_room);
                        // After room transition, the fade will continue in the new room
                        return;
                    }
                    break;
                    
                case "menu_transition":
                    // Special handling for menu transitions
                    if (target_room != -1) {
                        room_goto(target_room);
                        return;
                    }
                    break;
                    
                case "intro_transition":
                    // Special handling for intro sequences
                    if (target_room != -1) {
                        room_goto(target_room);
                        return;
                    }
                    break;
                    
                case "quit_game":
                    // Handle quitting the game
                    game_end();
                    break;
            }
        }
        break;
        
    case "black":
        // Stay black for a moment, then fade in
        fade_state = "fade_in";
        break;
        
    case "fade_in":
        fade_alpha -= fade_speed;
        if (fade_alpha <= 0) {
            fade_alpha = 0;
            fade_state = "none";
            
            // Restore player position after sleep (existing functionality)
            if (action_to_perform == "sleep" && instance_exists(o_player)) {
                o_player.x = global.sleep_x;
                o_player.y = global.sleep_y;
            }
            
            instance_destroy();
        }
        break;
        
    // NEW: Room entry fade (starts black, fades in immediately)
    case "room_entry":
        fade_alpha -= fade_speed;
        if (fade_alpha <= 0) {
            fade_alpha = 0;
            fade_state = "none";
            instance_destroy();
        }
        break;
        
    // NEW: Quick fade out (for immediate room transitions)
    case "quick_out":
        fade_alpha += fade_speed * 1.5; // Faster
        if (fade_alpha >= 1) {
            fade_alpha = 1;
            if (target_room != -1) {
                room_goto(target_room);
            }
            instance_destroy();
        }
        break;
}