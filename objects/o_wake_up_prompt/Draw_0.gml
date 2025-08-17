// o_wake_up_prompt - Draw Event

if (waiting_for_input) {
    // Calculate text position
    var text_x = x;
    var text_y = y + text_y_offset + text_bounce_y;
    
    // Set up text drawing
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Draw text with nice outline for visibility
    draw_set_alpha(text_alpha);
    
    // Black outline (8-direction for crisp look)
	/*
    draw_set_color(c_black);
    for (var dx = -1; dx <= 1; dx++) {
        for (var dy = -1; dy <= 1; dy++) {
            if (dx != 0 || dy != 0) {
                draw_text(text_x + dx, text_y + dy, prompt_text);
            }
        }
    }
    */
	
    // Main text (bright white/yellow for attention)
    draw_set_color(c_yellow);
	
 //   draw_text(text_x, text_y, prompt_text);
    
    // Reset draw settings
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}