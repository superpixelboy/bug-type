// o_ghost_raven_ow Step Event
// Player interaction and dialogue system

// Reduce cooldowns
if (input_cooldown > 0) input_cooldown--;
if (dialogue_cooldown > 0) dialogue_cooldown--;

// Check for player interaction (same pattern as o_babayaga)
if (distance_to_object(o_player) < interaction_distance && dialogue_cooldown <= 0) {
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
    // Process typewriter effect (exact same logic as ghost raven manager)
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
    
    // Handle dialogue input (same pattern as ghost raven manager)
    var pressed_next = (keyboard_check_pressed(vk_space) || 
                      keyboard_check_pressed(vk_enter) || 
                      mouse_check_button_pressed(mb_left));
    
    if (pressed_next && input_cooldown <= 0) {
        input_cooldown = 10;
        
        if (!typewriter_complete) {
            // Fast-forward current message
            var current_message = dialogue_messages[dialogue_index];
            typewriter_text = current_message;
            typewriter_char_index = string_length(current_message);
            typewriter_complete = true;
        }
        else if (dialogue_index < array_length(dialogue_messages) - 1) {
            // Move to next message
            dialogue_index++;
            
            // Play advance sound
            var snd = asset_get_index("sn_bugtap1");
            if (snd != -1) audio_play_sound(snd, 1, false);
            
            // Initialize typewriter for next message
            var current_message = dialogue_messages[dialogue_index];
            typewriter_text = "";
            typewriter_char_index = 0;
            typewriter_complete = false;
            typewriter_timer = 0;
        } else {
            // End dialogue
            dialogue_active = false;
            dialogue_cooldown = 60; // Prevent immediate restart
        }
    }
}