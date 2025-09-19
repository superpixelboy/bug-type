// o_npc_parent Create Event
// Universal NPC system with rock-style interactions
event_inherited();
// INTERACTION SYSTEM (exact same as rocks)
interaction_range_facing = 28;  // Looking at NPC from distance
interaction_range_touching = 8; // Direct touch

// DIALOGUE SYSTEM
dialogue_active = false;
dialogue_index = 0;
dialogue_messages = [];  // Override this in child NPCs
dialogue_cooldown = 0;
input_cooldown = 0;

// TYPEWRITER EFFECT
typewriter_text = "";
typewriter_char_index = 0;
typewriter_speed = 2;
typewriter_timer = 0;
typewriter_complete = false;

// STORY SYSTEM - Override these in child NPCs
story_conditions = {};  // Example: {"bugs_caught": 5, "visited_witch": true}
story_dialogue_sets = {}; // Different dialogue for different story states

// EVENTS SYSTEM - Functions to call when dialogue triggers/ends
on_dialogue_start = -1;  // Script to run when dialogue starts
on_dialogue_end = -1;    // Script to run when dialogue ends
on_story_event = -1;     // Script to run for story progression

// UTILITY FUNCTIONS - Call these in child Create events
/// npc_set_dialogue(messages_array)
/// npc_add_story_dialogue(condition_name, condition_value, messages_array)
/// npc_set_events(start_script, end_script, story_script)

depthMod = 0;

// PLAYER FACING SYSTEM (OPTIONAL - TOGGLEABLE PER NPC)
// SIMPLE VERSION: Only left/right facing with sprite flipping
can_face_player = false;           // Set to true in child NPCs to enable
facing_range = 48;                 // How close player needs to be for NPC to face them
facing_left = true;                // true = facing left (default), false = facing right

// FACING COOLDOWN - Prevents rapid direction switching
facing_update_timer = 0;
facing_update_delay = 8;          