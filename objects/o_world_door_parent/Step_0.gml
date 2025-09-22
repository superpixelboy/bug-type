// o_world_door_parent - Step Event
// For doors that travel between world locations (not interiors)

if (place_meeting(x, y, o_player) && global.door_cooldown <= 0) {
    
    show_debug_message("=== WORLD DOOR TRANSITION ===");
    show_debug_message("From room: " + room_get_name(room));
    show_debug_message("To room: " + room_get_name(door_target_room));
    show_debug_message("Target spawn: " + string(door_entrance_x) + ", " + string(door_entrance_y));
    
    // DON'T set return_x/y for world doors - only for interior doors
    // The player is traveling to a new location, not entering a building
    
    // Set where player should spawn in the target room
    global.door_entrance_x = door_entrance_x;
    global.door_entrance_y = door_entrance_y;
    global.return_x= door_entrance_x;
	global.return_y= door_entrance_y;
    show_debug_message("Set global.door_entrance_x to: " + string(global.door_entrance_x));
    show_debug_message("Set global.door_entrance_y to: " + string(global.door_entrance_y));
    
    // Go to target room
    room_goto(door_target_room);
    
    show_debug_message("Room transition initiated");
    show_debug_message("=== END WORLD DOOR TRANSITION ===");
}