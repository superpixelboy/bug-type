// ===========================================
// scr_music_init - Separate Script
// ===========================================

function scr_music_init() {
    // Global music state
    global.current_music = noone;
    global.target_music = noone;
    global.music_volume = 0.7;  // Default volume
    global.music_fade_speed = 0.02;  // How fast transitions happen
    global.music_enabled = true;
    global.music_crossfade_enabled = true;
    
    // Music definitions - easy to expand for new levels/events
    global.music_tracks = ds_map_create();
    
    // Register your music tracks
    ds_map_add(global.music_tracks, "menu", sn_intro);
    ds_map_add(global.music_tracks, "level_1", sn_main_theme);
    // Add future tracks here as you create them:
    // ds_map_add(global.music_tracks, "level_2", sn_forest_theme);
    // ds_map_add(global.music_tracks, "level_3", sn_cave_theme);
    // ds_map_add(global.music_tracks, "boss", sn_boss_theme);
    // ds_map_add(global.music_tracks, "victory", sn_victory_theme);
    // ds_map_add(global.music_tracks, "ambient", sn_ambient_test);
    
    show_debug_message("Music Manager initialized with " + string(ds_map_size(global.music_tracks)) + " tracks");
}