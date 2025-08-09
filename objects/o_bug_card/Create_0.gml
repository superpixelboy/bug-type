// o_bug_card - Updated Create Event (Template-based)

// Card state and animation
card_state = "waiting";
animation_timer = 0;
delay_timer = 0;
total_flip_time = 30;
display_time = 120;
flip_progress = 0;

// Card positioning and transform
target_x = room_width/2;
target_y = room_height/2;
start_y = room_height + 100;
card_rotation = 0;
card_scale_x = 1;
card_scale_y = 1;

// Card data (set by the bug that creates this card)
bug_name = "Unknown Bug";
bug_sprite = s_bug_test;
flavor_text = "Mystery bug";
essence_value = 1;

// ALWAYS use the template card sprite now
card_sprite = s_card_template;

// Visual effects
drop_shadow_offset = 4;
card_depth = -1000;

// Bug bounce animation
bug_bounce_timer = 0;
bug_bounce_scale = 1.0;

depth = card_depth;

// Card dimensions (using template)
card_width = sprite_get_width(s_card_template);
card_height = sprite_get_height(s_card_template);

// High-res rendering setup
use_high_res = true;
high_res_scale = 2; // Render at 2x resolution
original_app_surf_w = 480;
original_app_surf_h = 270;
high_res_w = original_app_surf_w * high_res_scale;
high_res_h = original_app_surf_h * high_res_scale;

// High-res viewport setup
high_res_viewport = 1;
use_high_res = true;