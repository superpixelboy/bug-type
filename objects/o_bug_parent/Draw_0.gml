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
if (state == "caught") {
    // Use a dedicated caught timer that starts from 0
    if (!variable_instance_exists(id, "caught_timer")) {
        caught_timer = 0;
    }
    caught_timer++;
    
    var time_since_caught = caught_timer;
    
    // Semi-transparent dark overlay for better text contrast
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    
    // Decorative frame background
    var frame_x = room_width/2 - 220;
    var frame_y = room_height/2 - 100;
    var frame_width = 440;
    var frame_height = 200;
    
    // Outer golden frame
    draw_set_color(make_color_rgb(218, 165, 32)); // Gold
    draw_rectangle(frame_x - 4, frame_y - 4, frame_x + frame_width + 4, frame_y + frame_height + 4, false);
    
    // Inner parchment background
    draw_set_color(make_color_rgb(245, 235, 220)); // Warm parchment
    draw_rectangle(frame_x, frame_y, frame_x + frame_width, frame_y + frame_height, false);
    
    // Dark inner border
    draw_set_color(make_color_rgb(139, 115, 85)); // Dark brown
    draw_rectangle(frame_x, frame_y, frame_x + frame_width, frame_y + frame_height, true);
    draw_rectangle(frame_x + 1, frame_y + 1, frame_x + frame_width - 1, frame_y + frame_height - 1, true);
    
    // Text positioning
    var text_center_x = frame_x + frame_width/2;
    var title_y = frame_y + 25;
    var essence_y = frame_y + 55;
    var flavor_y = frame_y + 90;
    var continue_y = frame_y + frame_height - 25;
    
    draw_set_halign(fa_center);
    
    // PHASE 1: Bug Name (appears immediately)
    if (time_since_caught >= 0) {
        // Quick snappy bounce like bug clicking - starts big, bounces to normal
        var bounce_progress = min(time_since_caught / 20, 1); // 20 frames to settle
        var bounce = 0;
        
        if (bounce_progress < 0.5) {
            // First half: quick bounce from big to small
            bounce = lerp(0.5, -0.2, bounce_progress * 2); // Bigger initial bounce
        } else {
            // Second half: settle back to normal with smaller bounces
            var settle_progress = (bounce_progress - 0.5) * 2;
            bounce = lerp(-0.2, 0, settle_progress) * (1 - settle_progress);
        }
        
        var name_scale = 1.3 + bounce; // Base size now 1.3x instead of 1x
        
        // Use your custom font for the title - readable size
        draw_set_font(fnt_silkscreen);
        
        // Subtle drop shadow for depth - closer and more transparent
        draw_set_color(make_color_rgb(60, 40, 20));
        draw_set_alpha(0.4); // Much more subtle
        draw_text_transformed(text_center_x + 1, title_y + 1, bug_name + " Caught!", name_scale, name_scale, 0);
        draw_set_alpha(1); // Reset alpha
        
        // Main title in rich forest green - snappy and satisfying
        draw_set_color(make_color_rgb(34, 139, 34));
        draw_text_transformed(text_center_x, title_y, bug_name + " Caught!", name_scale, name_scale, 0);
    }
    
    // PHASE 2: Essence Gain (appears after 10 frames)
    if (time_since_caught >= 10) {
        var essence_text = "+" + string(essence_value) + " Essence";
        
        // Use the same font for consistency
        draw_set_font(fnt_silkscreen);
        
        // Medium size for essence - readable but secondary
        var essence_scale = 1.0;
        
        // Color-coded by value for instant recognition
        var essence_color = c_white;
        if (essence_value >= 100) essence_color = make_color_rgb(255, 215, 0); // Gold for high value
        else if (essence_value >= 50) essence_color = make_color_rgb(138, 43, 226); // Purple for medium
        else if (essence_value >= 20) essence_color = make_color_rgb(30, 144, 255); // Blue for decent
        else essence_color = make_color_rgb(60, 179, 113); // Green for common
        
        // Subtle glow effect for high-value catches
        if (essence_value >= 50) {
            var glow_alpha = 0.3 + 0.2 * sin(current_time * 0.005);
            draw_set_alpha(glow_alpha);
            draw_set_color(essence_color);
            draw_text_transformed(text_center_x, essence_y, essence_text, essence_scale, essence_scale, 0);
            draw_set_alpha(1);
        }
        
        // Subtle drop shadow for essence
        draw_set_color(make_color_rgb(60, 40, 20));
        draw_set_alpha(0.3);
        draw_text_transformed(text_center_x + 1, essence_y + 1, essence_text, essence_scale, essence_scale, 0);
        draw_set_alpha(1);
        
        // Main essence text
        draw_set_color(essence_color);
        draw_text_transformed(text_center_x, essence_y, essence_text, essence_scale, essence_scale, 0);
    }
    
    // PHASE 3: Flavor Text (appears after 20 frames)
    if (time_since_caught >= 20) {
        // Use the font for flavor text too (you could use a different one here if you prefer)
        draw_set_font(fnt_silkscreen);
        
        // Smart text wrapping for flavor text
        var max_width = frame_width - 40;
        var wrapped_flavor = "";
        var words = string_split(flavor_text, " ");
        var current_line = "";
        
        for (var i = 0; i < array_length(words); i++) {
            var test_line = current_line + (current_line == "" ? "" : " ") + words[i];
            if (string_width(test_line) > max_width && current_line != "") {
                wrapped_flavor += current_line + "\n";
                current_line = words[i];
            } else {
                current_line = test_line;
            }
        }
        wrapped_flavor += current_line;
        
        // Smaller, elegant flavor text - very readable
        var flavor_scale = 0.8;
        
        // Subtle drop shadow for flavor text
        draw_set_color(make_color_rgb(40, 30, 20));
        draw_set_alpha(0.2); // Very subtle for flavor text
        draw_text_transformed(text_center_x + 1, flavor_y + 1, "\"" + wrapped_flavor + "\"", flavor_scale, flavor_scale, 0);
        draw_set_alpha(1);
        
        // Elegant italic-style flavor text in warm brown
        draw_set_color(make_color_rgb(101, 67, 33));
        draw_text_transformed(text_center_x, flavor_y, "\"" + wrapped_flavor + "\"", flavor_scale, flavor_scale, 0);
    }
    
    // PHASE 4: Continue Prompt (appears after 30 frames)
    if (time_since_caught >= 30) {
        var pulse_alpha = 0.7 + 0.3 * sin(current_time * 0.003);
        
        // Use the font for continue prompt
        draw_set_font(fnt_silkscreen);
        
        // Small, unobtrusive continue text - very readable
        var continue_scale = 0.7;
        
        draw_set_alpha(pulse_alpha);
        draw_set_color(make_color_rgb(105, 105, 105)); // Subtle gray
        draw_text_transformed(text_center_x, continue_y, "Click to continue", continue_scale, continue_scale, 0);
        draw_set_alpha(1);
    }
    
    // Decorative corner flourishes (appear after 10 frames)
    if (time_since_caught >= 10) {
        draw_set_color(make_color_rgb(218, 165, 32));
        // Simple corner decorations
        var corner_size = 8;
        // Top-left corner
        draw_rectangle(frame_x - 4, frame_y - 4, frame_x - 4 + corner_size, frame_y - 4 + corner_size, false);
        // Top-right corner  
        draw_rectangle(frame_x + frame_width + 4 - corner_size, frame_y - 4, frame_x + frame_width + 4, frame_y - 4 + corner_size, false);
        // Bottom corners
        draw_rectangle(frame_x - 4, frame_y + frame_height + 4 - corner_size, frame_x - 4 + corner_size, frame_y + frame_height + 4, false);
        draw_rectangle(frame_x + frame_width + 4 - corner_size, frame_y + frame_height + 4 - corner_size, frame_x + frame_width + 4, frame_y + frame_height + 4, false);
    }
    
    // Reset draw settings
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_set_font(-1); // Reset to default font
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