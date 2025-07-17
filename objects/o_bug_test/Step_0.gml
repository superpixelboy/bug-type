// Handle different states
switch(state) {
    case "moving":
        // Animate between frames 0 and 1
        anim_timer++;
        if (anim_timer >= 30) {  // Switch every 0.5 seconds
            image_index = (image_index == 0) ? 1 : 0;
            anim_timer = 0;
        }
        
        // Simple movement
        move_timer++;
        if (move_timer >= 60) {  // Change direction every second
            move_direction = random(360);
            move_timer = 0;
        }
        
        // Move and stay in bounds
		/*
        x += lengthdir_x(move_speed, move_direction);
        y += lengthdir_y(move_speed, move_direction);
        x = clamp(x, 64, room_width - 64);
		y = clamp(y, 64, room_height - 64);*/
        break;
        
case "poked":
    image_index = 2;
    poke_timer++;
    if (poke_timer >= 30) {
        state = "caught";
        global.bugs_caught++;  // Add this line
          // Register this bug type as discovered
        var bug_type_index = 0;  // You'll map this to actual bug types
        ds_map_set(global.discovered_bugs, "bug_" + string(bug_type_index), true);
        
        audio_play_sound(sn_bug_catch1, 1, false);
    }
    break;
        
	// In obj_bug Step Event, in the "caught" case:
	case "caught":
	    // Show caught text and return to overworld
	    draw_set_font(-1);
	    draw_set_halign(fa_center);
	    draw_text(room_width/2, room_height/2 - 50, "Bug Caught!");
    
	    poke_timer++;
	    if (poke_timer >= 120) {  // Wait 2 seconds
	        room_goto_previous();  // Return to overworld
	    }
	    break;
}