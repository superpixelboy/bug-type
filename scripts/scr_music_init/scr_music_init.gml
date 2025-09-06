// ===========================================
// scr_music_init - Separate Script
// ===========================================

function scr_music_init() {
    // Global music state
    global.current_music = noone;  // The audio instance ID
    global.current_music_asset = noone;  // The sound asset being played
    global.target_music = noone;   // The sound asset we want to play
    global.music_volume = 0.7;  // Default volume
    global.music_fade_speed = 0.02;  // How fast transitions happen
    global.music_enabled = true;
    global.music_crossfade_enabled = true;
    
    // Music definitions - easy to expand for new levels/events
    global.music_tracks = ds_map_create();
    
    // NOW USING SEPARATE TRACKS: intro for menu, main_theme for gameplay
    ds_map_add(global.music_tracks, "menu", sn_intro);       // ← NEW: Uses sn_intro for menus
    ds_map_add(global.music_tracks, "level_1", sn_main_theme); // ← Uses sn_main_theme for gameplay
    
    // Add future tracks here as you create them:
    // ds_map_add(global.music_tracks, "level_2", sn_forest_theme);
    // ds_map_add(global.music_tracks, "level_3", sn_cave_theme);
    // ds_map_add(global.music_tracks, "boss", sn_boss_theme);
    // ds_map_add(global.music_tracks, "victory", sn_victory_theme);
    // ds_map_add(global.music_tracks, "ambient", sn_ambient_test);
    
    show_debug_message("Music Manager initialized with " + string(ds_map_size(global.music_tracks)) + " tracks");
    show_debug_message("Menu music: " + audio_get_name(sn_intro));
    show_debug_message("Level music: " + audio_get_name(sn_main_theme));
}