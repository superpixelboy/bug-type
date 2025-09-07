// o_ghost_raven_manager Step Event (Updated for Enhanced Fade)

if (input_cooldown > 0) input_cooldown--;

// Move clouds
cloud_x_offset += cloud_speed;

// Update raven floating animation
raven_float_timer += raven_float_speed;
raven_y = raven_base_y + sin(raven_float_timer) * raven_float_amplitude;

// Update raven sprite frame animation
raven_frame_timer++;
if (raven_frame_timer >= raven_frame_speed) {
    raven_frame_timer = 0;
    raven_frame++;
    if (raven_frame >= sprite_get_number(s_ghost_raven)) {
        raven_frame = 0;
    }
}

// Handle cutscene states
switch (cutscene_state) {
    case "fade_in":
        // Wait for fade controller to finish, then start raven entrance
        if (!instance_exists(o_fade_controller)) {
            cutscene_state = "raven_entrance";
        }
        break;
        
    case "raven_entrance":
        // Fade in the raven
        if (raven_alpha < 1) {
            raven_alpha += raven_fade_speed;
            if (raven_alpha >= 1) {
                raven_alpha = 1;
                cutscene_state = "waiting_for_dialogue";
                input_cooldown = 60;
            }
        }
        break;
        
    case "waiting_for_dialogue":
        if (input_cooldown <= 0) {
            dialogue_active = true;
            cutscene_state = "dialogue";
            
            // Initialize typewriter for first message
            var current_message = dialogue_messages[dialogue_index];
            typewriter_text = "";
            typewriter_char_index = 0;
            typewriter_complete = false;
            typewriter_timer = 0;
        }
        break;
        
    case "dialogue":
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
            input_cooldown = 10;
            
            if (!typewriter_complete) {
                var current_message = dialogue_messages[dialogue_index];
                typewriter_text = current_message;
                typewriter_char_index = string_length(current_message);
                typewriter_complete = true;
            }
            else if (dialogue_index < array_length(dialogue_messages) - 1) {
                dialogue_index++;
                audio_play_sound(sn_bugtap1, 1, false);
                
                var current_message = dialogue_messages[dialogue_index];
                typewriter_text = "";
                typewriter_char_index = 0;
                typewriter_complete = false;
                typewriter_timer = 0;
            } else {
                // Use enhanced fade controller for exit
                dialogue_active = false;
                cutscene_state = "fade_out";
                scr_fade_for_intro(rm_spooky_forest);
            }
        }
        break;
        
    case "fade_out":
        // Wait for fade controller to complete the transition
        // The fade controller will handle going to rm_spooky_forest
        break;
}