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
if (state == "idle" || state == "recovering") {
    var bar_x = room_width/2 - catch_bar_width/2;
    var bar_y = room_height - 40;  // Bottom of screen with some padding
    var bar_height = 20;
    
    // Background
    draw_set_color(c_black);
    draw_rectangle(bar_x, bar_y, bar_x + catch_bar_width, bar_y + bar_height, false);
    
    // Progress fill
    draw_set_color(c_green);
    draw_rectangle(bar_x + 2, bar_y + 2, bar_x + (catch_bar_width - 4) * catch_progress, bar_y + bar_height - 2, false);
    
    // "Catching..." text centered on the bar itself
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
	draw_set_font(fnt_DOS);
    draw_text(room_width/2, bar_y + bar_height/2, "Catching...");
    
    // Reset draw settings
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}