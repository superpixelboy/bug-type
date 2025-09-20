// o_item_card_collection Step Event

// Close with ESC, Space, click, or gamepad A/B button
var close_input = keyboard_check_pressed(vk_escape) || 
                  keyboard_check_pressed(vk_space) ||
                  mouse_check_button_pressed(mb_left);

// Add gamepad support
if (gamepad_is_connected(0)) {
    close_input = close_input || 
                  gamepad_button_check_pressed(0, gp_face1) || // A button
                  gamepad_button_check_pressed(0, gp_face2);    // B button
}

if (close_input) {
    instance_destroy();
    exit;
}

// Fade in animation
if (fade_timer < fade_in_duration) {
    fade_timer++;
    content_fade_alpha = fade_timer / fade_in_duration;
    
    // Pop-in effects
    card_pop_scale = min(1, fade_timer / (fade_in_duration * 0.6));
    item_pop_scale = min(1, (fade_timer - 5) / (fade_in_duration * 0.5));
    
    if (fade_timer >= fade_in_duration * 0.3) {
        content_ready = true;
    }
} else {
    content_fade_alpha = 1;
    card_pop_scale = 1;
    item_pop_scale = 1;
    content_ready = true;
}