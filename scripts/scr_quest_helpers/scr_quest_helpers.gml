/// @description Quest management helper functions

/// Get quest by ID
function scr_get_quest(quest_id) {
    if (!variable_global_exists("quests")) return undefined;
    
    for (var i = 0; i < array_length(global.quests); i++) {
        if (global.quests[i].id == quest_id) {
            return global.quests[i];
        }
    }
    return undefined;
}

/// Get all active quests for display in To Do tab
function scr_get_active_quests() {
    var active_quests = [];
    
    if (!variable_global_exists("quests")) return active_quests;
    
    for (var i = 0; i < array_length(global.quests); i++) {
        var quest = global.quests[i];
        if (quest.status == "active") {
            array_push(active_quests, quest);
        }
    }
    
    return active_quests;
}

/// Unlock a quest
function scr_unlock_quest(quest_id) {
    var quest = scr_get_quest(quest_id);
    if (quest != undefined && quest.status == "locked") {
        quest.status = "active";
        show_debug_message("QUEST UNLOCKED: " + quest.name);
        
        // TODO: Show quest notification to player
        return true;
    }
    return false;
}

/// Complete a quest
function scr_complete_quest(quest_id) {
    var quest = scr_get_quest(quest_id);
    if (quest != undefined && quest.status == "active") {
        quest.status = "completed";
        
        // Mark all objectives as completed
        for (var i = 0; i < array_length(quest.objectives); i++) {
            quest.objectives[i].completed = true;
        }
        
        show_debug_message("QUEST COMPLETED: " + quest.name);
        
        // TODO: Show quest completion notification
        // TODO: Give rewards
        
        return true;
    }
    return false;
}

/// Update quest progress (for objectives with progress tracking)
function scr_update_quest_progress(quest_id, objective_index, new_progress) {
    var quest = scr_get_quest(quest_id);
    if (quest != undefined && quest.status == "active") {
        if (objective_index >= 0 && objective_index < array_length(quest.objectives)) {
            var objective = quest.objectives[objective_index];
            
            if (variable_struct_exists(objective, "progress")) {
                objective.progress = new_progress;
                
                // Check if objective is complete
                if (variable_struct_exists(objective, "target")) {
                    if (objective.progress >= objective.target) {
                        objective.completed = true;
                        show_debug_message("OBJECTIVE COMPLETED: " + objective.text);
                    }
                }
            }
        }
    }
}