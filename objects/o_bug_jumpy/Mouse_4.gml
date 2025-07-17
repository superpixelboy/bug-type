if (state == "moving" && jump_cooldown <= 0) {
    if (random(1) < 0.7) {
        // Play jump sound
        audio_play_sound(sn_bug_jump1, 1, false);  // Your new sound!
        
        // Jump to random location
        x = random_range(64, room_width - 64);
        y = random_range(64, room_height - 64);
        jump_cooldown = 60;
    } else {
        // Got it!
        audio_play_sound(sn_bugtap1, 1, false);
        state = "poked";
        poke_timer = 0;
    }
}