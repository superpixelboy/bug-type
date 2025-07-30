function scr_bug_do_damage(damage) {
    
	//Magic wand
	var damage_multiplier = global.has_oak_wand ? 2 : 1;
	current_hp -= (1 * damage_multiplier);
	
    // UPDATE PROGRESS BAR HERE - This was missing!
    catch_progress = 1 - (current_hp / bug_max_hp);
    
    // Satisfying visual feedback
    flash_timer = 8;
    scale_bounce_x = -0.4;
    scale_bounce_y = -0.4;

    // Get mouse position for particle origin
    var mouse_x_pos = mouse_x;
    var mouse_y_pos = mouse_y;
    
    // COMBO-BASED PARTICLES (escalating feedback!)
    switch(combo_count) {
        case 0:
        case 1:
            scr_spawn_dirt_particles(mouse_x_pos, mouse_y_pos, 5);
            break;
        case 2:
        case 3:
            scr_spawn_gold_particles(mouse_x_pos, mouse_y_pos, 8);
            break;
        case 4:
        case 5:
            scr_spawn_magic_particles(mouse_x_pos, mouse_y_pos, 12);
            break;
    }
    
    if (current_hp <= 0) {
        state = "ready_to_catch";
        current_hp = 0;
        catch_progress = 1;  // Ensure bar is completely full when ready
        // DON'T reset combo here - keep it for the catch!
        
        // Ready to catch feedback
        scr_screen_flash();
        audio_play_sound(sn_bug_ready, 1, false);
    } else {
        // Enter recovery window for that combo feel
        state = "recovering";
        recovery_timer = 0;
    }
}