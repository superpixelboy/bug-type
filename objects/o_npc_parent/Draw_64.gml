// o_npc_parent Draw GUI Event
// Universal dialogue system for all NPCs


if (dialogue_active) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var box_w = sprite_get_width(s_dialogue_back);
    var box_h = sprite_get_height(s_dialogue_back);
    
    var box_x = gui_w/2;
    var box_y = gui_h/2 + box_h;
    
    // Draw the parchment background
    draw_sprite(s_dialogue_back, 0, box_x, box_y);
    
    // Set dialogue font
    if (font_exists(fnt_dialogue)) {
        draw_set_font(fnt_dialogue);
    } else {
        draw_set_font(-1);
    }
    
    // Use typewriter text for animated display
    var display_text = typewriter_text;
    
    var text_x = box_x/5;
    var text_y = gui_h/1.45;
    var text_width = box_w - 60;
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // Dark brown text with transparency
    var dark_brown = make_color_rgb(101, 67, 33);
    var text_alpha = 0.85;
    
    draw_set_alpha(text_alpha);
    draw_set_color(dark_brown);
    draw_text_ext(text_x, text_y, display_text, 26, text_width);
    
    // Show continue prompt when typewriter is complete
    if (typewriter_complete) {
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_set_color(c_ltgray);
        draw_text(gui_w-110, gui_h-10, "Continue");
    }
    
    // Reset draw settings
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);
    draw_set_color(c_white);
}