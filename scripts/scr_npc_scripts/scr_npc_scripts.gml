function scr_npc_scripts(){
	exit;
}

// SCRIPT: npc_start_dialogue()
// Starts dialogue and determines which dialogue set to use
function npc_start_dialogue() {
    dialogue_active = true;
    dialogue_index = 0;
    input_cooldown = 10;
    
    // Hide exclamation mark
    if (instance_exists(o_player)) {
        o_player.show_exclamation = false;
        o_player.exclamation_appeared = false;
        o_player.exclamation_source = "none";
    }
    
    // Determine which dialogue to use based on story conditions
    dialogue_messages = npc_get_current_dialogue();
    
    // Initialize typewriter for first message
    if (array_length(dialogue_messages) > 0) {
        var current_message = dialogue_messages[dialogue_index];
        typewriter_text = "";
        typewriter_char_index = 0;
        typewriter_complete = false;
        typewriter_timer = 0;
    }
    
    // Call custom start event
    if (on_dialogue_start != -1 && script_exists(on_dialogue_start)) {
        script_execute(on_dialogue_start);
    }
    
    // Play interaction sound
    var snd = asset_get_index("sn_bugtap1");
    if (snd != -1) audio_play_sound(snd, 1, false);
}

// SCRIPT: npc_end_dialogue()
// Ends dialogue and triggers story events
function npc_end_dialogue() {
    dialogue_active = false;
    dialogue_cooldown = 60;  // Prevent immediate re-interaction
    
    // ADD: Global input cooldown to prevent collection button opening
    global.input_cooldown = 30;
    
    // Call custom end event
    if (on_dialogue_end != -1 && script_exists(on_dialogue_end)) {
        script_execute(on_dialogue_end);
    }
    
    // Call story progression event
    if (on_story_event != -1 && script_exists(on_story_event)) {
        script_execute(on_story_event);
    }
}

// SCRIPT: npc_continue_dialogue()
// Moves to next dialogue message
function npc_continue_dialogue() {
    var current_message = dialogue_messages[dialogue_index];
    typewriter_text = "";
    typewriter_char_index = 0;
    typewriter_complete = false;
    typewriter_timer = 0;
    input_cooldown = 5;
}

// SCRIPT: npc_get_current_dialogue()
// Returns appropriate dialogue based on story conditions
function npc_get_current_dialogue() {
    // Check story conditions and return appropriate dialogue
    // Override this in child NPCs for custom logic
    return dialogue_messages;
}

// SCRIPT: npc_set_dialogue(messages)
// Helper to set basic dialogue in child Create events
function npc_set_dialogue(messages) {
    dialogue_messages = messages;
}

// SCRIPT: npc_check_story_condition(condition_name, condition_value)
// Helper to check story conditions
function npc_check_story_condition(condition_name, condition_value) {
    if (variable_struct_exists(story_conditions, condition_name)) {
        return story_conditions[condition_name] == condition_value;
    }
    return false;
}