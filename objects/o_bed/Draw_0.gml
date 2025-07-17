// Draw the bed sprite first
draw_self();

// Then show prompt when player is near
if (distance_to_object(o_player) < 16) {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    
    // Black outline
    draw_set_color(c_black);
    draw_text(x+1, y-5+1, "Press UP to Sleep");
    draw_text(x-1, y-5-1, "Press UP to Sleep");
    draw_text(x+1, y-5-1, "Press UP to Sleep");
    draw_text(x-1, y-5+1, "Press UP to Sleep");
    
    // White text
    draw_set_color(c_white);
    draw_text(x, y-5, "Press UP to Sleep");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}