// o_wake_up_prompt - Step Event

if (waiting_for_input) {
    // Animate the text for visual appeal
    text_pulse_timer++;
    
    // Gentle pulsing alpha
    text_alpha = 0.7 + 0.3 * sin(text_pulse_timer * 0.08);
    
    // Subtle bounce
    text_bounce_y = sin(text_pulse_timer * 0.1) * 2;
    
    // Check for space bar press
    if (keyboard_check_pressed(vk_space)) {
        waiting_for_input = false;
        
        // Re-enable the hole's sleep functionality
        var hole_obj = instance_find(o_hole, 0);
        if (instance_exists(hole_obj)) {
            hole_obj.intro_active = false;  // Re-enable sleep functionality
        }
        
        // Create the jump intro object
        var jump_obj = instance_create_layer(x, y, "Instances", o_player_jump_intro);
        
        // Destroy this prompt
        instance_destroy();
    }
}