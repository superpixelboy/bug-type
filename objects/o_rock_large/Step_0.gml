// o_rock_large Step Event - Enhanced with Unified Input Support
// SAFETY: Adds keyboard/controller support while preserving existing mouse functionality

// === UNIFIED INPUT SUPPORT ===
// NEW: Add spacebar and controller support for rock flipping
if (state == "waiting_for_click") {
    // Check for unified input (Space + Controller A)
    if (input_get_interact_pressed()) {
        state = "shaking";
    }
}

// === EXISTING ROCK LOGIC (UNCHANGED) ===
// Only shake after being clicked
if (state == "shaking") {
    if (shake_timer == 1) {  // Play sound only once at start of shake
        shake_sound_id = audio_play_sound(sn_rockshake1, 1, false);
    }
    
    if (shake_timer < 60) {
        shake_timer++;
        x = xstart + random_range(-shake_intensity, shake_intensity);
        y = ystart + random_range(-shake_intensity, shake_intensity);
    } else if (!has_flipped) {
        // Stop the shake sound before playing flip sound
        ds_list_add(global.flipped_rocks, global.current_rock_id);
        if (audio_is_playing(shake_sound_id)) {
            audio_stop_sound(shake_sound_id);
        }
        
        // Flip to second frame
        has_flipped = true;
        x = xstart;
        y = ystart;
        image_index = 1;
        state = "flipped";
        
        // Play flip sound
        audio_play_sound(sn_rockflip1, 1, false);
        
        // Mark the original rock as used
        global.last_rock_used = true;  // We'll use this flag
        
        // REPLACE YOUR EXISTING BUG SPAWN CODE WITH:
        scr_spawn_bug_by_rock_type(x, y, rock_type);
    }
}