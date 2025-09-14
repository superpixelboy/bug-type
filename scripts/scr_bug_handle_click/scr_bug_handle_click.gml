function scr_bug_handle_click(use_mouse_pos) {
    // SAFETY: Default to false (bug center) if no parameter provided
    // This preserves existing behavior for any calls without parameters
    if (argument_count < 1) use_mouse_pos = false;
    
    switch(state) {
        case "idle":
            // Reset combo on first hit or return from idle
            combo_count = 0;
            scr_bug_do_damage(1, use_mouse_pos); // Pass through the input source
            audio_play_sound(sn_combo1, 1, false);
            break;
            
        case "recovering":
            // Perfect timing! Increase combo for feedback
            combo_count = min(combo_count + 1, 5);
            show_debug_message("Combo count: " + string(combo_count));
            scr_bug_do_damage(1, use_mouse_pos); // Pass through the input source
            scr_play_combo_sound(combo_count);
            break;
            
        case "ready_to_catch":
            // LEFT CLICK when ready = "wrong button" feedback
            combo_count = 0;  // Reset combo
            bounce_offset_x = random_range(-8, 8);
            bounce_offset_y = random_range(-4, 4);
            audio_play_sound(sn_bugtap1, 1, false);
            break;
    }
}