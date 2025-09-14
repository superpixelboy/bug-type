// Enhanced scr_bug_do_damage with input source parameter
function scr_bug_do_damage(damage, use_mouse_pos) {
    // If use_mouse_pos not provided, default to true (preserve existing behavior)
    if (argument_count < 2) use_mouse_pos = true;
    
	//Magic wand
	var damage_multiplier = global.has_oak_wand ? 2 : 1;
	current_hp -= (1 * damage_multiplier);
	
    // UPDATE PROGRESS BAR HERE - This was missing!
    catch_progress = 1 - (current_hp / bug_max_hp);
    
    // Satisfying visual feedback
    flash_timer = 8;
    scale_bounce_x = -0.4;
    scale_bounce_y = -0.4;
    
	// === PARAMETER-BASED PARTICLE POSITIONING ===
	var particle_x_pos, particle_y_pos;
	
	if (use_mouse_pos) {
	    // Mouse click - use mouse position
	    particle_x_pos = mouse_x;
	    particle_y_pos = mouse_y;
	    show_debug_message("Using MOUSE position for particles");
	} else {
	    // Keyboard or controller - use bug center
	    particle_x_pos = x;
	    particle_y_pos = y;
	    show_debug_message("Using BUG CENTER for particles");
	}
    
    // COMBO-BASED PARTICLES (escalating feedback!)
    switch(combo_count) {
        case 0:
        case 1:
            scr_spawn_dirt_particles(particle_x_pos, particle_y_pos, 5);
            break;
        case 2:
        case 3:
            scr_spawn_gold_particles(particle_x_pos, particle_y_pos, 8);
            break;
        case 4:
        case 5:
            scr_spawn_magic_particles(particle_x_pos, particle_y_pos, 12);
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