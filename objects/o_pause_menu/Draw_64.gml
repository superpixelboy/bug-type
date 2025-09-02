// o_pause_menu Draw Event - SIMPLE TEST VERSION
if (menu_active) {
    // Get camera position
    var cam_x = camera_get_view_x(view_camera[0]);
    var cam_y = camera_get_view_y(view_camera[0]);
    var cam_w = camera_get_view_width(view_camera[0]);
    var cam_h = camera_get_view_height(view_camera[0]);
    
    // SIMPLE TEST: Just draw a big red rectangle to make sure we can see SOMETHING
    draw_set_alpha(0.8);
    draw_set_color(c_red);
    draw_rectangle(cam_x + 50, cam_y + 50, cam_x + cam_w - 50, cam_y + cam_h - 50, false);
    draw_set_alpha(1);
    
    // White border
    draw_set_color(c_white);
    draw_rectangle(cam_x + 50, cam_y + 50, cam_x + cam_w - 50, cam_y + cam_h - 50, true);
    
    // Simple text
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text(cam_x + cam_w/2, cam_y + cam_h/2 - 50, "PAUSE MENU TEST");
    draw_text(cam_x + cam_w/2, cam_y + cam_h/2, "ESC to close");
    
    // Menu items
    var start_y = cam_y + cam_h/2 + 30;
    for (var i = 0; i < array_length(menu_items); i++) {
        var item_y = start_y + (i * 25);
        
        // Highlight selected
        if (i == selected_index) {
            draw_set_color(c_yellow);
            draw_text(cam_x + cam_w/2 - 20, item_y, ">");
        }
        
        draw_set_color(c_white);
        draw_text(cam_x + cam_w/2, item_y, menu_items[i].text);
    }
    
    // Reset draw settings
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_set_alpha(1);
}