
// Check if player is overlapping and moving
var player_overlapping = place_meeting(x, y, o_player);

// Simple movement detection - check if player position changed
if (!variable_instance_exists(id, "last_player_x")) {
    last_player_x = o_player.x;
    last_player_y = o_player.y;
}

var player_is_moving = (last_player_x != o_player.x || last_player_y != o_player.y);
last_player_x = o_player.x;
last_player_y = o_player.y;

// Trigger shake if player walks through and not on cooldown
if (player_overlapping && player_is_moving && shake_cooldown <= 0 && shake_timer <= 0) {
    shake_timer = shake_duration;
    shake_intensity = shake_max_intensity;
    shake_cooldown = 30; // Prevent immediate re-triggering
    
    // Spawn leaf particles
    part_particles_create(particle_system, x + random_range(-sprite_width/2, sprite_width/2), 
                         y + random_range(-sprite_height/2, sprite_height/2), 
                         particle_type, irandom_range(3, 6));

	//play audio
	// audio_play_sound(sn_bugtap1, 1, false);
}

// Update shake
if (shake_timer > 0) {
    shake_timer--;
    
    // Calculate shake offset with decay
    var shake_progress = shake_timer / shake_duration;
    var current_shake = shake_intensity * shake_progress;
    
    // Apply random shake offset
    x = original_x + random_range(-current_shake, current_shake);
    y = original_y + random_range(-current_shake, current_shake);
    
    // Return to original position when shake ends
    if (shake_timer <= 0) {
        x = original_x;
        y = original_y;
    }
}

// Update cooldown
if (shake_cooldown > 0) {
    shake_cooldown--;
}