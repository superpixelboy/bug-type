switch(state) {
    case "moving":
        // Faster animation
        anim_timer++;
        if (anim_timer >= 15) {  // Faster than normal (was 30)
            image_index = (image_index == 0) ? 1 : 0;
            anim_timer = 0;
        }
        
        // Changes direction more frequently
        move_timer++;
        if (move_timer >= 30) {  // More erratic (was 60)
            move_direction = random(360);
            move_timer = 0;
        }
        
        // Faster movement
        x += lengthdir_x(move_speed, move_direction);
        y += lengthdir_y(move_speed, move_direction);
        x = clamp(x, 64, room_width - 64);
        y = clamp(y, 64, room_height - 64);
        break;
        
case "poked":
    image_index = 2;
    poke_timer++;
    if (poke_timer >= 30) {
        state = "caught";
        global.bugs_caught++;  // Add this line
		
          // Register this bug type as discovered
        var bug_type_index = 1;  // You'll map this to actual bug types
        ds_map_set(global.discovered_bugs, "bug_" + string(bug_type_index), true);
        
        audio_play_sound(sn_bug_catch1, 1, false);
    }
    break;
    case "caught":
        image_index = 2;
        poke_timer++;
        if (poke_timer >= 120) {
            room_goto_previous();
        }
        break;
}