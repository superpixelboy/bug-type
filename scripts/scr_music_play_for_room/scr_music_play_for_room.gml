// ===========================================
// scr_music_play_for_room - Separate Script
// ===========================================

function scr_music_play_for_room() {
    var room_name = room_get_name(room);
    var room_lower = string_lower(room_name);
    
    // Check for menu/intro rooms
    if (string_pos("menu", room_lower) > 0 || 
        string_pos("intro", room_lower) > 0) {
        scr_music_play("menu");
        return;
    }
    
    // Check for collection/inventory rooms - DON'T change music
    if (string_pos("collection", room_lower) > 0 || 
        string_pos("inventory", room_lower) > 0 ||
        string_pos("bug_collection", room_lower) > 0) {
        // Keep current music playing - don't change
        show_debug_message("In collection room - keeping current music");
        return;
    }
    
    // For all other rooms (gameplay rooms), play level music
    scr_music_play("level_1");
}