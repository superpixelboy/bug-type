// o_babayaga Step Event
// ENHANCED: Dual interaction system - proximity OR very close touching

// Reduce dialogue cooldown
if (dialogue_cooldown > 0) dialogue_cooldown--;

// DUAL INTERACTION CHECK: Proximity OR Direct Touch
var player_distance = distance_to_object(o_player);
var can_interact_proximity = (player_distance < 32 && dialogue_cooldown <= 0); // Looking at from distance
var can_interact_touching = (player_distance < 8); // Direct touch - very close contact

// Can interact if EITHER in proximity OR touching
var can_interact = (can_interact_proximity || can_interact_touching) && !dialogue_active;

// FIRST: Handle dialogue interaction
if (can_interact) {
    if (keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
        if (!dialogue_active) {
            // Start dialogue
            dialogue_active = true;
            dialogue_index = 0;
            
            // Hide exclamation mark during dialogue
            if (instance_exists(o_player)) {
                o_player.show_exclamation = false;
                o_player.exclamation_appeared = false;
                o_player.exclamation_source = "none";
            }
            
            if (global.bugs_caught == 0) {
                dialogue_state = "greeting";
            } else if (global.bugs_caught < 5) {
                dialogue_state = "progress";
            } else {
                dialogue_state = "encouragement";
            }
        }
    }
}

// Handle dialogue progression
if (dialogue_active) {
    // FORCE HIDE exclamation mark every frame during dialogue
    if (instance_exists(o_player)) {
        o_player.show_exclamation = false;
        o_player.exclamation_alpha = max(o_player.exclamation_alpha - 0.2, 0);
        if (o_player.exclamation_source == "npc") {
            o_player.exclamation_source = "none";
        }
    }
    
    if (keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
        dialogue_index++;
        var current_dialogue;
        
        if (dialogue_state == "greeting") {
            current_dialogue = dialogue_greeting;
        } else if (dialogue_state == "progress") {
            current_dialogue = dialogue_progress;
        } else if (dialogue_state == "encouragement") {
            current_dialogue = dialogue_encouragement;
        }
        
        if (dialogue_index >= array_length(current_dialogue)) {
            // End dialogue
            dialogue_active = false;
            dialogue_cooldown = 30;
        }
    }
}

// LAST: Handle exclamation mark - ONLY when not in dialogue
if (!dialogue_active) {
    if (can_interact) {
        // Player can interact (proximity OR touching) and not in dialogue - show exclamation mark
        if (instance_exists(o_player) && (!o_player.show_exclamation || o_player.exclamation_source != "npc")) {
            o_player.show_exclamation = true;
            o_player.exclamation_appeared = false;
            o_player.exclamation_animation_timer = 0;
            o_player.exclamation_alpha = 0;
            o_player.exclamation_bounce_y = 0;
            o_player.exclamation_source = "npc";
        }
    } else {
        // Player is far away - hide exclamation mark (ONLY if we set it)
        if (instance_exists(o_player) && o_player.show_exclamation && o_player.exclamation_source == "npc") {
            o_player.show_exclamation = false;
            o_player.exclamation_appeared = false;
            o_player.exclamation_source = "none";
        }
    }
}