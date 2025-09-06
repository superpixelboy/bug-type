// o_ghost_raven_manager Draw GUI Event
// Simple dialogue box with text

if (dialogue_active) {
    // Get GUI dimensions
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    
    // Get dialogue sprite dimensions
    var box_w = sprite_get_width(s_dialogue_back);
    var box_h = sprite_get_height(s_dialogue_back);
    
    // Center the dialogue box
    var box_x = (gui_w - box_w) / 2;
    var box_y = gui_h - box_h - 40;
    
    // Draw dialogue background
    draw_sprite(s_dialogue_back, 0, box_x, box_y);
    
    // Set up font
    if (font_exists(fnt_dialogue)) {
        draw_set_font(fnt_dialogue);
    } else {
        draw_set_font(-1);
    }
    
    // Get the current message
    var current_message = dialogue_messages[dialogue_index];
    
    // For now, just show the full message (we'll fix typewriter later)
    var display_text = current_message;
    
    // Text position
    var text_x = box_x + 30;
    var text_y = box_y + 25;
    var text_width = box_w - 60;
    
    // Draw text with outline
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    draw_set_color(c_black);
    draw_text_ext(text_x + 1, text_y + 1, display_text, 18, text_width);
    draw_text_ext(text_x - 1, text_y - 1, display_text, 18, text_width);
    
    draw_set_color(c_white);
    draw_text_ext(text_x, text_y, display_text, 18, text_width);
    
    // Continue prompt
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_color(c_ltgray);
    draw_text(box_x + box_w - 15, box_y + box_h - 10, "SPACE/CLICK");
    
    // Reset
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);
    draw_set_color(c_white);
}