// Handle collection button click (even when closed)
if (mouse_check_button_pressed(mb_left)) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
var btn_x = 20;
var btn_y = room_height - 50;
var btn_width = 100;
var btn_height = 30;

    if (mx >= btn_x && mx <= btn_x + btn_width && my >= btn_y && my <= btn_y + btn_height) {
        is_open = !is_open;  // Toggle open/closed
        if (is_open) page = 0;  // Reset to first page when opening
        exit;
    }
}

if (!is_open) exit;

// Calculate total bugs and pages
var all_bug_keys = variable_struct_get_names(global.bug_data);
var total_bugs = array_length(all_bug_keys);
var total_pages = ceil(total_bugs / bugs_per_page);

// Mouse handling for buttons
if (mouse_check_button_pressed(mb_left)) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    // Check close button
    var close_x = ui_x + ui_width - 25;
    var close_y = ui_y + 5;
    var close_size = 20;
    
    if (mx >= close_x && mx <= close_x + close_size && my >= close_y && my <= close_y + close_size) {
        is_open = false;
        exit;
    }
    
    // Check navigation arrows (only if multiple pages)
    if (total_pages > 1) {
        // Left arrow
        var left_arrow_x = ui_x + 10;
        var left_arrow_y = ui_y + ui_height/2 - 15;
        var arrow_size = 30;
        
        if (mx >= left_arrow_x && mx <= left_arrow_x + arrow_size && 
            my >= left_arrow_y && my <= left_arrow_y + arrow_size && page > 0) {
            page--;
        }
        
        // Right arrow
        var right_arrow_x = ui_x + ui_width - 40;
        var right_arrow_y = ui_y + ui_height/2 - 15;
        
        if (mx >= right_arrow_x && mx <= right_arrow_x + arrow_size && 
            my >= right_arrow_y && my <= right_arrow_y + arrow_size && page < total_pages - 1) {
            page++;
        }
    }
}

// Keyboard navigation (keep existing)
if (keyboard_check_pressed(vk_left) && page > 0) {
    page--;
}
if (keyboard_check_pressed(vk_right) && page < total_pages - 1) {
    page++;
}