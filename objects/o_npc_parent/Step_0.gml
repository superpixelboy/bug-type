// o_npc_parent Step Event  
// PASSIVE SYSTEM: Let player handle interaction detection (like rocks)

// Reduce cooldowns
if (input_cooldown > 0) input_cooldown--;
if (dialogue_cooldown > 0) dialogue_cooldown--;

// ONLY handle dialogue progression (no interaction detection)
if (dialogue_active) {
    // Force hide exclamation during dialogue
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
                npc_end_dialogue();
            } else {
                // Move to next message
                npc_continue_dialogue();
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

// NOTE: Interaction detection is now handled by o_player Step event (like rocks)