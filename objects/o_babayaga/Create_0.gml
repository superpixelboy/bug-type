// === ENHANCED o_babayaga Create Event ===
event_inherited();

// SET SPRITE for Baba Yaga
sprite_index = s_bugayuga; // Set the Baba Yaga sprite
image_speed = 0.1; // Animate if sprite has multiple frames

interaction_range_facing = 100;  // Looking at NPC from distance
interaction_range_touching = 100; 

// ENHANCED: Tutorial tracking dialogue
if (!global.met_baba_yaga) {
    // First time meeting - tutorial dialogue
    dialogue_messages = [
        "Ah, my young apprentice awakens!",
        "I need you to collect magical bugs for my potions.",
        "Different creatures hold different powers...",
        "Start with the forest - look under every rock!",
        "Go now, the magic awaits you!"
    ];
} else {
    // Already completed tutorial - ongoing dialogue
    if (global.bugs_caught == 0) {
        dialogue_messages = [
            "The rocks are waiting, my dear.",
            "Remember - look under every stone!"
        ];
    } else if (global.bugs_caught < 5) {
        dialogue_messages = [
            "You have " + string(global.bugs_caught) + " bugs so far.",
            "Keep searching - I need many more!"
        ];
    } else {
        dialogue_messages = [
            "Excellent work, apprentice!",
            "The mossy rocks hide swift creatures.",
            "Cracked stones conceal mysterious bugs."
        ];
    }
}


show_debug_message("=== BABA YAGA CREATE EVENT ===");
show_debug_message("Current met_baba_yaga: " + string(global.met_baba_yaga));
show_debug_message("Current room: " + string(room_get_name(room)));

// ADD this to help track when tutorial gets set incorrectly
if (global.met_baba_yaga == true) {
    show_debug_message("⚠️ WARNING: Tutorial already completed when Baba Yaga created!");
}

// === TEMPORARY: Add this to room entry/exit events ===
// Add to rm_wichhouse Room Start event:
show_debug_message("Entering witch house. Tutorial state: " + string(global.met_baba_yaga));

// Add to rm_wichhouse Room End event:
show_debug_message("Leaving witch house. Tutorial state: " + string(global.met_baba_yaga));