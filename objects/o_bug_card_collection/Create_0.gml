// o_bug_card_collection - Updated Create Event
// SAFETY: Updating coin system to use real catch counts

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

// Card dimensions
card_width = sprite_get_width(s_card_template);
card_height = sprite_get_height(s_card_template);

// Gem rarity system
bug_rarity_tier = 5;  // Default to very common
gem_sprite = s_gem_very_common;
gem_float_timer = 0;
gem_glow_timer = 0;

// UPDATED: Coin system - Use real catch counts instead of random numbers
// Default values (will be updated when bug data is set)
coin_value = 1;
coin_sprite = s_coin_copper;

// Function to update coin display based on bug type
function update_coin_display() {
    if (variable_instance_exists(id, "type_id") && type_id != "unknown") {
        coin_value = get_bug_catch_count(type_id);
        coin_sprite = get_coin_sprite_from_count(coin_value);
        
        // BACKUP: If somehow count is 0 but we're showing the card, default to 1
        if (coin_value == 0) {
            coin_value = 1;
            coin_sprite = s_coin_copper;
        }
        
        show_debug_message("Collection card coin updated for " + type_id + ": count=" + string(coin_value));
    } else {
        // Fallback to default values
        coin_value = 1;
        coin_sprite = s_coin_copper;
    }
}

// High-res rendering (simplified)
gui_scale = 2;
if (!variable_instance_exists(id, "ui_owner")) ui_owner = noone;

show_debug_message("Collection card created for: " + bug_name);