// o_player_jump_intro - Draw Event

// Draw the jumping player sprite
draw_self();

// Optional: Draw a subtle shadow that scales with height
var shadow_alpha = 0.3;
var distance_from_ground = abs(y - landing_y);
var shadow_scale = max(0.5, 1 - (distance_from_ground / target_height) * 0.5);

// Draw shadow at landing position
draw_sprite_ext(s_shadow, 0, x, landing_y + 8, 
    shadow_scale, shadow_scale * 0.3, 0, c_black, shadow_alpha);

// Debug info (remove when working)
if (keyboard_check(vk_f2)) {
    draw_set_color(c_yellow);
    draw_text(x - 50, y - 30, "State: " + state);
    draw_text(x - 50, y - 15, "Timer: " + string(jump_timer));
    draw_text(x - 50, y, "Frame: " + string(image_index));
    draw_set_color(c_white);
}