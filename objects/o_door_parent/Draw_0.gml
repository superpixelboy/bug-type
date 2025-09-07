// TEMPORARY DEBUG - Add this to o_door_parent Draw Event
// Remove after testing

// Draw door hitbox for debugging
draw_set_alpha(0.3);
draw_set_color(c_green);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
draw_set_alpha(1);
draw_set_color(c_white);

// Show door state
if (instance_exists(o_player)) {
    var player_on_door = place_meeting(x, y, o_player);
    draw_set_color(c_yellow);
    draw_text(x, y - 20, "On Door: " + string(player_on_door));
    draw_text(x, y - 5, "Cooldown: " + string(global.door_cooldown));
    draw_text(x, y + 10, "Target: " + string(door_target_room));
    draw_set_color(c_white);
}