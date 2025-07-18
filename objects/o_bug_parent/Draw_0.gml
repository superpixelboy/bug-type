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
if (state == "caught") {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var text_x = room_width/2;
    var text_y = room_height/2 - 60;
    
    // Convert object name to readable format
    var bug_name = object_get_name(object_index);
    bug_name = string_replace_all(bug_name, "o_", "");           // Remove "o_" prefix
    bug_name = string_replace_all(bug_name, "_", " ");           // Replace underscores with spaces
    
    // Capitalize first letter of each word
    var words = string_split(bug_name, " ");
    bug_name = "";
    for (var i = 0; i < array_length(words); i++) {
        var word = words[i];
        if (string_length(word) > 0) {
            word = string_upper(string_char_at(word, 1)) + string_copy(word, 2, string_length(word) - 1);
            bug_name += word;
            if (i < array_length(words) - 1) bug_name += " ";
        }
    }
    
    var caught_text = bug_name + " Caught!";
    var essence_text = "+" + string(essence_value) + " Essence";
    var continue_text = "Click to continue";
    
    // Black outline for main text
    draw_set_color(c_black);
    for (var dx = -1; dx <= 1; dx++) {
        for (var dy = -1; dy <= 1; dy++) {
            if (dx != 0 || dy != 0) {
                draw_text(text_x + dx, text_y + dy, caught_text);
                draw_text(text_x + dx, text_y + 20 + dy, essence_text);
                draw_text(text_x + dx, text_y + 40 + dy, continue_text);
            }
        }
    }
    
    // White text
    draw_set_color(c_olive);
    draw_text(text_x, text_y, caught_text);
    
    // Green essence text
    draw_set_color(c_white);
    draw_text(text_x, text_y + 20, essence_text);
    
    // Gray continue text
    draw_set_color(c_gray);
    draw_text(text_x, text_y + 40, continue_text);
    
    // Reset draw settings
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

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
if (state == "idle" || state == "recovering") {
    var bar_x = room_width/2 - catch_bar_width/2;
    var bar_y = 50;
    var bar_height = 20;
    
    // Background
    draw_set_color(c_black);
    draw_rectangle(bar_x, bar_y, bar_x + catch_bar_width, bar_y + bar_height, false);
    
    // Progress fill
    draw_set_color(c_green);
    draw_rectangle(bar_x + 2, bar_y + 2, bar_x + (catch_bar_width - 4) * catch_progress, bar_y + bar_height - 2, false);
    
    // Label
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(room_width/2, bar_y - 15, "Catching...");
    draw_set_halign(fa_left);
}
