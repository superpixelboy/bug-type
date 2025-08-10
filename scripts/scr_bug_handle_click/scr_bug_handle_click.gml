function scr_bug_handle_click() {
    switch(state) {
        case "idle":
            // Reset combo on first hit or return from idle
            combo_count = 0;
            scr_bug_do_damage(1);
            audio_play_sound(sn_combo1, 1, false);
            break;
            
    case "recovering":
    // Perfect timing! Increase combo for feedback
    combo_count = min(combo_count + 1, 5);
    show_debug_message("Combo count: " + string(combo_count)); // DEBUG LINE
    scr_bug_do_damage(1);
    scr_play_combo_sound(combo_count);
    break;
            
     case "ready_to_catch":
    // LEFT CLICK when ready = catch the bug!
    scr_bug_handle_catch();
    break;
    }
}