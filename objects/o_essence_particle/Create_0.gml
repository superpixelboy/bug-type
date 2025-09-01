// o_essence_particle Create Event - FIXED: Add depth for visibility
// Particle movement
target_x = 60;
target_y = 30;
flight_time = 40;
timer = 0;

// Store starting position
start_x = x;
start_y = y;

// Animation setup
image_speed = 0;  // Manual control
image_index = 0;  // Start with big white pixel

// Visual
image_xscale = 1;
image_yscale = 1;

// FIXED: Set depth so essence particles show above everything else
depth = -25000;