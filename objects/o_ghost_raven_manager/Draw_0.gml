// o_ghost_raven_manager Draw Event
// Working version that you had before

// Layer 1: Background with sunset gradient
draw_set_color(make_color_rgb(255, 140, 60)); // Orange sunset
draw_rectangle(0, 0, room_width, room_height, false);

// Try to draw clouds if available
var cloud_sprite = asset_get_index("s_title_clouds");
if (cloud_sprite != -1 && sprite_exists(cloud_sprite)) {
    var cloud_width = sprite_get_width(cloud_sprite);
    var cloud_height = sprite_get_height(cloud_sprite);
    var cloud_vertical_offset = -cloud_height * 0.45;
    var tiles_x = ceil(room_width / cloud_width) + 2;
    var tiles_y = ceil((room_height + abs(cloud_vertical_offset)) / cloud_height) + 1;
    
    for (var ty = 0; ty < tiles_y; ty++) {
        for (var tx = -1; tx < tiles_x; tx++) {
            var cloud_x = (tx * cloud_width) - (cloud_x_offset % cloud_width);
            var cloud_y = (ty * cloud_height) + cloud_vertical_offset;
            draw_sprite(cloud_sprite, 0, cloud_x, cloud_y);
        }
    }
}

// Layer 2: Create hole effect
var black_sprite = asset_get_index("s_title_black");
if (black_sprite != -1 && sprite_exists(black_sprite)) {
    var black_x = room_width / 2;
    var black_y = room_height / 2;
    draw_sprite(black_sprite, 0, black_x, black_y);
} else {
    // Manual hole effect
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    
    var hole_x = room_width / 2;
    var hole_y = room_height / 2;
    var hole_radius = 120;
    
    gpu_set_blendmode(bm_subtract);
    draw_set_color(c_white);
    draw_circle(hole_x, hole_y, hole_radius, false);
    gpu_set_blendmode(bm_normal);
}

// Reset color
draw_set_color(c_white);

// Layer 3: Draw the ghost raven
if (sprite_exists(s_ghost_raven) && raven_alpha > 0) {
    draw_sprite_ext(s_ghost_raven, raven_frame, raven_x, raven_y, 1, 1, 0, c_white, raven_alpha);
}