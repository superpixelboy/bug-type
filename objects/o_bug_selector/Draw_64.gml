// o_bug_selector - Draw GUI Event
if (menu_active) {
    // Semi-transparent background
    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_rectangle(20, 20, 460, 250, false);
    draw_set_alpha(1);
    
    // Menu border (GBA style)
    draw_set_color(c_white);
    draw_rectangle(20, 20, 460, 250, true);
    
    // Title
    draw_set_font(-1);
    draw_set_color(c_yellow);
    draw_set_halign(fa_center);
    draw_text(240, 30, "SELECT BUG FOR DEMO");
    
    // Bug list
    var start_index = max(0, selected_index - bugs_per_page + 1);
    start_index = min(start_index, max(0, array_length(bug_list) - bugs_per_page));
    
    for (var i = 0; i < min(bugs_per_page, array_length(bug_list)); i++) {
        var list_index = start_index + i;
        if (list_index >= array_length(bug_list)) break;
        
        var yy = 60 + (i * 20);
        var bug = bug_list[list_index];
        
        // Highlight selected
        if (list_index == selected_index) {
            draw_set_color(c_blue);
            draw_rectangle(25, yy - 2, 455, yy + 16, false);
        }
        
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_text(30, yy, bug.name);
    }
    
    // Instructions
    draw_set_color(c_ltgray);
    draw_set_halign(fa_center);
    draw_text(240, 230, "↑↓: Navigate  ENTER: Select  ESC/F1: Cancel");
    
    // Reset draw settings
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}