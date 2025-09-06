// ===========================================
// scr_music_play - Separate Script
// ===========================================

function scr_music_play(track_name) {
    show_debug_message("=== MUSIC PLAY REQUEST ===");
    show_debug_message("Track requested: " + track_name);
    show_debug_message("Music enabled: " + string(global.music_enabled));
    
    if (!global.music_enabled) {
        show_debug_message("Music disabled - skipping");
        return;
    }
    
    var track_sound = ds_map_find_value(global.music_tracks, track_name);
    
    if (track_sound == undefined) {
        show_debug_message("ERROR: Music track not found: " + track_name);
        // List available tracks for debugging
        var key = ds_map_find_first(global.music_tracks);
        show_debug_message("Available tracks:");
        repeat(ds_map_size(global.music_tracks)) {
            show_debug_message(" - " + key);
            key = ds_map_find_next(global.music_tracks, key);
        }
        return;
    }
    
    show_debug_message("Found track sound: " + audio_get_name(track_sound));
    
    // If same track is already playing, don't restart it
    if (global.current_music != noone && 
        audio_get_name(global.current_music) == audio_get_name(track_sound)) {
        show_debug_message("Music track already playing: " + track_name);
        return;
    }
    
    // Set target for smooth transition
    global.target_music = track_sound;
    
    show_debug_message("Target music set - will start on next update");
}