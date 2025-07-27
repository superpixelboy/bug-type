// Don't handle clicks if collection is open
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    exit;
}

// Handle button click
if (mouse_check_button_pressed(mb_left)) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    var gui_width = display_get_gui_width();
    var gui_height = display_get_gui_height();
    
    // Bottom right corner
    var btn_x = gui_width - btn_width - btn_margin;
    var btn_y = gui_height - btn_height - btn_margin;
    
    if (mx >= btn_x && mx <= btn_x + btn_width && my >= btn_y && my <= btn_y + btn_height) {
        // Open the collection
        if (instance_exists(o_bug_collection_ui)) {
            o_bug_collection_ui.is_open = true;
            o_bug_collection_ui.page = 0;
        }
    }
}