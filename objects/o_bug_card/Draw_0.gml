// o_bug_card - Hybrid Draw Event (Card sprite + Dynamic overlays)
if (card_state == "hidden" || card_state == "waiting") exit;

// Calculate draw position and transforms
var draw_x = x;
var draw_y = y;

// Use card sprite dimensions if available, otherwise fall back to bug_frame
var frame_width = sprite_exists(card_sprite) ? sprite_get_width(card_sprite) : sprite_get_width(s_bug_frame);
var frame_height = sprite_exists(card_sprite) ? sprite_get_height(card_sprite) : sprite_get_height(s_bug_frame);

// Draw drop shadow first
draw_set_alpha(0.3);
if (sprite_exists(card_sprite) && card_sprite != s_bug_frame) {
    // Use the custom card sprite for shadow
    draw_sprite_ext(
        card_sprite, 0,
        draw_x + drop_shadow_offset,
        draw_y + drop_shadow_offset,
        card_scale_x, card_scale_y,
        card_rotation,
        c_black, 0.3
    );
} else {
    // Fall back to bug frame for shadow
    draw_sprite_ext(
        s_bug_frame, 0,
        draw_x + drop_shadow_offset,
        draw_y + drop_shadow_offset,
        card_scale_x, card_scale_y,
        card_rotation,
        c_black, 0.3
    );
}
draw_set_alpha(1);

// Draw card background
if (sprite_exists(card_sprite) && card_sprite != s_bug_frame) {
    // Use the beautiful custom card sprite as background
    draw_sprite_ext(
        card_sprite, 0,
        draw_x, draw_y,
        card_scale_x, card_scale_y,
        card_rotation,
        c_white, image_alpha
    );
} else {
    // Fall back to the old system with bug frame
    draw_sprite_ext(
        s_bug_frame, 0,
        draw_x, draw_y,
        card_scale_x, card_scale_y,
        card_rotation,
        c_white, image_alpha
    );
}

// Only draw dynamic content if we're showing the front of the card
if (card_state == "showing" || (card_state == "flipping_in" && flip_progress > 0.5)) {
    
    // DYNAMIC BUG SPRITE - bouncing over the card!
    var sprite_scale = 1.5 * bug_bounce_scale;  // Apply bounce scale to the base scale
    draw_sprite_ext(
        bug_sprite, 0,
        draw_x - 90, draw_y + 25,  // Positioned as you like it
        sprite_scale, sprite_scale,
        0, c_white, image_alpha
    );
    
    // DYNAMIC ESSENCE VALUE
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(c_gray);
    draw_set_font(fnt_DOS);
    draw_text(draw_x + (frame_width/2) - 165, draw_y + (frame_height/2) - 80, "Essence: +" + string(essence_value));
    
    // DYNAMIC CONTINUE PROMPT
    if (card_state == "showing") {
        var pulse_alpha = 0.7 + 0.3 * sin(animation_timer * 0.1);
        draw_set_alpha(pulse_alpha);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        
        // Position it well below the card for visibility
        draw_text(draw_x + (frame_width/2) - 230, draw_y + (frame_height/2) - 48, "Click to Continue...");
        draw_set_alpha(1);
    }
}

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(-1);

// ==========================================
// Helper Function - Text Wrapping
// ==========================================
function scr_wrap_text(text, max_chars) {
    var words = string_split(text, " ");
    var result = "";
    var current_line = "";
    
    for (var i = 0; i < array_length(words); i++) {
        var test_line = current_line + (current_line == "" ? "" : " ") + words[i];
        
        if (string_length(test_line) > max_chars && current_line != "") {
            result += current_line + "\n";
            current_line = words[i];
        } else {
            current_line = test_line;
        }
    }
    
    result += current_line;
    return result;
}