// o_bug_card - Create Event (Fixed)
show_debug_message("=== CARD CREATE ===");

// STRONGER protection against multiple cards
if (instance_number(o_bug_card) > 1) {
    show_debug_message("Destroying duplicate card! Total cards: " + string(instance_number(o_bug_card)));
    instance_destroy();
    exit;
}

// Also check global flag
if (global.showing_card) {
    show_debug_message("Card already showing, destroying duplicate!");
    instance_destroy();
    exit;
}

// Set the flag immediately
global.showing_card = true;

// CRITICAL: Set initial state FIRST before anything else!
card_state = "flipping_in";  // Start with flip animation immediately
animation_timer = 0;
delay_timer = 0;  // No delay
total_flip_time = 30;
display_time = 120;
flip_progress = 0;

// Card positioning and transform
target_x = room_width/2;
target_y = room_height/2;
start_y = room_height + 100;  // Start below screen
x = target_x;  // Set initial X position
y = start_y;   // Set initial Y position (off screen)
card_rotation = 0;
card_scale_x = 1;
card_scale_y = 1;

// Card data (will be set by the bug that creates this card)
bug_species = "unknown";  // Initialize this!
bug_name = "Unknown Bug";
bug_sprite = s_bug_test;
flavor_text = "Mystery bug";
essence_value = 1;

// ALWAYS use the template card sprite
card_sprite = s_card_template;

// Visual effects
drop_shadow_offset = 4;
card_depth = -1000;
depth = card_depth;

// Bug bounce animation
bug_pop_timer = 0;
bug_pop_scale = 0;
gem_pop_timer = 0;
gem_pop_scale = 0;
content_ready = false;  // Flag to know when to start pop animations

// Catch Counters
catch_count = 1;           // How many times this bug has been caught
bonus_essence = 0;         // Bonus essence from milestones
milestone_text = "";       // Text to show if milestone reached
show_coin = false;         // Whether to show the coin
coin_pop_scale = 0;        // Animation scale for coin
coin_pop_timer = 0;        // Animation timer for coin

content_fade_alpha = 1.0;  // Controls fade of bug/gem/text during exit

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

// Gem rarity system - Initialize with default values
bug_rarity_tier = 5;  // Default to very common
gem_sprite = s_gem_very_common;  // Default gem
gem_float_timer = 0;
gem_glow_timer = 0;

show_debug_message("Card created with state: " + card_state);
show_debug_message("Card position: " + string(x) + ", " + string(y));