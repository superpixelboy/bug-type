// o_ghost_raven Step Event
// OPTIONAL: Add floating animation while keeping parent interaction system

// Call parent step event (handles all interaction and dialogue)
event_inherited();

// OPTIONAL: Floating animation
raven_float_timer += raven_float_speed;
y = raven_base_y + sin(raven_float_timer) * raven_float_amplitude;