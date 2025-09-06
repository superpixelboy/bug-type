// ===========================================
// scr_music_update - Separate Script
// ===========================================

function scr_music_update() {
    if (!global.music_enabled) {
        // Fade out if music is disabled
        if (global.current_music != noone && audio_is_playing(global.current_music)) {
            var current_gain = audio_sound_get_gain(global.current_music);
            if (current_gain > 0) {
                audio_sound_gain(global.current_music, current_gain - global.music_fade_speed, 0);
            } else {
                audio_stop_sound(global.current_music);
                global.current_music = noone;
            }
        }
        return;
    }
    
    // Handle music transitions
    if (global.target_music != global.current_music) {
        
        // Fade out current music
        if (global.current_music != noone && audio_is_playing(global.current_music)) {
            var current_gain = audio_sound_get_gain(global.current_music);
            if (current_gain > 0) {
                audio_sound_gain(global.current_music, current_gain - global.music_fade_speed, 0);
                return; // Wait for fadeout to complete
            } else {
                audio_stop_sound(global.current_music);
                global.current_music = noone;
            }
        }
        
        // Start new music
        if (global.target_music != noone) {
            global.current_music = audio_play_sound(global.target_music, 1, true); // Loop = true
            audio_sound_gain(global.current_music, 0, 0); // Start silent
            show_debug_message("Started new music track");
        }
    }
    
    // Fade in new music
    if (global.current_music != noone && audio_is_playing(global.current_music)) {
        var current_gain = audio_sound_get_gain(global.current_music);
        if (current_gain < global.music_volume) {
            audio_sound_gain(global.current_music, min(current_gain + global.music_fade_speed, global.music_volume), 0);
        }
    }
}