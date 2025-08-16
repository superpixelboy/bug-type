// o_player_jump_intro - Create Event

// Jump animation states
state = "rising";
jump_timer = 0;

// Find the hole object to get proper positioning
var hole_obj = instance_find(o_hole, 0);
var hole_center_x = x;
var hole_center_y = y;

if (instance_exists(hole_obj)) {
    hole_center_x = hole_obj.x;
    hole_center_y = hole_obj.y;
}

// Position and movement
x = hole_center_x;
y = hole_center_y;
start_y = hole_center_y;
target_height = 80;  // Much higher jump (pixels above start)
landing_y = hole_center_y - 25;  // Land further away from hole center

// Animation timing
rise_duration = 30;   // Longer upward motion for higher jump
fall_duration = 35;   // Longer downward motion
total_duration = rise_duration + fall_duration;

// Set initial sprite and animation
sprite_index = s_player_jump;
image_speed = 0;  // Manual control
image_index = 0;

// Scaling to match main player
image_xscale = 1;
image_yscale = 1;

// Store reference to hole position for landing calculation
hole_x = hole_center_x;
hole_y = hole_center_y;

// Set depth to be above hole and other objects
depth = -1000;

// Disable player during jump sequence
if (instance_exists(o_player)) {
    o_player.visible = false;
    o_player.movement_mode = "disabled";  // Use existing movement system
}