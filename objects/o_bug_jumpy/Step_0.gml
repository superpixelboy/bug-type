switch(state) {
    case "moving":
        // Slower animation - this bug is more "thoughtful"
        anim_timer++;
        if (anim_timer >= 45) {  // Slower than others
            image_index = (image_index == 0) ? 1 : 0;
            anim_timer = 0;
        }
        
        // Reduce jump cooldown
        if (jump_cooldown > 0) jump_cooldown--;
        break;
        
case "poked":
    image_index = 2;
    poke_timer++;
    if (poke_timer >= 30) {
        state = "caught";
        global.bugs_caught++;  // Add this line
          // Register this bug type as discovered
        var bug_type_index = 2;  // You'll map this to actual bug types
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