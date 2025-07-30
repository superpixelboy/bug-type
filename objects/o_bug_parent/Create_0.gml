// ===========================================
// NEW: Bug data system
bug_type = "unknown";
bug_name = "Unknown Bug";
flavor_text = "";


// Core bug stats (override in child objects)
bug_hp = 3;              // Much lower HP for 1-damage system
bug_max_hp = 3;          
recovery_window =15;    // 30 frames recovery for combo feel
essence_value = 2;       // Essence gained when caught (override in children)

combo_count = 0;  // Track combo for feedback only

// Simplified state system
state = "idle";          // idle, recovering, ready_to_catch, caught
current_hp = bug_hp;

// Timing variables
recovery_timer = 0;

// Animation
image_speed = 0;
image_index = 0;
anim_timer = 0;
image_xscale = 3;
image_yscale = 3;
xstart = x;
ystart = y;
image_alpha = 1;
base_scale_x = 3;
base_scale_y = 3;
capture_scale = 1;
// Visual effects
flash_timer = 0;
is_flashing = false;

// Scale bounce for satisfying feedback
scale_bounce_x = 0;
scale_bounce_y = 0;
base_scale_x = 3;
base_scale_y = 3;
wobble_angle = 0;
reaction_timer = 0;

// Capture animation
capture_scale = 1;
capture_y_offset = 0;
capture_timer = 0;


// Bounce feedback
bounce_offset_x = 0;
bounce_offset_y = 0;
bounce_decay = 0.8;

// Auto-catch system
auto_catch_enabled = true;
auto_catch_timer = 0;
auto_catch_interval = 10;  // Damage every 10 frames
catch_progress = 0;
catch_bar_width = 200;

//Final Info
caught_timer = 0;