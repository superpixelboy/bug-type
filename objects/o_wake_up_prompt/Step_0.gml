// o_wake_up_prompt - Step Event - Enhanced with Controller and Mouse Support
// SAFETY: Only adds controller/mouse input to existing spacebar functionality

if (waiting_for_input) {
    // Animate the text for visual appeal (UNCHANGED)
    text_pulse_timer++;
    
    // Gentle pulsing alpha
    text_alpha = 0.7 + 0.3 * sin(text_pulse_timer * 0.08);
    
    // Subtle bounce
    text_bounce_y = sin(text_pulse_timer * 0.1) * 2;
    
    // ENHANCED: Check for multiple input types
    var wake_up_pressed = keyboard_check_pressed(vk_space); // Original spacebar
    
    // NEW: Add mouse click support
    if (mouse_check_button_pressed(mb_left)) {
        wake_up_pressed = true;
    }
    
    // NEW: Add controller support
    if (variable_global_exists("input_manager")) {
        // Make sure input manager is updated
        scr_update_input_manager();
        
        // Add controller face buttons for waking up
        if (global.input_manager.controller_connected) {
            var gp = global.input_manager.controller_slot;
            
            // A button to wake up (like Space)
            if (gamepad_button_check_pressed(gp, gp_face1)) {
                wake_up_pressed = true;
            }
        }
    } else {
        // Fallback: Direct controller check if input manager not available
        for (var i = 0; i < 12; i++) {
            if (gamepad_is_connected(i)) {
                // A button to wake up
                if (gamepad_button_check_pressed(i, gp_face1)) {
                    wake_up_pressed = true;
                }
                break; // Use first connected controller
            }
        }
    }
    
    // Handle wake up input (ORIGINAL LOGIC PRESERVED)
    if (wake_up_pressed) {
        waiting_for_input = false;
        
        // Re-enable the hole's sleep functionality
        var hole_obj = instance_find(o_hole, 0);
        if (instance_exists(hole_obj)) {
            hole_obj.intro_active = false;  // Re-enable sleep functionality
        }
        
        // Create the jump intro object
        var jump_obj = instance_create_layer(x, y, "Controllers", o_player_jump_intro);
        
        // Destroy this prompt
        instance_destroy();
    }
}