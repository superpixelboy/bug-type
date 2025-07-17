// Draw Babayaga sprite
draw_self();

// DEBUG: Show dialogue state above Babayaga
draw_set_color(c_white);
draw_text(x, y - 30, "Active: " + string(dialogue_active));
draw_text(x, y - 45, "State: " + dialogue_state);

// Show interaction prompt
if (distance_to_object(o_player) < 32 && !dialogue_active) {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    
    // Black outline
    draw_set_color(c_black);
    draw_text(x+1, y-10+1, "Press UP to Talk");
    draw_text(x-1, y-10-1, "Press UP to Talk");
    draw_text(x+1, y-10-1, "Press UP to Talk");
    draw_text(x-1, y-10+1, "Press UP to Talk");
    
    // White text
    draw_set_color(c_white);
    draw_text(x, y-10, "Press UP to Talk");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}