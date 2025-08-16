// o_hole - Step Event (Updated)

// Don't allow sleep during intro sequence
if (variable_instance_exists(id, "intro_active") && intro_active) {
    exit;  // Skip all sleep logic during intro
}

// Original sleep logic
// Check if player is near bed and pressing up/W
if (distance_to_object(o_player) < 16) {
    if (keyboard_check_pressed(vk_space)) {
        // Save position globally before starting fade
        global.sleep_x = o_player.x;
        global.sleep_y = o_player.y;
        
        // Create fade controller
        if (!instance_exists(o_fade_controller)) {
            var fade = instance_create_layer(0, 0, "Instances", o_fade_controller);
            fade.action_to_perform = "sleep";
            fade.fade_state = "fade_out";
        }
    }
}