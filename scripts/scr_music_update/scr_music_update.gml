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
                global.current_music_asset = noone;
            }
        }
        return;
    }
    
    // Handle music transitions - FIXED: Compare assets, not instances
    if (global.target_music != global.current_music_asset) {
        show_debug_message("=== MUSIC TRANSITION NEEDED ===");
        show_debug_message("Current asset: " + (global.current_music_asset == noone ? "none" : audio_get_name(global.current_music_asset)));
        show_debug_message("Target asset: " + (global.target_music == noone ? "none" : audio_get_name(global.target_music)));
        
        // Fade out current music
        if (global.current_music != noone && audio_is_playing(global.current_music)) {
            var current_gain = audio_sound_get_gain(global.current_music);
            if (current_gain > 0) {
                audio_sound_gain(global.current_music, current_gain - global.music_fade_speed, 0);
                return; // Wait for fadeout to complete
            } else {
                show_debug_message("Stopping old music");
                audio_stop_sound(global.current_music);
                global.current_music = noone;
                global.current_music_asset = noone;
            }
        }
        
        // Start new music
        if (global.target_music != noone) {
            show_debug_message("Starting new music: " + audio_get_name(global.target_music));
            global.current_music = audio_play_sound(global.target_music, 1, true); // Loop = true
            global.current_music_asset = global.target_music; // Track the asset
            audio_sound_gain(global.current_music, 0, 0); // Start silent
            show_debug_message("Music started with ID: " + string(global.current_music));
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