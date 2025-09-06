// ===========================================
// o_game_manager Room Start Event
// ===========================================

// Automatically play appropriate music for the new room
scr_music_play_for_room();

show_debug_message("Room changed to: " + room_get_name(room));