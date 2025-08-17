// o_dust_particle STEP Event

timer++;

// Fly toward target using smooth interpolation
var progress = timer / flight_time;
progress = clamp(progress, 0, 1);

x = lerp(start_x, target_x, progress);
y = lerp(start_y, target_y, progress);

// Animate the shrinking sprite based on progress
image_index = floor(progress * 4);  // 0 to 4 frames
image_index = clamp(image_index, 0, 4);

// NEW: Calculate fade based on progress
// Debug: Check if fade variables are set correctly
if (!variable_instance_exists(id, "alpha_start")) {
    alpha_start = 1.0;
    alpha_end = 0.0;
    fade_style = "ease_out";
}

switch(fade_style) {
    case "linear":
        current_alpha = lerp(alpha_start, alpha_end, progress);
        break;
        
    case "ease_out":
        // Fades slower at first, then faster
        var ease_progress = 1 - power(1 - progress, 3);
        current_alpha = lerp(alpha_start, alpha_end, ease_progress);
        break;
        
    case "ease_in":
        // Fades faster at first, then slower
        var ease_progress = power(progress, 3);
        current_alpha = lerp(alpha_start, alpha_end, ease_progress);
        break;
        
    default:
        // Fallback to linear
        current_alpha = lerp(alpha_start, alpha_end, progress);
        break;
}

// Debug: Show current alpha value
// show_debug_message("Progress: " + string(progress) + " Alpha: " + string(current_alpha));

// Destroy when reached target or fully shrunk
if (timer >= flight_time || image_index >= 4) {
    instance_destroy();
}