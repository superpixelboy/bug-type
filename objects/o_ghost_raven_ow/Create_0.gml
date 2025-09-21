event_inherited();

// SET SPRITE for Baba Yaga
sprite_index = s_ghost_raven_ow // Set the Baba Yaga sprite
image_speed = 1; // Animate if sprite has multiple frames
dialogue_messages = [
    "What are you waiting for? You've got to get to Baba Yaga's hut now!",
    "Just follow the trail to the East, you can't miss it."
];

can_face_player = true;
facing_range = 80;    

// FLOATING ANIMATION (like other ghosts)
float_timer = 0;
float_speed = 0.03;
float_amplitude = 3;
base_y = y;


// Configure shadows for trees
shadow_offset_x = 6;      // Slight offset to the right
shadow_offset_y = 15;      // Below the tree base
shadow_scale_x = 0.8;     // Narrower than tree
shadow_scale_y = 0.5;     // Very flat
shadow_alpha = 0.3;       // More transparent for natural look