// Movement variables
move_speed = 2;
input_up = 0;
input_down = 0;
input_left = 0;
input_right = 0;

// Animation system
image_speed = 0;
facing_direction = "down";
is_moving = false;
anim_timer = 0;
anim_frame = 0;

// Set initial sprite
sprite_index = s_player_idle_d;

// Animation frame mapping
anim_down_start = 0;
anim_left_start = 3;
anim_right_start = 6;
anim_up_start = 9;

// Camera setup - FIX THIS PART
view_enabled = true;
view_visible[0] = true;
view_camera[0] = camera_create_view(0, 0, 480, 270, 0, o_player, -1, -1, 480/2, 270/2);

//Movement types
movement_mode = "overworld"; 

// Configure player shadow (after all other setup)
shadow_enabled = true;
shadow_offset_x = 4;      // Slight offset to the right
shadow_offset_y = 10;      // Just below the player's feet
shadow_scale_x = .9;     // Slightly smaller than player
shadow_scale_y = 0.3;     // Very flat shadow
shadow_alpha = 0.2;       // Semi-transparent

// Exclamation mark system
show_exclamation = false;
exclamation_alpha = 0;
exclamation_bounce_y = 0;
exclamation_animation_timer = 0;
exclamation_appeared = false;  // Prevents re-triggering bounce

// Track what triggered the exclamation mark
exclamation_source = "none";  // Can be "rock", "npc", "door", or "none"