// o_cat_npc Draw Event
// SAFETY: Simple sprite drawing, no modifications to existing systems
event_inherited();
// Apply the gentle sway offset
var draw_x = x;
var draw_y = y + sin(idle_sway_timer) * 0.3; // Very subtle vertical bob

// Draw the cat sprite
draw_sprite_ext(
    sprite_index,
    image_index,
    draw_x,
    draw_y,
    image_xscale,
    image_yscale,
    image_angle,
    c_white,
    image_alpha
);

// OPTIONAL: Draw a little shadow under the cat
// Uncomment if you want a shadow
/*
draw_set_alpha(0.3);
draw_ellipse_color(
    x - 8,
    y + 4,
    x + 8,
    y + 8,
    c_black,
    c_black,
    false
);
draw_set_alpha(1);
*/