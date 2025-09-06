// o_ghost_raven_manager Step Event

if (input_cooldown > 0) input_cooldown--;

// Move clouds (same as main menu)
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
    case "raven_entrance":
        // Fade in the raven
        if (raven_alpha < 1) {
            raven_alpha += raven_fade_speed;
            if (raven_alpha >= 1) {
                raven_alpha = 1;
                // Wait a moment before starting dialogue
                cutscene_state = "waiting_for_dialogue";
                input_cooldown = 60; // 1 second delay
            }
        }
        break;
        
    case "waiting_for_dialogue":
        if (input_cooldown <= 0) {
            dialogue_active = true;
            cutscene_state = "dialogue";
            // Initialize typewriter for first message
            typewriter_text = "";
            typewriter_char_index = 0;
            typewriter_complete = false;
        }
        break;
        
    case "dialogue":
        // Handle dialogue input
        var pressed_next = (keyboard_check_pressed(vk_space) || 
                          keyboard_check_pressed(vk_enter) || 
                          mouse_check_button_pressed(mb_left));
        
        if (pressed_next && input_cooldown <= 0) {
            input_cooldown = 10;
            
            if (dialogue_index < array_length(dialogue_messages) - 1) {
                // Next dialogue message
                dialogue_index++;
                audio_play_sound(sn_bugtap1, 1, false); // Use existing sound
            } else {
                // End dialogue and proceed to game
                dialogue_active = false;
                cutscene_state = "complete";
            }
        }
        break;
        
    case "complete":
        // Transition to the main game
        room_goto(rm_spooky_forest); // or whatever your first game room is
        break;
}