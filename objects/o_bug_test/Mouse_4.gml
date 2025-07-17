if (state == "moving") {
    audio_play_sound(sn_bugtap1, 1, false);  // Add this line
    state = "poked";
    poke_timer = 0;
}