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
    
    // Spawn bug code...
    var bug_type = random(1);
	  // Spawn bug
// REPLACE YOUR EXISTING BUG SPAWN CODE WITH:
  scr_spawn_bug_by_rock_type(x, y, rock_type);
    }
}