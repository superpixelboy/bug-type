// o_bug_selector - Step Event
if (menu_active) {
    // Navigation
    if (keyboard_check_pressed(vk_up)) {
        selected_index = max(0, selected_index - 1);
        audio_play_sound(sn_bugtap1, 1, false);
    }
    if (keyboard_check_pressed(vk_down)) {
        selected_index = min(array_length(bug_list) - 1, selected_index + 1);
        audio_play_sound(sn_bugtap1, 1, false);
    }
    
    // Selection
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        global.next_forced_bug = bug_list[selected_index].id;
        audio_play_sound(sn_bug_catch1, 1, false);
        menu_active = false;
        
        // Show confirmation message
        show_debug_message("Selected bug: " + bug_list[selected_index].name);
    }
    
    // Close menu
    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_f1)) {
        menu_active = false;
    }
}