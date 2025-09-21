if (place_meeting(x, y, o_player) && global.door_cooldown <= 0) {
	
	// Debug output
	show_debug_message("=== DOOR TRANSITION ===");
	show_debug_message("From room: " + room_get_name(room));
	show_debug_message("To room: " + room_get_name(door_target_room));
	show_debug_message("Target spawn: " + string(door_entrance_x) + ", " + string(door_entrance_y));
	
	// Set the player's spawn coordinates BEFORE changing rooms
	with (o_player) {
	    spawn_x = other.door_entrance_x;
	    spawn_y = other.door_entrance_y;
	    show_debug_message("Player spawn_x set to: " + string(spawn_x));
	    show_debug_message("Player spawn_y set to: " + string(spawn_y));
	}
	
	// Change to the target room (FIXED: was "target_room", should be "door_target_room")
	room_goto(door_target_room);
	
	show_debug_message("Room transition initiated");
	show_debug_message("=== END DOOR TRANSITION ===");
	
    // Save return position
    global.return_x = o_player.x;
    global.return_y = o_player.y;
    global.return_room = room;
    
    // Set where player should spawn in the target room
    global.door_entrance_x = door_entrance_x;
    global.door_entrance_y = door_entrance_y;
    
    room_goto(door_target_room);
}