// o_dust_particle DRAW Event

// Make sure current_alpha exists and has a valid value
if (!variable_instance_exists(id, "current_alpha")) {
    current_alpha = 1.0;
}

// Clamp alpha to valid range
current_alpha = clamp(current_alpha, 0, 1);

// Set the alpha for fading effect
draw_set_alpha(current_alpha);

// Alternative drawing method - try this if draw_self() doesn't work with alpha
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, current_alpha);

// IMPORTANT: Reset alpha back to 1 so other objects aren't affected
draw_set_alpha(1);