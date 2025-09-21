// o_ghost_girl Create Event
// SAFETY: Building on existing NPC parent - no modifications to working systems

// Inherit from parent (gets all interaction and dialogue systems)
event_inherited();

// SPRITE SETUP
sprite_index = s_ghost_girl_normal; // Normal visible state
image_speed = 0.1; // Gentle animation

// GHOST BEHAVIOR VARIABLES
ghost_state = "normal"; // "normal" or "hiding"
hiding_sprite = s_ghost_girl_hide; // Sprite when hiding
normal_sprite = s_ghost_girl_normal; // Sprite when visible

// DIALOGUE SETUP - Two different dialogue sets
// Hiding dialogue (when player is looking at her)
hiding_dialogue = [
    "I'm invisible. If I can't see you, you can't see me."
];

// Normal dialogue (when player is facing away)
normal_dialogue = [
    "You have to help me! I am in love but I'm too shy to say anything.",
    "There's this really cute witch who comes by sometimes...",
    "But every time I try to talk to her, I get so scared I turn invisible!",
    "Maybe you could help me find the courage to speak up?"
];

// Set initial dialogue to normal (we'll override this in Step event)
npc_set_dialogue(normal_dialogue);

// SPECIAL INTERACTION RULE: When normal, can interact from any direction
// When hiding, use standard facing rules only
special_interaction_rule = "omnidirectional_when_normal";

// FLOATING ANIMATION (like other ghosts)
float_timer = 0;
float_speed = 0.03;
float_amplitude = 3;
base_y = y;

// ENABLE SIMPLE PLAYER FACING SYSTEM
can_face_player = true;
facing_range = 100;     // A bit closer range for shy ghost

// Configure shadows for trees
shadow_offset_x = 6;      // Slight offset to the right
shadow_offset_y = 12;      // Below the tree base
shadow_scale_x = 0.8;     // Narrower than tree
shadow_scale_y = 0.5;     // Very flat
shadow_alpha = 0.3;       // More transparent for natural look