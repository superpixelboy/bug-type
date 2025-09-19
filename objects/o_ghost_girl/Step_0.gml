// o_ghost_girl Step Event
// SAFETY: Uses existing player facing system - no modifications to working code

// First run parent step (handles dialogue progression, cooldowns, etc.)
event_inherited();

// FLOATING ANIMATION (like other ghosts)
float_timer += float_speed;
y = base_y + sin(float_timer) * float_amplitude;

// GHOST BEHAVIOR: Only check when not in dialogue
if (!dialogue_active && instance_exists(o_player)) {
    var player_distance = distance_to_object(o_player);
    
    // Only do ghost logic when player is within interaction range
    if (player_distance <= 32) {
        
        // CALCULATE if player is looking AT the ghost girl
        var dx = x - o_player.x;  // Ghost position relative to player
        var dy = y - o_player.y;
        var player_looking_at_ghost = false;
        
        // Check if player's facing direction points toward the ghost
        // Using same logic pattern as your rock interaction system
        switch(o_player.facing_direction) {
            case "up":
                player_looking_at_ghost = (dy < -4 && abs(dx) < 20);
                break;
            case "down":
                player_looking_at_ghost = (dy > 4 && abs(dx) < 20);
                break;
            case "left":
                player_looking_at_ghost = (dx < -4 && abs(dy) < 20);
                break;
            case "right":
                player_looking_at_ghost = (dx > 4 && abs(dy) < 20);
                break;
        }
        
        // GHOST STATE LOGIC
        var previous_state = ghost_state;
        
        if (player_looking_at_ghost) {
            // Player is looking at ghost - she hides!
            ghost_state = "hiding";
            sprite_index = hiding_sprite;
            
            // Override dialogue to hiding dialogue
            dialogue_messages = hiding_dialogue;
        } else {
            // Player is looking away - she's normal
            ghost_state = "normal"; 
            sprite_index = normal_sprite;
            
            // Use normal dialogue
            dialogue_messages = normal_dialogue;
        }
        
        // DEBUG: Show state changes (remove this later)
        if (previous_state != ghost_state) {
            show_debug_message("👻 Ghost girl: " + previous_state + " → " + ghost_state + 
                " (Player facing: " + o_player.facing_direction + ")");
        }
    } else {
        // Player is far away - always be normal
        ghost_state = "normal";
        sprite_index = normal_sprite;
        dialogue_messages = normal_dialogue;
    }
}