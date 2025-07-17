switch(fade_state) {
    case "fade_out":
        fade_alpha += fade_speed;
        if (fade_alpha >= 1) {
            fade_alpha = 1;
            fade_state = "black";
            
            // Save player position before performing action
            saved_player_x = o_player.x;
            saved_player_y = o_player.y;
            
            // Perform the action while screen is black
            if (action_to_perform == "sleep") {
                scr_reset_rock_spawns();
            }
        }
        break;
        
    case "black":
        // Stay black for a moment
        if (fade_alpha >= 1) {
            fade_state = "fade_in";
        }
        break;
        
	case "fade_in":
    fade_alpha -= fade_speed;
    if (fade_alpha <= 0) {
        fade_alpha = 0;
        fade_state = "none";
        
        // Restore player position after sleep
        if (action_to_perform == "sleep" && instance_exists(o_player)) {
            o_player.x = global.sleep_x;
            o_player.y = global.sleep_y;
        }
        
        instance_destroy();
    }
    break;
}