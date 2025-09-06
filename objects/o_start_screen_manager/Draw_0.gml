// o_start_screen_manager Draw Event (World coordinates)
// Using your beautiful pre-made sprites!

// Layer 1: Draw moving clouds background (s_title_clouds) - positioned higher
if (sprite_exists(s_title_clouds)) {
    // Get cloud sprite dimensions
    var cloud_width = sprite_get_width(s_title_clouds);
    var cloud_height = sprite_get_height(s_title_clouds);
    
    // Position clouds higher up - adjust this offset to control height
    var cloud_vertical_offset = -cloud_height * 0.45; // Move clouds up by 30% of their height
    
    // Calculate how many tiles we need to cover the screen
    var tiles_x = ceil(room_width / cloud_width) + 2; // Extra for seamless scrolling
    var tiles_y = ceil((room_height + abs(cloud_vertical_offset)) / cloud_height) + 1;
    
    // Draw tiled clouds with slow horizontal movement, positioned higher
    for (var ty = 0; ty < tiles_y; ty++) {
        for (var tx = -1; tx < tiles_x; tx++) {
            var cloud_x = (tx * cloud_width) - (cloud_x_offset % cloud_width);
            var cloud_y = (ty * cloud_height) + cloud_vertical_offset;
            draw_sprite(s_title_clouds, 0, cloud_x, cloud_y);
        }
    }
} else {
    // Fallback: Simple sunset gradient
    draw_set_color(make_color_rgb(255, 140, 60)); // Orange sunset
    draw_rectangle(0, 0, room_width, room_height, false);
    show_debug_message("WARNING: s_title_clouds missing, using fallback");
}

// Layer 2: Black overlay with hole cut out (s_title_black)
if (sprite_exists(s_title_black)) {
    // Center the black overlay on screen
    var black_x = room_width / 2;
    var black_y = room_height / 2;
    draw_sprite(s_title_black, 0, black_x, black_y);
} else {
    // Fallback: Simple black screen
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    show_debug_message("WARNING: s_title_black missing, using fallback");
}

// Reset color for other elements
draw_set_color(c_white);