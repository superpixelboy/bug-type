// o_essence_particle Step Event
timer++;

// Fly toward target using smooth interpolation
var progress = timer / flight_time;
progress = clamp(progress, 0, 1);

x = lerp(start_x, target_x, progress);
y = lerp(start_y, target_y, progress);

// Animate the shrinking sprite based on progress (5 frames total: 0,1,2,3,4)
image_index = floor(progress * 4);  // 0 to 4 frames
image_index = clamp(image_index, 0, 4);

// Add some sparkle animation
image_alpha = 1 - (progress * 0.3);  // Slight fade but not completely invisible

// Destroy when reached target or fully shrunk
if (timer >= flight_time || image_index >= 4) {
    instance_destroy();
}