// o_ghost_raven Create Event  
// COMPLETE: Using the new NPC parent system with sprite

// Inherit from parent (gets all the interaction and dialogue systems)
event_inherited();

// SET SPRITE - This is probably what's missing!
sprite_index = s_ghost_raven_ow; // Make sure this sprite exists
image_speed = 0.1; // Animate the raven sprite if it has multiple frames

// SIMPLE: Just set the dialogue messages
npc_set_dialogue([
    "What are you waiting for? You've got to get to Baba Yaga's hut now!",
    "Just follow the trail to the East, you can't miss it."
]);

// Optional: Floating animation (like the original raven)
raven_float_timer = 0;
raven_float_speed = 0.02;
raven_float_amplitude = 8;
raven_base_y = y;