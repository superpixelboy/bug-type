// Check for player interaction
if (distance_to_object(o_player) < 32 && dialogue_cooldown <= 0) {
    if (keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
        if (!dialogue_active) {
            // Start dialogue
            dialogue_active = true;
            dialogue_index = 0;
            
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

// Handle dialogue progression with SPACE or mouse click
if (dialogue_active) {
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