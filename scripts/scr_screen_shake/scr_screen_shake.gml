
function screen_shake(intensity) {
    // Move the camera slightly
    var cam = view_camera[0];
    var shake_x = random_range(-intensity, intensity);
    var shake_y = random_range(-intensity, intensity);
    
    camera_set_view_pos(cam, 
        camera_get_view_x(cam) + shake_x,
        camera_get_view_y(cam) + shake_y
    );
    
    // Reset camera position after a few frames
    call_later(3, time_source_units_frames, function() {
        var cam = view_camera[0];
        camera_set_view_pos(cam, 0, 0);
    });
}