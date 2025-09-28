// ===========================================
// o_game_manager Room Start Event
// ===========================================

// Automatically play appropriate music for the new room
scr_music_play_for_room();

show_debug_message("Room changed to: " + room_get_name(room));

// Add this to your main game controller's Room Start event
// Or create o_cat_controller with this in Room Start
// SAFETY: Only spawns cat, doesn't modify existing room logic

// Spawn cat companion if befriended (but not in special rooms)
var special_rooms = [rm_rock_catching, rm_main_menu, rm_backstory, rm_backstory_hole];
var is_special_room = false;

for (var i = 0; i < array_length(special_rooms); i++) {
    if (room == special_rooms[i]) {
        is_special_room = true;
        break;
    }
}

// Spawn cat in normal gameplay rooms
if (!is_special_room) {
    cat_spawn_companion_in_room();
}