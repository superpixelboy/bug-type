// ===========================================
// o_game_manager Create Event
// ===========================================

// Initialize the music system
scr_music_init();

// Set depth for proper layering
depth = -10000;  // Very high priority

// Wait a frame before starting music to ensure everything is loaded
alarm[0] = 1;  // Will trigger music start

// Mark as persistent so it survives room changes
persistent = true;

show_debug_message("Game Manager created - Music system ready");