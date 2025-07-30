// obj_shadow - Create Event
sprite_index = s_shadow;
image_speed = 0;
image_index = 0;
owner = noone; // Will be set by the parent object
depth = 1000;  // Make sure shadows draw behind everything

// obj_shadow - Step Event
// If owner no longer exists, destroy this shadow
if (!instance_exists(owner)) {
    instance_destroy();
}

// obj_shadow - Draw Event  
// Simple draw - the sprite already has the right opacity/blend
draw_self();