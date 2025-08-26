// o_bug_card_collection - Create Event
// FIXED: Opacity starts at 0 to prevent flash, fades in with slide
// Card state and animation
card_state = "sliding_in";  // Changed from "flipping_in"
animation_timer = 0;
total_slide_time = 25;  // Smooth 25-frame entrance (was flip-based)

// Card positioning and transform
target_x = room_width/2;
target_y = room_height/2;
start_y = room_height + 100;
x = target_x;
y = start_y;
card_rotation = 0;
card_scale_x = 1;
card_scale_y = 1;

// REMOVED: Slide animation offset - we'll use easing instead
slide_offset_y = 0; 

// Card data (will be set by the script that creates this)
bug_name = "Unknown Bug";
bug_sprite = s_bug_test;
flavor_text = "Mystery bug";
essence_value = 1;
type_id = "unknown";

// Always use the template card sprite
card_sprite = s_card_template;

// Visual effects
drop_shadow_offset = 4;
depth = -15000; // Even more negative than collection UI to ensure it's on top

// FIXED: Content starts invisible and fades in during slide animation
content_ready = true;  // Always ready now
bug_pop_scale = 1.0;   // Start at full scale
gem_pop_scale = 1.0;   // Start at full scale
content_fade_alpha = 0.0;  // FIXED: Start invisible to prevent flash

// Remove pop timers - not needed anymore
// bug_pop_timer = 0; // REMOVED
// gem_pop_timer = 0; // REMOVED

// Card dimensions
card_width = sprite_get_width(s_card_template);
card_height = sprite_get_height(s_card_template);

// Gem rarity system
bug_rarity_tier = 5;  // Default to very common
gem_sprite = s_gem_very_common;
gem_float_timer = 0;
gem_glow_timer = 0;

// Coin value & sprite
coin_value = irandom_range(1, 15);
if (coin_value <= 4) {
    coin_sprite = s_coin_copper;
} else if (coin_value <= 9) {
    coin_sprite = s_coin_silver;
} else {
    coin_sprite = s_coin_gold;
}

// High-res rendering (simplified)
gui_scale = 2;
if (!variable_instance_exists(id, "ui_owner")) ui_owner = noone;

show_debug_message("Collection card created for: " + bug_name);