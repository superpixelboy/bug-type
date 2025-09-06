// ===========================================
// scr_music_get_current_track - Separate Script
// ===========================================

function scr_music_get_current_track() {
    if (global.current_music == noone || !audio_is_playing(global.current_music)) {
        return "none";
    }
    
    // Find track name by comparing sound IDs
    var track_name = "unknown";
    var map_size = ds_map_size(global.music_tracks);
    var key = ds_map_find_first(global.music_tracks);
    
    repeat(map_size) {
        var sound_asset = ds_map_find_value(global.music_tracks, key);
        if (audio_get_name(global.current_music) == audio_get_name(sound_asset)) {
            track_name = key;
            break;
        }
        key = ds_map_find_next(global.music_tracks, key);
    }
    
    return track_name;
}