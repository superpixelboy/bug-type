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