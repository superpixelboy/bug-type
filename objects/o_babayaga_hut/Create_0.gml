// o_babayaga_hut - Create Event
// Call parent first to set up shadows
event_inherited();

// Animation states
image_speed = 1;
image_index = 0;

enum HutState {
    IDLE_STANDING,
    SITTING_DOWN,
    SITTING_STILL,
    STANDING_UP
}

state = HutState.IDLE_STANDING;
interaction_distance = 100;
can_enter = false;

// Set initial sprite
sprite_index = s_yaga_hut_idle;

// Configure shadow for the hut (large building shadow)
shadow_enabled = true;
shadow_offset_x = 3;      // Offset to the right
shadow_offset_y = 38;     // Below the hut base
shadow_scale_x = 1.1;     // Slightly wider than hut
shadow_scale_y = 0.4;     // Flat shadow for large object
shadow_alpha = 0.4;       // Semi-transparent