// o_bug_card_collection - Create Event
// A simplified version of o_bug_card specifically for collection viewing

// Card state and animation
card_state = "flipping_in";
animation_timer = 0;
total_flip_time = 30;
flip_progress = 0;

// Card positioning and transform
target_x = room_width/2;
target_y = room_height/2;
start_y = room_height + 100;
x = target_x;
y = start_y;
card_rotation = 0;
card_scale_x = 1;
card_scale_y = 1;

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

// Content animation
bug_pop_timer = 0;
bug_pop_scale = 0;
gem_pop_timer = 0;
gem_pop_scale = 0;
content_ready = false;
content_fade_alpha = 1.0;

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

show_debug_message("Collection card created for: " + bug_name);

// Create the dark overlay
overlay_instance = instance_create_layer(0, 0, "Instances", o_black_box);
if (instance_exists(overlay_instance)) {
    with(overlay_instance) {
        // Set overlay properties
        image_alpha = 0.15; // 15% opacity
        image_xscale = room_width;
        image_yscale = room_height;
        depth = -14000; // Behind the card but in front of everything else
    }
    show_debug_message("Created overlay for collection card");
}