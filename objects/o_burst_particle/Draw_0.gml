// o_essence_particle Draw Event

// Calculate animation progress (0.0 to 1.0)
var progress = timer / flight_time;
progress = clamp(progress, 0, 1);

// Interpolate color from dark purple to white (opposite of before)
var start_color = make_color_rgb(100, 10, 100);  // Dark purple at start
var end_color = c_white;  // White at end

// Use merge_color for smooth interpolation
var current_color = merge_color(start_color, end_color, progress);

// Draw the sprite with the interpolated color
draw_sprite_ext(
    sprite_index, 
    image_index, 
    x, y, 
    image_xscale, image_yscale, 
    image_angle, 
    current_color,  // Color changes from white to purple
    image_alpha
);