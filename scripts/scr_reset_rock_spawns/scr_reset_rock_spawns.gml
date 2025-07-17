/// @description Reset all rock spawns for new day/session
function scr_reset_rock_spawns() {
    // Clear spawned rocks (forces new random generation)
    ds_map_clear(global.spawned_rocks);
    
    // Optionally clear flipped rocks too for complete reset
    ds_list_clear(global.flipped_rocks);
    
    // Save current player position before restart
    global.temp_player_x = o_player.x;
    global.temp_player_y = o_player.y;
    global.is_sleeping = true;  // Flag to know we're sleeping
    
    // Restart the room to regenerate
    room_restart();
}