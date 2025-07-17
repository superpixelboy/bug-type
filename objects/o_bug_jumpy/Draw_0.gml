draw_self();

if (state == "caught") {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var text_x = room_width/2;
    var text_y = room_height/2 - 60;
    
    draw_set_color(c_black);
    draw_text(text_x+1, text_y+1, "Jumpy Bug Caught!");
    draw_text(text_x-1, text_y-1, "Jumpy Bug Caught!");
    draw_text(text_x+1, text_y-1, "Jumpy Bug Caught!");
    draw_text(text_x-1, text_y+1, "Jumpy Bug Caught!");
    
    draw_set_color(c_white);
    draw_text(text_x, text_y, "Jumpy Bug Caught!");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}