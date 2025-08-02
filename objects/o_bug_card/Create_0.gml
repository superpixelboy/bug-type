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
card_scale_x = 0.8;
card_scale_y = 0.8;

// Card data (set by the bug that creates this card)
bug_name = "Unknown Bug";
bug_sprite = s_bug_test;
flavor_text = "Mystery bug";
essence_value = 1;

// NEW: Get the actual card sprite based on the bug sprite
card_sprite = scr_get_bug_card_sprite(bug_sprite);

// Visual effects
drop_shadow_offset = 4;
card_depth = -1000;

// Bug bounce animation - NOT NEEDED anymore since card sprite has everything
bug_bounce_timer = 0;
bug_bounce_scale = 1.0;

depth = card_depth;

// Card dimensions (get from the actual card sprite)
card_width = sprite_get_width(card_sprite);
card_height = sprite_get_height(card_sprite);