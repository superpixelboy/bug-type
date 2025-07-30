if (!variable_instance_exists(id, "shadow_enabled")) {
    shadow_enabled = true;
    shadow_offset_x = 2;
    shadow_offset_y = 4;
    shadow_alpha = 0.5;
    shadow_scale_x = 1.0;
    shadow_scale_y = 0.6;
}


if (shadow_enabled) {
    // Draw shadow (simple alpha approach)
    draw_sprite_ext(sprite_index, image_index, 
        x + shadow_offset_x, y + shadow_offset_y,
        shadow_scale_x, shadow_scale_y, 
        image_angle, c_black, shadow_alpha);
}


// Draw the sprite
draw_self();