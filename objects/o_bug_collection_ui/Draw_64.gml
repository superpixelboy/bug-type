// o_bug_collection_ui - Fixed Draw GUI Event
// Collection button - bottom left corner (ALWAYS draw this)
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
if (!is_open) {
    // Reset color and exit if closed
    draw_set_color(c_white);
    exit;
}

// Draw the book background (centered on screen)
var screen_center_x = (480 / 2) * gui_scale;  // Center of 960px wide GUI
var screen_center_y = (270 / 2) * gui_scale;  // Center of 540px tall GUI
draw_sprite_ext(s_collection_page, 0, screen_center_x, screen_center_y, gui_scale, gui_scale, 0, c_white, 1);

// Check if bug data exists
if (!variable_global_exists("bug_data")) {
    draw_set_halign(fa_center);
    draw_set_color(c_red);
    draw_text((ui_x + ui_width/2) * gui_scale, (ui_y + 100) * gui_scale, "Bug data not loaded!");
    draw_set_halign(fa_left);
    exit;
}

// Get all bugs from the data system
var all_bug_keys = variable_struct_get_names(global.bug_data);
var total_bugs = array_length(all_bug_keys);
var total_pages = ceil(total_bugs / bugs_per_page);

// Draw cards horizontally across the book pages
var start_bug = page * bugs_per_page;

for (var i = 0; i < bugs_per_page; i++) {
    var bug_index = start_bug + i;
    if (bug_index >= total_bugs) break;
    
    // Calculate card position (consistent scaling)
    var card_x = (card_start_x + (i * card_spacing)) * gui_scale;
    var card_y_pos = card_y * gui_scale;
    
    // Get bug data using the bug key
    var bug_key = all_bug_keys[bug_index];
    var bug_data = global.bug_data[$ bug_key];
    
    // Check if discovered using the bug_key
    var is_discovered = ds_map_exists(global.discovered_bugs, bug_key);
    
    if (is_discovered) {
        // Draw the full bug card (0.5x scale)
        draw_sprite_ext(s_card_template, 1, card_x, card_y_pos, 0.5 * gui_scale, 0.5 * gui_scale, 0, c_white, 1);
        
        // Draw bug sprite on the card (0.5x scale)
        var bug_sprite = bug_data.sprite;
        draw_sprite_ext(bug_sprite, 0, card_x, card_y_pos - (15 * gui_scale), 0.5 * gui_scale, 0.5 * gui_scale, 0, c_white, 1);
        
        // Bug name below card
        draw_set_halign(fa_center);
        draw_set_color(c_black);
        draw_set_font(fnt_card_title_2x);
        draw_text(card_x, card_y_pos + (35 * gui_scale), bug_data.name);
        
    } else {
        // Draw card back with bug silhouette (0.5x scale)
        draw_sprite_ext(s_card_template, 0, card_x, card_y_pos, 0.5 * gui_scale, 0.5 * gui_scale, 0, c_white, 1);
        
        // Draw bug silhouette as faded black (0.5x scale)
        var bug_sprite = bug_data.sprite;
        draw_sprite_ext(bug_sprite, 0, card_x, card_y_pos - (15 * gui_scale), 0.5 * gui_scale, 0.5 * gui_scale, 0, 
                       c_black, 0.75); // Faded black silhouette (40% opacity)
        
        // No mystery text - just the faded silhouette
    }
}

// Page navigation text
if (total_pages > 1) {
    draw_set_halign(fa_center);
    draw_set_color(c_black);
    draw_set_font(fnt_card_title_2x);
    draw_text((ui_width/2) * gui_scale, (ui_height - 60) * gui_scale, 
              "Page " + string(page + 1) + "/" + string(total_pages));
}

// Instructions
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(101, 67, 33));
draw_set_font(fnt_flavor_text_2x);
draw_text((ui_width/2) * gui_scale, (ui_height - 40) * gui_scale, "TAB: Close  ←→: Navigate");

// Draw navigation arrows
if (total_pages > 1) {
    draw_set_font(fnt_card_title_2x);
    // Left arrow
    if (page > 0) {
        draw_set_color(c_black);
        draw_text(60 * gui_scale, (ui_height/2) * gui_scale, "<");  // Adjusted for repositioning
    }
    
    // Right arrow  
    if (page < total_pages - 1) {
        draw_set_color(c_black);
        draw_text((ui_width - 30) * gui_scale, (ui_height/2) * gui_scale, ">");
    }
}

// Draw close button
var close_x = (ui_width - 35) * gui_scale;
var close_y = 15 * gui_scale;
var close_size = 20 * gui_scale;

// Draw close button background
draw_set_color(c_ltgray);
draw_rectangle(close_x, close_y, close_x + close_size, close_y + close_size, false);
draw_set_color(c_black);
draw_rectangle(close_x, close_y, close_x + close_size, close_y + close_size, true);

// Draw X
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_font(fnt_card_title_2x);
draw_text(close_x + close_size/2, close_y + close_size/2, "X");

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);