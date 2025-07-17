/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x, y, o_player) && global.door_cooldown <= 0) {
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        // Save return position only from overworld
        if (room == Room1) {
            global.return_x = o_player.x;
            global.return_y = o_player.y;
            global.return_room = room;
        }
        
        room_goto(door_target_room);
    }
}