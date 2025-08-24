// SAFETY: Setting up escape button for GUI rendering
// Stop any automatic animation
image_speed = 0; 
image_index = 0; // Start on frame 0 (normal state)

// GUI positioning (will be calculated in Draw GUI event)
// Position in LOWER LEFT corner, moved a bit to the right
gui_x_offset = 120;  // Distance from LEFT edge (moved right from 80 to 120)
gui_y_offset = 80;   // Distance from BOTTOM of GUI

// Hover detection variables  
is_hovered = false;
hover_scale = 1.0;
base_scale = 2.0;  // Button scale for GUI rendering

// Helper variable for visibility logic
should_hide = false;