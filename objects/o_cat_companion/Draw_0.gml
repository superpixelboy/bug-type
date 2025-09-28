// o_cat_companion Draw Event
// SAFETY: Using proper shadow system instead of simple ellipse

// DRAW SHADOW FIRST (using shadow system like other objects)
if (shadow_enabled && sprite_exists(sprite_index)) {
    draw_sprite_ext(
        sprite_index,                    // Use the cat's own sprite for shadow
        image_index,                     // Same frame as cat
        x + shadow_offset_x,             // Shadow X position
        y + shadow_offset_y,             // Shadow Y position
        shadow_scale_x * image_xscale,   // Shadow X scale
        shadow_scale_y * image_yscale,   // Shadow Y scale (flattened)
        image_angle,                     // Same rotation as cat
        c_black,                         // Black shadow color
        shadow_alpha                     // Shadow transparency
    );
}

// DRAW THE CAT SPRITE (main sprite on top)
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