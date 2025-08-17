// o_player_jump_intro - Create Event (ENHANCED WITH FASTER DOUBLE SPIN)

// Jump animation states - now with cleaning!
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
y = hole_center_y - 20;  // Start slightly below hole center
start_y = hole_center_y - 20;
target_height = 20;
landing_y = hole_center_y + 20;  // Land below the hole

// Animation timing - adjusted for faster cleaning sequence
rise_duration = 30;
fall_duration = 35;
pause_duration = 80;     // NEW: Pause while dirty
spin_duration = 32;      // REDUCED: Faster spinning (was 40)
total_duration = rise_duration + fall_duration + pause_duration + spin_duration;

// Set initial dirty sprite
sprite_index = s_player_jump_dirty;  // Use your new dirty jump sprite
image_speed = 0;
image_index = 0;

// Scaling
image_xscale = 1;
image_yscale = 1;

// Store hole reference
hole_x = hole_center_x;
hole_y = hole_center_y;
depth = -1000;

// NEW: Faster cleaning spin variables
spin_timer = 0;
spin_direction_index = 0;  // 0=down, 1=left, 2=up, 3=right
spin_frame_duration = 4;   // FASTER: 4 frames per direction (was 8)
particles_spawned = false;

// Disable player during sequence
if (instance_exists(o_player)) {
    o_player.visible = false;
    o_player.movement_mode = "disabled";
}
// Make camera follow the jump intro
var cam = view_camera[0];
camera_set_view_target(cam, id);  // Follow this jump object