/// @description Refresh Baba Yaga's dialogue based on current quest status
/// Call this every time dialogue starts to get updated messages

function scr_babayaga_refresh_dialogue() {
    // Check quest status
    var quest_1 = scr_get_quest("find_baba_yaga");
    var quest_2 = scr_get_quest("summoning_spell");
    
    // CASE 1: First time meeting (Quest 1 active)
    if (quest_1 != undefined && quest_1.status == "active") {
        return [
            "Ah, my young apprentice awakens!",
            "You've found me at last. Welcome!",
            "I need you to collect magical bugs for my potions.",
            "Different creatures hold different powers...",
            "Start with the forest - look under every rock!",
            "Go now, the magic awaits you!"
        ];
    }
    // CASE 2: Quest 1 complete, Quest 2 just unlocked (player just starting bug collection)
    else if (quest_1 != undefined && quest_1.status == "completed" && 
             quest_2 != undefined && quest_2.status == "active" && 
             global.bugs_caught == 0) {
        return [
            "Now begins your true training!",
            "Collect 10 bugs for your first summoning spell.",
            "Each creature you catch strengthens your magic.",
            "The rocks are waiting, my dear."
        ];
    }
    // CASE 3: Working on Quest 2 (catching bugs)
    else if (quest_2 != undefined && quest_2.status == "active" && global.bugs_caught > 0) {
        var bugs_needed = 10;
        var bugs_remaining = bugs_needed - global.bugs_caught;
        
        if (global.bugs_caught < 5) {
            return [
                "You have " + string(global.bugs_caught) + " bugs so far.",
                "Only " + string(bugs_remaining) + " more needed!",
                "Keep searching - I believe in you!"
            ];
        } else if (global.bugs_caught < 10) {
            return [
                "Excellent progress! " + string(global.bugs_caught) + " bugs collected!",
                "Just " + string(bugs_remaining) + " more to go.",
                "The mossy rocks hide swift creatures.",
                "Cracked stones conceal mysterious bugs."
            ];
        } else {
            // 10+ bugs - ready to complete quest!
            return [
                "Magnificent work, apprentice!",
                "You've collected enough essence!",
                "Your first summoning spell is ready...",
                "But that's a lesson for another day."
            ];
        }
    }
    // CASE 4: Quest 2 complete (fallback dialogue)
    else if (quest_2 != undefined && quest_2.status == "completed") {
        return [
            "Your training progresses well!",
            "Continue exploring the magical world.",
            "There is always more to learn..."
        ];
    }
    // CASE 5: Fallback (shouldn't happen, but safe)
    else {
        return [
            "Ah, my apprentice returns!",
            "The forest holds many secrets.",
            "Keep exploring, young one."
        ];
    }
}