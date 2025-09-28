// o_cat_npc Create Event
// SAFETY: Using existing NPC parent system - no modifications to working code
// The static discovery version of the cat before it becomes a companion

// Inherit from NPC parent (gets all interaction and dialogue systems)
event_inherited();

// SPRITE SETUP - Using your beautiful cat sprites!
sprite_index = s_cat_idle_down; // Cat faces down initially
image_speed = 0.15; // Gentle idle animation

// INTERACTION RANGES - Slightly tighter than other NPCs for intimacy
interaction_range_facing = 32;  // Player must be fairly close to notice cat
interaction_range_touching = 10; // Or walk right up to it

// CAT PERSONALITY SETUP
cat_name = "Mystery Cat"; // Revealed after befriending

// DIALOGUE - Before befriending
// This will be the initial conversation that leads to befriending
npc_set_dialogue([
    "Mrrrow? *The cat looks up at you with curious eyes*",
    "*It sniffs your hand gently, then rubs against your legs*",
    "Purrrrr~ *The cat seems to have taken a liking to you!*",
    "*The cat starts following behind you, its tail swishing happily*"
]);

// BEFRIEND STATE TRACKING
// This flag determines if the cat should become a companion
cat_befriended = false; // Will be set to true after dialogue ends

// ENABLE SIMPLE PLAYER FACING
// Cat will look at player when they're nearby
can_face_player = true;
facing_range = 48;

// CAT IDLE BEHAVIOR (while waiting to be discovered)
// Gentle swaying/breathing animation
idle_sway_timer = 0;
idle_sway_speed = 0.00;
idle_sway_amount = 0.0;

// DISCOVERY FLAG - Has player found this cat yet?
// This will prevent the cat from appearing until discovered
if (!variable_global_exists("cat_discovered")) {
    global.cat_discovered = false;
}

if (!variable_global_exists("cat_befriended")) {
    global.cat_befriended = false;
}

// If already befriended, this static NPC shouldn't exist
// (The companion version o_cat_companion should exist instead)
if (global.cat_befriended) {
    instance_destroy();
    exit;
}

// Mark as discovered when created (player entered the room with the cat)
global.cat_discovered = true;


// ===== CAT SHADOW CONFIGURATION =====
// Manual shadow setup for companion cat (since it doesn't inherit from shadow_parent)
shadow_enabled = true;
shadow_offset_x = 2;        // Slight offset to the right (cats have small shadows)
shadow_offset_y = 4;        // Just below the cat's base
shadow_scale_x = 1.1;       // Slightly narrower than the cat sprite
shadow_scale_y = 0.5;       // Flat, cat-like shadow
shadow_alpha = 0.35;        // Semi-transparent, natural looking

