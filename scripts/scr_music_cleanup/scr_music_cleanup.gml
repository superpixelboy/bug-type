// ===========================================
// scr_music_cleanup - Separate Script
// ===========================================

function scr_music_cleanup() {
    if (ds_exists(global.music_tracks, ds_type_map)) {
        ds_map_destroy(global.music_tracks);
    }
    
    if (global.current_music != noone && audio_is_playing(global.current_music)) {
        audio_stop_sound(global.current_music);
    }
    
    // Reset all music globals
    global.current_music = noone;
    global.current_music_asset = noone;
    global.target_music = noone;
}