// Calculate final scale with bounce AND capture
var final_scale_x = (base_scale_x + scale_bounce_x) * capture_scale;
var final_scale_y = (base_scale_y + scale_bounce_y) * capture_scale;
// Calculate position with BOTH offsets
var draw_x_pos = x + bounce_offset_x;
var draw_y_pos = y + capture_y_offset + bounce_offset_y;
// Draw bug with all effects - USE final_scale_x/y NOT image_xscale/yscale!
if (is_flashing) {
    draw_sprite_ext(sprite_index, image_index, draw_x_pos, draw_y_pos, 
        final_scale_x, final_scale_y, 0, c_white, image_alpha);
} else {
    draw_sprite_ext(sprite_index, image_index, draw_x_pos, draw_y_pos, 
        final_scale_x, final_scale_y, 0, c_white, image_alpha);
}
// Ready to catch glow (use normal x, y position)


// Draw caught text
// Draw caught text with click instruction
// Draw caught text with better formatting
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent
// Enhanced Bug Catch Screen - Replace the existing caught text drawing in o_bug_parent


// DEBUG INFO - Add at the end of Draw Event
if (keyboard_check(vk_f1)) {  // Hold F1 to see debug info
     draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_color(c_yellow);
    
    var debug_x = x - 40;
    var debug_y = y - 60;
    
    // Draw black background for readability
    draw_set_color(c_black);
    draw_rectangle(debug_x - 5, debug_y - 5, debug_x + 120, debug_y + 50, false);
    
    // Draw debug text (removed combo_count and last_damage_dealt)
    draw_set_color(c_white);
    draw_text(debug_x, debug_y, "HP: " + string(current_hp) + "/" + string(bug_max_hp));
    draw_text(debug_x, debug_y + 12, "State: " + string(state));
    draw_text(debug_x, debug_y + 24, "Essence: " + string(essence_value));
    
    draw_set_color(c_white);
}

// Draw progress bar
// Draw progress bar (replace the existing progress bar code in o_bug_parent Draw event)
// ALTERNATIVE APPROACH: Use sprite as background, progress on top
// This might look better if your sprite has interior detail
// SAFETY: Keeping all existing logic - only changing visual appearance
// Draw progress bar with your perfectly-sized overlay sprite
// SAFETY: Keeping all existing logic - only changing visual appearance
// Draw progress bar with your perfectly-sized overlay sprite
if (state == "idle" || state == "recovering") {
    var bar_x = room_width/2 - catch_bar_width/2;
    var bar_y = room_height - 40;  // Bottom of screen with some padding
    var bar_height = 20;
    
    // Position the green bar to fit perfectly in the center of your overlay sprite
    var inner_padding_x = 12; // Padding from left/right edges
    var inner_x = bar_x + inner_padding_x;
    var inner_y = bar_y + 14; // Move bar down to center it in the frame
    var inner_width = catch_bar_width - (inner_padding_x * 2); // Smaller width
    var inner_height = 15; // FIXED HEIGHT - make the green bar much thinner!
    
    // Background fill inside the frame (optional dark background)
    draw_set_color(c_black);
    draw_rectangle(inner_x, inner_y, inner_x + inner_width, inner_y + inner_height, false);
    
    // Green progress fill (fits inside the sprite's clear area)
    draw_set_color(c_green);
    var progress_width = inner_width * catch_progress;
    draw_rectangle(inner_x, inner_y, inner_x + progress_width, inner_y + inner_height, false);
    
    // Draw your overlay sprite OVER the progress bar (no scaling needed!)
    var sprite_x = room_width/2 - sprite_get_width(s_catching_overlay)/2;
    var sprite_y = bar_y; // Align with the bar position
    draw_sprite(s_catching_overlay, 0, sprite_x, sprite_y);
    
    // "Catching..." text centered in the overlay frame (moved down)
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_DOS);
    draw_text(room_width/2, bar_y + bar_height/2 + 11, "Catching..."); // +4 moves text down
    
    // Reset draw settings - UNCHANGED
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}