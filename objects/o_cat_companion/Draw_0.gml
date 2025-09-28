// o_cat_companion Draw Event
// SAFETY: Simple sprite drawing with optional shadow

// Draw cat sprite normally
draw_sprite_ext(
    sprite_index,
    image_index,
    x,
    y,
    image_xscale,
    image_yscale,
    image_angle,
    c_white,
    image_alpha
);

// OPTIONAL: Draw cute shadow under cat
draw_set_alpha(0.25);
draw_ellipse_color(
    x - 6,
    y + 3,
    x + 6,
    y + 7,
    c_black,
    c_black,
    false
);
draw_set_alpha(1);