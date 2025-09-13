/// o_intro_manager : Step Event - Enhanced with Controller Support
// SAFETY: Only adds controller input to existing variables - no other changes

if (input_cooldown > 0) input_cooldown--;

// ENHANCED: Add controller support to existing input detection
var pressed_next = (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left));
var pressed_quit = keyboard_check_pressed(vk_escape);

// NEW: Add controller input support
if (variable_global_exists("input_manager")) {
    // Make sure input manager is updated
    scr_update_input_manager();
    
    // Add controller face buttons for advancing
    if (global.input_manager.controller_connected) {
        var gp = global.input_manager.controller_slot;
        
        // A button or X button to advance (like Space/Enter)
        if (gamepad_button_check_pressed(gp, gp_face1) || gamepad_button_check_pressed(gp, gp_face3)) {
            pressed_next = true;
        }
        
        // B button to quit (like Escape)
        if (gamepad_button_check_pressed(gp, gp_face2)) {
            pressed_quit = true;
        }
    }
} else {
    // Fallback: Direct controller check if input manager not available
    for (var i = 0; i < 12; i++) {
        if (gamepad_is_connected(i)) {
            // A button or X button to advance
            if (gamepad_button_check_pressed(i, gp_face1) || gamepad_button_check_pressed(i, gp_face3)) {
                pressed_next = true;
            }
            
            // B button to quit
            if (gamepad_button_check_pressed(i, gp_face2)) {
                pressed_quit = true;
            }
            break; // Use first connected controller
        }
    }
}

// === EXISTING CODE BELOW - UNCHANGED ===

// ESC: skip entire intro quickly
if (pressed_quit) {
    global_fade = "out";
    fade_speed  = 0.12;
}

// Screen fade-in/out
switch (global_fade) {
    case "in": {
        fade_alpha -= fade_speed;
        if (fade_alpha <= 0) {
            fade_alpha  = 0;
            global_fade = "show";
        }
        break;
    }
    case "show": {
        // Handle per-page fade state
        switch (page_state) {
            case "fade_in": {
                // Allow skipping fade by pressing next
                if (pressed_next && input_cooldown <= 0) {
                    input_cooldown = 6;
                    page_alpha = 1;
                    page_state = "hold";
               //     _tap();
                } else {
                    page_alpha += page_fade_speed;
                    if (page_alpha >= 1) {
                        page_alpha = 1;
                        page_state = "hold";
                    }
                }
                break;
            }
            case "hold": {
                if (pressed_next && input_cooldown <= 0) {
                    input_cooldown = 6;
                    // Advance to next page or finish
                    if (page_index < array_length(pages) - 1) {
                        page_index++;
                        current_text = pages[page_index];
                        page_alpha = 0;
                        page_state = "fade_in";
                        _tap();
                    } else {
                        // last page -> fade out to target room
                        global_fade = "out";
                        _tap();
                    }
                }
                break;
            }
        }
        break;
    }
    case "out": {
        fade_alpha += fade_speed;
        if (fade_alpha >= 1) {
            fade_alpha = 1;
            room_goto(target_room);
        }
        break;
    }
}