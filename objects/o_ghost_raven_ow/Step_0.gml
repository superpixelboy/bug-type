// First run parent step (handles dialogue progression, cooldowns, etc.)
event_inherited();

// FLOATING ANIMATION (like other ghosts)
float_timer += float_speed;
y = base_y + sin(float_timer) * float_amplitude;