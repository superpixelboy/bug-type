// Draw dialogue box when active
if (dialogue_active) {
    var text = "";
    
    // Get current dialogue text based on state
    if (dialogue_state == "greeting") {
        text = dialogue_greeting[dialogue_index];
    } else if (dialogue_state == "progress") {
        text = dialogue_progress[dialogue_index];
    } else if (dialogue_state == "encouragement") {
        text = dialogue_encouragement[dialogue_index];
    }
    
    // Dialogue box at top of screen
    var box_x = 20;
    var box_y = 20;  // Top of screen
    var box_width = 440;  // Wider since it's at top
    var box_height = 100;  // Taller for better readability
    
    draw_set_color(c_black);
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);
    
    draw_set_color(c_white);
    draw_rectangle(box_x + 2, box_y + 2, box_x + box_width - 2, box_y + box_height - 2, false);
    
    // Reset all text alignment settings
    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // Dialogue text
    draw_set_color(c_black);
    draw_text_ext(box_x + 15, box_y + 15, text, 18, box_width - 30);
    
    // Continue prompt (bottom right of dialogue box)
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_text(box_x + box_width - 15, box_y + box_height - 10, "SPACE or Click to continue");
    
    // Reset alignment
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}