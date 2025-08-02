// o_bug_collection_ui - Updated Draw GUI Event
// Collection button - bottom left corner
var btn_x = 20;
var btn_y = room_height - 50;
var btn_width = 100;
var btn_height = 30;

// Draw button background
draw_set_color(c_red);
draw_rectangle(btn_x, btn_y, btn_x + btn_width, btn_y + btn_height, false);

// Draw button text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_text(btn_x + btn_width/2, btn_y + btn_height/2, "Collection");

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Only draw collection panel when open
if (!is_open) exit;

// Draw sketchbook background
draw_set_color(make_color_rgb(240, 230, 210));  // Aged paper color
draw_rectangle(ui_x, ui_y, ui_x + ui_width, ui_y + ui_height, false);

// Draw border
draw_set_color(c_black);
draw_rectangle(ui_x, ui_y, ui_x + ui_width, ui_y + ui_height, true);

// Title
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(101, 67, 33));  // Dark brown ink
draw_text(ui_x + ui_width/2, ui_y + 10, "Bug Collection");

// Check if bug data exists
if (!variable_global_exists("bug_data")) {
    draw_set_halign(fa_center);
    draw_set_color(c_red);
    draw_text(ui_x + ui_width/2, ui_y + 100, "Bug data not loaded!");
    draw_set_halign(fa_left);
    exit;
}

// Get all bugs from the data system
var all_bug_keys = variable_struct_get_names(global.bug_data);
var total_bugs = array_length(all_bug_keys);
var total_pages = ceil(total_bugs / bugs_per_page);

// Draw bug grid - 2x2 layout with lots of space
var start_bug = page * bugs_per_page;

var grid_cols = 2;  // 2 across
var grid_rows = 2;  // 2 down  
var cell_width = 180;  // Much bigger cells
var cell_height = 80;

for (var i = 0; i < bugs_per_page; i++) {
    var bug_index = start_bug + i;
    if (bug_index >= total_bugs) break;
    
    var grid_x = i % grid_cols;
    var grid_y = floor(i / grid_cols);
    
    var cell_x = ui_x + 20 + (grid_x * cell_width);
    var cell_y = ui_y + 50 + (grid_y * cell_height);
    
    // Get bug data using the bug key
    var bug_key = all_bug_keys[bug_index];
    var bug_data = global.bug_data[$ bug_key];
    
    // Check if discovered using the bug_key
    var is_discovered = ds_map_exists(global.discovered_bugs, bug_key);
    
    // Draw larger cell background
    draw_set_color(c_white);
    draw_rectangle(cell_x, cell_y, cell_x + 170, cell_y + 70, false);
    draw_set_color(c_black);
    draw_rectangle(cell_x, cell_y, cell_x + 170, cell_y + 70, true);
    
    // Draw bug number
    draw_set_halign(fa_left);
    draw_set_color(c_black);
    draw_text(cell_x + 5, cell_y + 5, string(bug_index + 1));
    
    if (is_discovered) {
        // Draw actual bug sprite (scaled down from battle size)
        var bug_sprite = bug_data.sprite;
        
        // Draw sprite at smaller scale
        draw_sprite_ext(bug_sprite, 0, cell_x + 85, cell_y + 25, 0.6, 0.6, 0, c_white, 1);
        
        // Bug name - centered
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(101, 67, 33));
        draw_text(cell_x + 85, cell_y + 50, bug_data.name);
        
        // Essence values in upper right corner
        draw_set_halign(fa_right);
        draw_set_color(c_gray);
        draw_text(cell_x + 165, cell_y + 5, "e. " + string(bug_data.essence));
        
    } else {
        // Draw silhouette using the same sprite
        var bug_sprite = bug_data.sprite;
        
        // Draw as dark silhouette
        draw_sprite_ext(bug_sprite, 0, cell_x + 85, cell_y + 25, 0.6, 0.6, 0, c_black, 0.3);
        
        draw_set_halign(fa_center);
        draw_set_color(c_black);
        draw_text(cell_x + 85, cell_y + 50, "???");
    }
}

// Page navigation
if (total_pages > 1) {
    draw_set_halign(fa_center);
    draw_set_color(c_black);
    draw_text(ui_x + ui_width/2, ui_y + ui_height - 20, 
              "Page " + string(page + 1) + "/" + string(total_pages) + " (Use Arrow Keys)");
}

// Instructions
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(101, 67, 33));
draw_text(ui_x + ui_width/2, ui_y + ui_height - 5, "Press TAB to close");

// Draw navigation buttons (only if there are multiple pages)
if (total_pages > 1) {
    // Left arrow button
    var left_arrow_x = ui_x;
    var left_arrow_y = ui_y + ui_height/2 - 15;
    var left_arrow_width = 20;
    var left_arrow_height = 30;
    
    // Draw left arrow background
    draw_set_color(page > 0 ? c_ltgray : c_gray);
    draw_rectangle(left_arrow_x, left_arrow_y, left_arrow_x + left_arrow_width, left_arrow_y + left_arrow_height, false);
    draw_set_color(c_black);
    draw_rectangle(left_arrow_x, left_arrow_y, left_arrow_x + left_arrow_width, left_arrow_y + left_arrow_height, true);
    
    // Draw left arrow symbol
    if (page > 0) {
        draw_set_color(c_black);
        draw_text(left_arrow_x + 8, left_arrow_y + 8, "<");
    }
    
    // Right arrow button
    var right_arrow_x = ui_x + ui_width - 30;
    var right_arrow_y = ui_y + ui_height/2 - 15;
    var right_arrow_width = 20;
    var right_arrow_height = 30;
    
    // Draw right arrow background
    draw_set_color(page < total_pages - 1 ? c_ltgray : c_gray);
    draw_rectangle(right_arrow_x, right_arrow_y, right_arrow_x + right_arrow_width, right_arrow_y + right_arrow_height, false);
    draw_set_color(c_black);
    draw_rectangle(right_arrow_x, right_arrow_y, right_arrow_x + right_arrow_width, right_arrow_y + right_arrow_height, true);
    
    // Draw right arrow symbol
    if (page < total_pages - 1) {
        draw_set_color(c_black);
        draw_text(right_arrow_x + 8, right_arrow_y + 8, ">");
    }
}

// Draw close button (X in upper right)
var close_x = ui_x + ui_width - 25;
var close_y = ui_y + 5;
var close_size = 20;

// Draw close button background
draw_set_color(c_ltgray);
draw_rectangle(close_x, close_y, close_x + close_size, close_y + close_size, false);
draw_set_color(c_black);
draw_rectangle(close_x, close_y, close_x + close_size, close_y + close_size, true);

// Draw X
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_text(close_x + close_size/2, close_y + close_size/2, "X");

// Reset draw settings
draw_set_halign(fa_left);
draw_set_color(c_white);