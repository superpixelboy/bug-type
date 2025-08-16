// o_hole - Draw Event (Updated)

// Draw the hole sprite first
draw_self();

// Don't show sleep prompt during intro
if (variable_instance_exists(id, "intro_active") && intro_active) {
    exit;  // Skip sleep prompt during intro
}

// Then show prompt when player is near (original logic)
if (distance_to_object(o_player) < 16) {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    
    // Black outline
    draw_set_color(c_black);
    draw_text(x+1, y-5+1, "Press space to Sleep");
    draw_text(x-1, y-5-1, "Press space to Sleep");
    draw_text(x+1, y-5-1, "Press space to Sleep");
    draw_text(x-1, y-5+1, "Press space to Sleep");
    
    // White text
    draw_set_color(c_white);
    draw_text(x, y-5, "Press space to Sleep");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}