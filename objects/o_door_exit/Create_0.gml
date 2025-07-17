event_inherited();  // Call parent create

// Set default values if globals don't exist yet
if (variable_global_exists("return_room")) {
    door_target_room = global.return_room;
    door_entrance_x = global.return_x;
    door_entrance_y = global.return_y;
} else {
    // Default to overworld if no return location set
    door_target_room = Room1;
    door_entrance_x = 326;  // Center of overworld (adjust as needed)
    door_entrance_y = 530;  // Center of overworld (adjust as needed)
}