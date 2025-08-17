// o_collection_button Step Event - HANDLE BOTH OPENING AND CLOSING

// Handle button click
if (mouse_check_button_pressed(mb_left)) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    var gui_width = display_get_gui_width();
    var gui_height = display_get_gui_height();
    
    // Bottom right corner button position
    var btn_x = gui_width - btn_width - btn_margin;
    var btn_y = gui_height - btn_height - btn_margin;
    
    // Check if click is on button
    if (mx >= btn_x && mx <= btn_x + btn_width && my >= btn_y && my <= btn_y + btn_height) {
        // Find and toggle the collection
        var collection_ui = instance_find(o_bug_collection_ui, 0);
        if (collection_ui != noone) {
            // Toggle the collection
            collection_ui.is_open = !collection_ui.is_open;
            
            // Reset states when opening OR closing
            if (collection_ui.is_open) {
                // Opening - reset to first page
                collection_ui.page = 0;
            }
            
            // Always reset these when toggling
            collection_ui.detail_view_open = false;
            collection_ui.detail_bug_key = "";
            collection_ui.detail_bug_data = {};
            collection_ui.hovered_card = -1;
            collection_ui.hover_timer = 0;
        }
    }
}