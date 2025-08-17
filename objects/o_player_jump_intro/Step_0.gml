// o_player_jump_intro - Step Event (WITH DOUBLE SPIN)

jump_timer++;

switch(state) {
    case "rising":
        // Upward motion with easing
        var progress = jump_timer / rise_duration;
        progress = min(progress, 1);
        
        var eased_progress = 1 - power(1 - progress, 2);
        y = start_y - (target_height * eased_progress);
        
        // Animate through dirty jump frames
        image_index = floor(progress * 3);
        image_index = min(image_index, 2);
        
        // COMET TRAIL - spawn dust particles every few frames
        if (jump_timer % 3 == 0) {  // Every 3 frames for smooth trail
            scr_spawn_comet_trail(x, y, "rising");
        }
        
        if (jump_timer >= rise_duration) {
            state = "falling";
            jump_timer = 0;
        }
        break;
        
    case "falling":
        // Downward motion
        var progress = jump_timer / fall_duration;
        progress = min(progress, 1);
        
        var eased_progress = progress * progress;
        var peak_y = start_y - target_height;
        y = lerp(peak_y, landing_y, eased_progress);
        
        // Continue dirty jump animation
        var frame_progress = progress * 4;
        image_index = 3 + floor(frame_progress);
        image_index = min(image_index, 6);
        
        // COMET TRAIL - continue during fall
        if (jump_timer % 3 == 0) {  // Every 3 frames
            scr_spawn_comet_trail(x, y, "falling");
        }
        
        if (jump_timer >= fall_duration) {
            state = "dirty_pause";
            jump_timer = 0;
            // Switch to dirty idle sprite
            sprite_index = s_player_idle_dirty;
            image_index = 0;  // Face down while dirty
        }
        break;
        
    case "dirty_pause":
        // Stand still while dirty for a moment
        sprite_index = s_player_idle_dirty;
        image_speed = 0.5;  // Nice breathing animation
        
        if (jump_timer >= pause_duration) {
            state = "cleaning_spin";
            jump_timer = 0;
            spin_timer = 0;
            spin_direction_index = 0;
            particles_spawned = false;
            image_speed = 0;  // Stop breathing animation for spin
            
            // NEW: Initialize spin counting variables
            current_spin = 0;      // Track which spin we're on (0 or 1)
            total_spins = 2;       // We want 2 complete spins
            frames_per_direction = spin_frame_duration;  // How long to face each direction
        }
        break;
        
    case "cleaning_spin":
        spin_timer++;
        
        // Change direction every spin_frame_duration frames
        if (spin_timer % frames_per_direction == 0) {
            spin_direction_index = (spin_direction_index + 1) % 4;
            
            // Check if we completed a full spin (4 directions = 1 spin)
            if (spin_direction_index == 0) {
                current_spin++;
                show_debug_message("Completed spin " + string(current_spin) + " of " + string(total_spins));
            }
            
            // Set sprite based on spin direction using CLEAN sprites
            switch(spin_direction_index) {
                case 0: sprite_index = s_player_idle_d; break;  // Down
                case 1: sprite_index = s_player_idle_l; break;  // Left  
                case 2: sprite_index = s_player_idle_u; break;  // Up
                case 3: sprite_index = s_player_idle_r; break;  // Right
            }
            image_index = 0;
            
            // Spawn dirt particles during both spins
            // More particles during first spin, fewer during second
            if (current_spin < total_spins) {
                if (current_spin == 0) {
                    // First spin - lots of dirt particles
                    scr_spawn_cleaning_particles(x, y);
                } else if (current_spin == 1) {
                    // Second spin - fewer particles (getting cleaner)
                    if (spin_direction_index % 2 == 0) {  // Only spawn every other direction
                        scr_spawn_cleaning_particles(x, y);
                    }
                }
            }
        }
        
        // Check if we've completed both spins
        if (current_spin >= total_spins) {
            state = "clean_finish";
            jump_timer = 0;
            // End facing down, now clean
            sprite_index = s_player_idle_d;
            image_index = 0;
            show_debug_message("Cleaning complete! Character is now clean.");
        }
        break;
        
    case "clean_finish":
        // Brief pause to admire cleanliness
        sprite_index = s_player_idle_d;
        image_index = 0;
        
        if (jump_timer >= 20) {  // Short pause
            // Transfer control to main player SMOOTHLY
            if (instance_exists(o_player)) {
                o_player.x = x;
                o_player.y = y;
                o_player.visible = true;
                o_player.movement_mode = "overworld";
                o_player.sprite_index = s_player_idle_d;
                
                // Make camera follow the jump intro for smooth transition
                var cam = view_camera[0];
                camera_set_view_target(cam, o_player);
            }
            
            instance_destroy();
        }
        break;
}

// === ALSO UPDATE YOUR CREATE EVENT ===
// Add these new variables to o_player_jump_intro CREATE event:

/*
// Add these to your existing CREATE event variables:
current_spin = 0;           // Which spin we're currently on
total_spins = 2;            // Total number of spins to complete
frames_per_direction = 8;   // Frames to face each direction (adjust for speed)
*/