
// Card state and animation
card_state = "waiting";  // waiting -> flipping_in -> showing -> flipping_out -> destroyed
animation_timer = 0;
delay_timer = 0;  // Frames to wait before starting animation
total_flip_time = 30;   // Frames for flip animation
display_time = 120;     // How long card stays visible
flip_progress = 0;

// Card positioning and transform
target_x = room_width/2;
target_y = room_height/2;
start_y = room_height + 100;  // Start below screen
card_rotation = 0;
card_scale_x = 0.8;  // Make card smaller
card_scale_y = 0.8;  // Make card smaller

// Card data (set by the bug that creates this card)
bug_name = "Unknown Bug";
bug_sprite = s_bug_test;
flavor_text = "Mystery bug";
essence_value = 1;

// Visual effects
drop_shadow_offset = 4;
card_depth = -1000;  // Draw on top of everything

// Bug bounce animation
bug_bounce_timer = 0;
bug_bounce_scale = 1.0;

depth = card_depth;

depth = card_depth;

// Card dimensions (get from sprite)
card_width = sprite_get_width(s_bug_frame);
card_height = sprite_get_height(s_bug_frame);