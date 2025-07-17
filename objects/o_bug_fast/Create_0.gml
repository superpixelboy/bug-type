// Fast bug behavior - more aggressive than normal bug
state = "moving";
move_timer = 0;
move_direction = random(360);
move_speed = 2.5;  // Faster than normal bug (was 1)
poke_timer = 0;

// Animation setup
image_speed = 0;
image_index = 0;
anim_timer = 0;

// Scaling for big view
image_xscale = 2;
image_yscale = 2;