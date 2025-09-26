/// @description Initialize global quest system
/// Call this once at game start (in o_UI_Manager or similar)

function scr_initialize_quests() {
    // Create global quest array
    global.quests = [];
    
    var _quest_count = 0;
    
    // Quest 1: Find Baba Yaga (STARTS ACTIVE)
    global.quests[_quest_count] = {
        id: "find_baba_yaga",
        name: "Seek the Witch",
        description: "Find Baba Yaga in the deep woods to begin your magical training.",
        status: "active", // Player starts with this quest active
        objectives: [
            {text: "Explore the forest", completed: false},
            {text: "Find Baba Yaga", completed: false}
        ],
        reward_type: "unlock",
        reward_description: "Begin your magical journey",
        on_complete: function() {
            // When this quest completes, unlock the next quest
            scr_complete_quest("find_baba_yaga");
            scr_unlock_quest("summoning_spell");
        }
    };
    _quest_count++;
    
    // Quest 2: Summoning Spell (initially locked) - NOW TRACKS ESSENCE!
    global.quests[_quest_count] = {
        id: "summoning_spell", 
        name: "Summoning Practice",
        description: "Gather 100 essence to prepare for your first summoning spell.",
        status: "locked", // Starts locked until first quest completes
        objectives: [
            {text: "Gather 100 essence", completed: false, progress: 0, target: 100}
        ],
        reward_type: "spell",
        reward_description: "Learn your first summoning spell",
        on_complete: function() {
            scr_complete_quest("summoning_spell");
            // Future: Add spell to player abilities
        }
    };
    _quest_count++;
    
    global.total_quests = _quest_count;
    
    show_debug_message("Quests initialized: " + string(global.total_quests) + " quests");
}