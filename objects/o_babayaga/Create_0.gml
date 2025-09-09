// o_ghost_raven_ow Create Event
// Replicating the beautiful dialogue system from o_ghost_raven_manager

// Dialogue system variables (copied from working ghost raven manager)
dialogue_active = false;
dialogue_index = 0;
dialogue_messages = [
    "You're here! And you're late!"
];

// Typewriter effect variables (exact same as ghost raven manager)
typewriter_text = "";
typewriter_char_index = 0;
typewriter_speed = 2; // Characters per frame (adjust for speed)
typewriter_timer = 0;
typewriter_complete = false;

// Input cooldown for dialogue
input_cooldown = 0;
dialogue_cooldown = 0;

// Interaction distance
interaction_distance = 1;