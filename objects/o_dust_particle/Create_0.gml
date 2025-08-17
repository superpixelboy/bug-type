// o_dust_particle CREATE Event

// Movement variables (can be overridden by spawn functions)
target_x = x;
target_y = y;
flight_time = 40;
timer = 0;

// Store starting position
start_x = x;
start_y = y;

// Animation setup
image_speed = 0;  // Manual control
image_index = 0;  // Start with big white pixel

// Visual scaling
image_xscale = 1;
image_yscale = 1;

// NEW: Fade variables
alpha_start = 1.0;      // Starting opacity
alpha_end = 0.0;        // Ending opacity (fully transparent)
current_alpha = alpha_start;

// Fade style options: "linear", "ease_out", "ease_in"
fade_style = "ease_out";  // Default fade style