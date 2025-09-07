// o_door_parent Step Event
// SAFETY: Adding exclamation mark system while preserving existing door functionality

// Check if player is overlapping the door
var player_on_door = place_meeting(x, y, o_player);

// Handle exclamation mark display for doors
if (player_on_door && global.door_cooldown <= 0) {
    // Player is on door and can interact - show exclamation mark
    if (instance_exists(o_player) && (!o_player.show_exclamation || o_player.exclamation_source != "door")) {
        o_player.show_exclamation = true;
        o_player.exclamation_appeared = false;
        o_player.exclamation_animation_timer = 0;
        o_player.exclamation_alpha = 0;
        o_player.exclamation_bounce_y = 0;
        o_player.exclamation_source = "door";
    }
} else {
    // Player is not on door or cooldown active - hide exclamation mark (ONLY if we set it)
    if (instance_exists(o_player) && o_player.show_exclamation && o_player.exclamation_source == "door") {
        o_player.show_exclamation = false;
        o_player.exclamation_appeared = false;
        o_player.exclamation_source = "none";
    }
}

// UPDATED DOOR INTERACTION - Space/Click only for consistency
if (player_on_door && global.door_cooldown <= 0) {
    // Only Space/Click for consistent interaction across all game elements
    var door_pressed = (keyboard_check_pressed(vk_space) ||
                       mouse_check_button_pressed(mb_left));
    
    if (door_pressed) {
        // Hide exclamation mark when entering
        if (instance_exists(o_player)) {
            o_player.show_exclamation = false;
            o_player.exclamation_appeared = false;
            o_player.exclamation_source = "none";
        }
        
        // Save return position only from overworld (PRESERVED ORIGINAL LOGIC)
        if (room == rm_spooky_forest) {
            global.return_x = o_player.x;
            global.return_y = o_player.y;
            global.return_room = room;
        }
        
        room_goto(door_target_room);
    }
}