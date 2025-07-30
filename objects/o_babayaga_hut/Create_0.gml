// obj_babayaga_hut - Create Event
image_speed = 1; // Use default speed since animations are already timed
image_index = 0;

// Animation states
enum HutState {
    IDLE_STANDING,
    SITTING_DOWN,
    SITTING_STILL,
    STANDING_UP
}

state = HutState.IDLE_STANDING;
interaction_distance = 100; // Adjust based on your tile size
can_enter = false;

// Set initial sprite
sprite_index = s_yaga_hut_idle;