// Make sure the flipped rocks list always exists
if (!variable_global_exists("flipped_rocks")) {
    global.flipped_rocks = ds_list_create();
}

// Make sure other globals exist too
if (!variable_global_exists("last_rock_used")) {
    global.last_rock_used = false;
}

if (!variable_global_exists("current_rock_id")) {
    global.current_rock_id = "";
}

// Restore player position when returning to overworld
if (room == Room1) {  // Your main overworld room
    var player = instance_find(o_player, 0);
    if (player != noone) {
        player.x = global.return_x;
        player.y = global.return_y;
    }
}

// Position player at door entrance if coming from another room
if (variable_global_exists("door_entrance_x")) {
    o_player.x = global.door_entrance_x;
    o_player.y = global.door_entrance_y;
}

// Set door cooldown when entering any room
global.door_cooldown = 30;  // Half second cooldown

// Position player at return location only when going back to overworld
if (room == Room1 && variable_global_exists("return_x")) {
    o_player.x = global.return_x;
    o_player.y = global.return_y;
}

// Existing code for flipped rocks, door cooldown, etc...


// Handle sleep position restoration
if (variable_global_exists("is_sleeping") && global.is_sleeping) {
    if (instance_exists(o_player)) {
        o_player.x = global.temp_player_x;
        o_player.y = global.temp_player_y;
    }
    global.is_sleeping = false;
}
// Position player at door entrance when coming FROM a door
else if (variable_global_exists("door_entrance_x")) {
    o_player.x = global.door_entrance_x;
    o_player.y = global.door_entrance_y;
    // Clear the door entrance globals so they don't interfere next time
    global.door_entrance_x = undefined;
    global.door_entrance_y = undefined;
}