// o_cat_npc Draw Event
// SAFETY: Using shadow parent system while preserving sway animation
// Modified to work with the shadow system instead of manual drawing

// Calculate the gentle sway offset
var sway_y = sin(idle_sway_timer) * 0.3; // Very subtle vertical bob

// DRAW SHADOW FIRST (using shadow parent system)
// Draw shadow at the base position (no sway for shadow - stays grounded)
if (shadow_enabled && sprite_exists(sprite_index)) {
    draw_sprite_ext(
        sprite_index,                    // Use the cat's own sprite for shadow
        image_index,                     // Same frame as cat
        x + shadow_offset_x,             // Shadow X position (no sway)
        y + shadow_offset_y,             // Shadow Y position (stays on ground)
        shadow_scale_x * image_xscale,   // Shadow X scale
        shadow_scale_y * image_yscale,   // Shadow Y scale (flattened)
        image_angle,                     // Same rotation as cat
        c_black,                         // Black shadow color
        shadow_alpha                     // Shadow transparency
    );
}

// DRAW THE CAT SPRITE (with sway animation)
draw_sprite_ext(
    sprite_index,
    image_index,
    x,                    // Cat X position
    y + sway_y,           // Cat Y position WITH sway animation
    image_xscale,
    image_yscale,
    image_angle,
    c_white,
    image_alpha
);