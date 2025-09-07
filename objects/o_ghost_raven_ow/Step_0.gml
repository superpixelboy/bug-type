// o_ghost_raven_ow Step Event
// ENHANCED: Dual interaction system - proximity OR very close touching

// Reduce cooldowns
if (input_cooldown > 0) input_cooldown--;
if (dialogue_cooldown > 0) dialogue_cooldown--;

// DUAL INTERACTION CHECK: Proximity OR Direct Touch
var player_distance = distance_to_object(o_player);
var can_interact_proximity = (player_distance < interaction_distance && dialogue_cooldown <= 0); // Looking at from distance
var can_interact_touching = (player_distance < 8); // Direct touch - very close contact

// Can interact if EITHER in proximity OR touching
var can_interact = (can_interact_proximity || can_interact_touching) && !dialogue_active;

// FIRST: Handle dialogue interaction
if (can_interact) {
    // Space or mouse click to start dialogue
    if ((keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) && !dialogue_active) {
        // Start dialogue
        dialogue_active = true;
        dialogue_index = 0;
        input_cooldown = 10;
        
        // Hide exclamation mark during dialogue
        if (instance_exists(o_player)) {
            o_player.show_exclamation = false;
            o_player.exclamation_appeared = false;
            o_player.exclamation_source = "none";
        }
        
        // Initialize typewriter for first message
        var current_message = dialogue_messages[dialogue_index];
        typewriter_text = "";
        typewriter_char_index = 0;
        typewriter_complete = false;
        typewriter_timer = 0;
        
        // Play interaction sound
        var snd = asset_get_index("sn_bugtap1");
        if (snd != -1) audio_play_sound(snd, 1, false);
    }
}

// Handle dialogue progression when dialogue is active
if (dialogue_active) {
    // FORCE HIDE exclamation mark every frame during dialogue
    if (instance_exists(o_player)) {
        o_player.show_exclamation = false;
        o_player.exclamation_alpha = max(o_player.exclamation_alpha - 0.2, 0);
        if (o_player.exclamation_source == "npc") {
            o_player.exclamation_source = "none";
        }
    }
    
    // Process typewriter effect
    if (!typewriter_complete) {
        typewriter_timer++;
        if (typewriter_timer >= typewriter_speed) {
            typewriter_timer = 0;
            var current_message = dialogue_messages[dialogue_index];
            
            if (typewriter_char_index < string_length(current_message)) {
                typewriter_char_index++;
                typewriter_text = string_copy(current_message, 1, typewriter_char_index);
            } else {
                typewriter_complete = true;
            }
        }
    }
    
    // Handle dialogue input
    var pressed_next = (keyboard_check_pressed(vk_space) || 
                      keyboard_check_pressed(vk_enter) || 
                      mouse_check_button_pressed(mb_left));
    
    if (pressed_next && input_cooldown <= 0) {
        if (typewriter_complete) {
            dialogue_index++;
            
            if (dialogue_index >= array_length(dialogue_messages)) {
                // End dialogue
                dialogue_active = false;
                dialogue_cooldown = 60;
            } else {
                // Move to next message
                var current_message = dialogue_messages[dialogue_index];
                typewriter_text = "";
                typewriter_char_index = 0;
                typewriter_complete = false;
                typewriter_timer = 0;
                input_cooldown = 5;
            }
        } else {
            // Skip to end of current message
            var current_message = dialogue_messages[dialogue_index];
            typewriter_text = current_message;
            typewriter_char_index = string_length(current_message);
            typewriter_complete = true;
            input_cooldown = 5;
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