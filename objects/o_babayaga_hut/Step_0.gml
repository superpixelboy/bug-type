// obj_babayaga_hut - Step Event
var player_distance = point_distance(x, y, o_player.x, o_player.y);
var player_is_close = (player_distance <= interaction_distance);

switch(state) {
    case HutState.IDLE_STANDING:
        sprite_index = s_yaga_hut_idle; // Standing idle animation (loops)
        
        if (player_is_close) {
            state = HutState.SITTING_DOWN;
            sprite_index = s_yaga_hut_sit;
            image_index = 0;
        }
        break;
        
    case HutState.SITTING_DOWN:
        sprite_index = s_yaga_hut_sit;
        
        // Check if sitting animation is complete (reached the last frame)
        if (image_index >= sprite_get_number(s_yaga_hut_sit) - 1) {
            state = HutState.SITTING_STILL;
            // Stay on s_yaga_hut_sit sprite but stop animating
            image_speed = 0; 
            image_index = sprite_get_number(s_yaga_hut_sit) - 1; // Lock to last frame
            can_enter = true;
            
            // Optional: Play a satisfying "thud" sound when hut sits
            // audio_play_sound(snd_hut_sit, 1, false);
        }
        break;
        
    case HutState.SITTING_STILL:
        // Stay on last frame of sitting animation
        sprite_index = s_yaga_hut_sit;
        image_speed = 0;
        image_index = sprite_get_number(s_yaga_hut_sit) - 1;
        can_enter = true;
        
        if (!player_is_close) {
            state = HutState.STANDING_UP;
            sprite_index = s_yaga_hut_stand;
            image_index = 0;
            image_speed = 1; // Resume animation
            can_enter = false;
        }
        break;
        
    case HutState.STANDING_UP:
        sprite_index = s_yaga_hut_stand;
        can_enter = false;
        
        // Check if standing animation is complete
        if (image_index >= sprite_get_number(s_yaga_hut_stand) - 1) {
            state = HutState.IDLE_STANDING;
            sprite_index = s_yaga_hut_idle;
            image_index = 0;
            image_speed = 1;
            
            // Optional: Play creaking wood sound when standing
            // audio_play_sound(snd_hut_stand, 1, false);
        }
        break;
}

// Handle player interaction when close and sitting
if (can_enter && player_is_close) {
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"))) {
        // Enter the hut - transition to interior room
        // room_goto(rm_hut_interior);
        show_debug_message("Entering hut!"); // For testing
    }
}