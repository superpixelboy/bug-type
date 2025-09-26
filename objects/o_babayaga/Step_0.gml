// === o_babayaga Step Event - QUEST PROGRESSION ===
// This should run AFTER the parent NPC interaction logic
event_inherited();

// === QUEST PROGRESSION TRIGGER ===
// When dialogue starts, check if we should progress quests
if (dialogue_active && dialogue_index == 0) {
    // REFRESH DIALOGUE based on current quest status
    dialogue_messages = scr_babayaga_refresh_dialogue();
    
    show_debug_message("🔄 Dialogue refreshed! New message count: " + string(array_length(dialogue_messages)));
    
    var quest_1 = scr_get_quest("find_baba_yaga");
    
    // If Quest 1 is still active, complete it NOW (player found Baba Yaga!)
    if (quest_1 != undefined && quest_1.status == "active") {
        show_debug_message("🎯 QUEST PROGRESSION: Player found Baba Yaga!");
        
        // Complete Quest 1 (this also unlocks Quest 2 via on_complete callback)
        if (quest_1.on_complete != undefined) {
            quest_1.on_complete();
        }
        
        // Play a satisfying sound for quest completion
        audio_play_sound(sn_bug_catch1, 1, false);
        
        // Optional: Visual feedback (screen flash)
        scr_screen_flash(c_white, 0.2, 15);
        
        show_debug_message("✅ Quest 1 completed! Quest 2 unlocked!");
        
        // IMMEDIATELY refresh dialogue to show Quest 2 messages
        dialogue_messages = scr_babayaga_refresh_dialogue();
    }
}

// === QUEST 2 PROGRESS TRACKING ===
// Update Quest 2 objectives based on bug count
var quest_2 = scr_get_quest("summoning_spell");
if (quest_2 != undefined && quest_2.status == "active") {
    // Update the "Catch 10 bugs" objective progress
    scr_update_quest_progress("summoning_spell", 0, global.bugs_caught);
    
    // Auto-complete Quest 2 if player has caught 10+ bugs
    if (global.bugs_caught >= 10 && quest_2.objectives[0].completed) {
        // Check if we haven't already completed it
        if (quest_2.status == "active") {
            show_debug_message("🎯 QUEST 2 AUTO-COMPLETE: Player has 10+ bugs!");
            
            if (quest_2.on_complete != undefined) {
                quest_2.on_complete();
            }
            
            // Satisfying completion feedback
            audio_play_sound(sn_bug_catch1, 1, false);
            scr_screen_flash(c_yellow, 0.3, 20);
            
            show_debug_message("✅ Quest 2 completed automatically!");
        }
    }
}