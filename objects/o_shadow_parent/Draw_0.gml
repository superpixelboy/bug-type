// o_shadow_parent - Draw Event (Alternative Version)
// Draw shadow first using the object's own sprite
if (shadow_enabled && sprite_exists(sprite_index)) {
    draw_sprite_ext(
        sprite_index,          // Use the object's own sprite
        image_index,           // Same frame as object
        x + shadow_offset_x,   // X position
        y + shadow_offset_y,   // Y position
        shadow_scale_x * image_xscale,  // X scale (matches object scale)
        shadow_scale_y * image_yscale,  // Y scale (flattened)
        image_angle,           // Rotation (matches object)
        c_black,               // Color (black for shadow)
        shadow_alpha           // Alpha (transparency)
    );
}

// Then draw the main sprite on top
draw_self();