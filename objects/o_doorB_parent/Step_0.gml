if (place_meeting(x, y, o_player) && global.door_cooldown <= 0) {
    // Save return position
    global.return_x = o_player.x;
    global.return_y = o_player.y;
    global.return_room = room;
    
    // Set where player should spawn in the target room
    global.door_entrance_x = door_entrance_x;
    global.door_entrance_y = door_entrance_y;
    
    room_goto(door_target_room);
}