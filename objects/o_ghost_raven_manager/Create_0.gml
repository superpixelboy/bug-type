// o_ghost_raven_manager Create Event
// Fixed - removed fade variables since o_fade_controller handles fades now

// Cloud movement (same as main menu)
cloud_x_offset = 0;
cloud_speed = 0.1;

// Raven animation and movement
raven_x = room_width / 2;
raven_y = room_height / 2 - 60; // Move raven higher up in the hole
raven_float_timer = 0;
raven_float_speed = 0.02;
raven_float_amplitude = 8;
raven_base_y = raven_y;

// Raven sprite animation
raven_frame = 0;
raven_frame_timer = 0;
raven_frame_speed = 8; // Frames to hold each sprite frame

// Cutscene state management
cutscene_state = "fade_in"; // Start with fade in
raven_alpha = 0;
raven_fade_speed = 0.015;

// Dialogue system
dialogue_active = false;
dialogue_index = 0;
dialogue_messages = [
    "Wake up sleepy head!",
    "You've got to get to Baba Yaga's and do the Special Spell."
];

// Typewriter effect variables
typewriter_text = "";
typewriter_char_index = 0;
typewriter_speed = 2; // Characters per frame (adjust for speed)
typewriter_timer = 0;
typewriter_complete = false;

// Input cooldown
input_cooldown = 0;

// Create the initial fade in using the enhanced fade controller
// (Make sure you've created the scr_fade_in_room script first)
if (script_exists(asset_get_index("scr_fade_in_room"))) {
    scr_fade_in_room(0.02); // Slow dramatic fade for intro
} else {
    // Fallback: create fade controller manually
    var fade = instance_create_layer(0, 0, "Instances", o_fade_controller);
    fade.fade_alpha = 1; // Start black
    fade.fade_state = "room_entry";
    fade.fade_speed = 0.02;
}