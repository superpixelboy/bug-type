// ===========================================
// o_game_manager Step Event - COMPLETE VERSION
// ===========================================

// CRITICAL: Update music system every frame
scr_music_update();

// DEBUG COMMANDS (add these for testing):

// DEBUG: Press M to manually test music
if (keyboard_check_pressed(ord("M"))) {
    show_debug_message("=== MANUAL MUSIC TEST ===");
    scr_music_play("menu");
}

// DEBUG: Press N to stop music
if (keyboard_check_pressed(ord("N"))) {
    show_debug_message("=== STOPPING MUSIC ===");
    if (global.current_music != noone) {
        audio_stop_sound(global.current_music);
        global.current_music = noone;
        global.current_music_asset = noone;
        global.target_music = noone;
    }
}

// DEBUG: Press B to test basic audio (bypassing music system)
if (keyboard_check_pressed(ord("B"))) {
    show_debug_message("=== BASIC AUDIO TEST ===");
    show_debug_message("Playing sn_main_theme directly...");
    var test_id = audio_play_sound(sn_main_theme, 1, false);
    show_debug_message("Direct audio ID: " + string(test_id));
}

// DEBUG: Press V to test volume
if (keyboard_check_pressed(ord("V"))) {
    show_debug_message("=== MUSIC STATUS ===");
    show_debug_message("Music enabled: " + string(global.music_enabled));
    show_debug_message("Current music: " + (global.current_music == noone ? "none" : string(global.current_music)));
    show_debug_message("Current asset: " + (global.current_music_asset == noone ? "none" : audio_get_name(global.current_music_asset)));
    show_debug_message("Target music: " + (global.target_music == noone ? "none" : audio_get_name(global.target_music)));
    show_debug_message("Volume: " + string(global.music_volume));
    if (global.current_music != noone) {
        show_debug_message("Is playing: " + string(audio_is_playing(global.current_music)));
        show_debug_message("Current gain: " + string(audio_sound_get_gain(global.current_music)));
    }
}