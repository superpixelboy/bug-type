// o_npc_parent Step Event  
// PASSIVE SYSTEM: Let player handle interaction detection (like rocks)

// Reduce cooldowns
if (input_cooldown > 0) input_cooldown--;
if (dialogue_cooldown > 0) dialogue_cooldown--;

// ONLY handle dialogue progression (no interaction detection)
// === REPLACE your current dialogue progression section with this ===

// === ADD DEBUG MESSAGES TO SEE WHAT'S HAPPENING ===

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
                show_debug_message("Typewriter complete for message " + string(dialogue_index));
            }
        }
    }
    
    // Handle dialogue input
    var pressed_next = (keyboard_check_pressed(vk_space) || 
                      keyboard_check_pressed(vk_enter) || 
                      mouse_check_button_pressed(mb_left));
    
    if (pressed_next && input_cooldown <= 0) {
        show_debug_message("SPACE PRESSED - dialogue_index: " + string(dialogue_index) + " / " + string(array_length(dialogue_messages)));
        
        if (typewriter_complete) {
            dialogue_index++;
            show_debug_message("Moving to dialogue_index: " + string(dialogue_index));
            
            if (dialogue_index >= array_length(dialogue_messages)) {
                show_debug_message("DIALOGUE SHOULD END NOW");
                
                // SPECIAL: Complete tutorial when finishing Baba Yaga's first dialogue
                if (object_index == o_babayaga && !global.met_baba_yaga) {
                    global.met_baba_yaga = true;
                    show_debug_message("✅ TUTORIAL COMPLETED! Bug catching unlocked!");
                    audio_play_sound(sn_bug_catch1, 1, false);
                }
                
                // END DIALOGUE (the essential part that was missing)
                dialogue_active = false;
                dialogue_cooldown = 30;
                input_cooldown = 10;
                
                // Reset typewriter
                typewriter_text = "";
                typewriter_char_index = 0;
                typewriter_complete = false;
                
                show_debug_message("DIALOGUE ENDED - dialogue_active: " + string(dialogue_active));
                
            } else {
                show_debug_message("Moving to next message");
                // Move to next message - CONTINUE DIALOGUE
                var current_message = dialogue_messages[dialogue_index];
                typewriter_text = "";
                typewriter_char_index = 0;
                typewriter_complete = false;
                typewriter_timer = 0;
                input_cooldown = 5;
            }
        } else {
            show_debug_message("Skipping to end of current message");
            // Skip to end of current message
            var current_message = dialogue_messages[dialogue_index];
            typewriter_text = current_message;
            typewriter_char_index = string_length(current_message);
            typewriter_complete = true;
            input_cooldown = 5;
        }
    }
}
