// o_item_card_collection Create Event
// Based on o_bug_card_collection but for items

// Item data
item_id = "";
item_name = "";
item_description = "";
item_sprite = -1;

// Animation state
content_ready = false;
content_fade_alpha = 0;

// Pop-in animations
card_pop_scale = 0;
item_pop_scale = 0;

// Animation timing
fade_in_duration = 20;
fade_timer = 0;

// Depth - same as bug cards
depth = -10001;

// Sound
audio_play_sound(sn_bugtap1, 1, false);