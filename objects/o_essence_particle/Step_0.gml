timer++;

// Fly toward target using smooth interpolation
var progress = timer / flight_time;
x = lerp(start_x, target_x, progress);
y = lerp(start_y, target_y, progress);

// Animate the shrinking sprite based on progress
image_index = floor(progress * 4);  // 0 to 4 frames
image_index = clamp(image_index, 0, 4);

// Destroy when reached target or fully shrunk
if (timer >= flight_time || image_index >= 4) {
    instance_destroy();
}