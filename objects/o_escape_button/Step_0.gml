// In o_bug_parent Step Event:
if (keyboard_check_pressed(vk_escape)) {
    // Create confirmation or just escape with visual feedback
    audio_play_sound(sn_rock_click, 1, false);  // Feedback sound
    room_goto_previous();
}