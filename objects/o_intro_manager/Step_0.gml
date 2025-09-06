/// o_intro_manager : Step

if (input_cooldown > 0) input_cooldown--;

var pressed_next = (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left));
var pressed_quit = keyboard_check_pressed(vk_escape);

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
                    _tap();
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
