// obj_babayaga_hut - Draw Event
draw_self();

// Optional: Draw interaction prompt when player can enter
if (can_enter && point_distance(x, y, o_player.x, o_player.y) <= interaction_distance) {
    // Draw a simple "Press Z to Enter" prompt above the hut
    draw_set_color(c_white);
    draw_set_font(fnt_DOS); // Your pixel font
    draw_text(x - 24, y - sprite_height - 16, "Press Z");
    draw_set_color(c_dkgray);
    draw_text(x - 23, y - sprite_height - 15, "Press Z"); // Simple shadow effect
}