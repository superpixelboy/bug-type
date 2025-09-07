// o_ghost_raven_ow Create Event
// Replicating the beautiful dialogue system from o_ghost_raven_manager

// Dialogue system variables (copied from working ghost raven manager)
dialogue_active = false;
dialogue_index = 0;
dialogue_messages = [
    "What are you waiting for? You've got to get to Baba Yaga's hut now!",
    "Just follow the trail to the East, you can't miss it."
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
interaction_distance = 32;