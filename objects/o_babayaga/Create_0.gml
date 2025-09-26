// === ENHANCED o_babayaga Create Event WITH QUEST PROGRESSION ===
event_inherited();
shadow_enabled = false;

// SET SPRITE for Baba Yaga
sprite_index = s_bugayuga;
image_speed = 0.1;
interaction_range_facing = 100;
interaction_range_touching = 100;

// === QUEST-AWARE DIALOGUE SYSTEM ===
// Initialize dialogue with current quest status
// NOTE: This will be refreshed every time dialogue starts (see Step Event)
dialogue_messages = scr_babayaga_refresh_dialogue();

// Debug logging - Get quest status separately for logging
var _quest_1 = scr_get_quest("find_baba_yaga");
var _quest_2 = scr_get_quest("summoning_spell");

show_debug_message("=== BABA YAGA CREATE EVENT ===");
show_debug_message("Quest 1 status: " + (_quest_1 != undefined ? _quest_1.status : "UNDEFINED"));
show_debug_message("Quest 2 status: " + (_quest_2 != undefined ? _quest_2.status : "UNDEFINED"));
show_debug_message("Bugs caught: " + string(global.bugs_caught));
show_debug_message("Current room: " + string(room_get_name(room)));
show_debug_message("Dialogue messages set: " + string(array_length(dialogue_messages)));