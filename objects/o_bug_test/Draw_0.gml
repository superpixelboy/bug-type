/// @description Insert description here
// You can write your code in this editor
// Draw the bug sprite
draw_self();

// Draw "Bug Caught!" text when caught
if (state == "caught") {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    
    // Draw text with black outline for visibility
    var text_x = room_width/2;
    var text_y = room_height/2 - 60;
    
    // Black outline
    draw_set_color(c_black);
    draw_text(text_x+1, text_y+1, "Bug Caught!");
    draw_text(text_x-1, text_y-1, "Bug Caught!");
    draw_text(text_x+1, text_y-1, "Bug Caught!");
    draw_text(text_x-1, text_y+1, "Bug Caught!");
    
    // White text
    draw_set_color(c_white);
    draw_text(text_x, text_y, "Bug Caught!");
    
    // Reset draw settings
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}