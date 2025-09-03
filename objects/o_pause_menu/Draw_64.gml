// o_pause_menu Draw GUI Event - WITH BEAUTIFUL s_menu_page BACKGROUND
// Exit early if menu not active (EXACTLY like collection UI)
if (!menu_active) {
    exit;
}

// Use the EXACT same positioning as the working test
var screen_center_x = (480 / 2) * 2; // gui_scale is 2
var screen_center_y = (270 / 2) * 2; 

// Dark overlay at 15% opacity over EVERYTHING
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
draw_set_alpha(0.4);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);
draw_set_font(fnt_flavor_text_2x);

// Only draw menu if scale is visible
if (menu_scale > 0.01) {
    // Draw the beautiful menu page background sprite (scaled with animation)
    draw_sprite_ext(s_menu_page, 0, screen_center_x, screen_center_y, 
                   menu_scale * 2, menu_scale * 2, 0, c_white, 1);
    
    // Only draw text content after animation is mostly complete
    if (menu_scale > 0.3) {
        // Calculate text positioning relative to the sprite
        var title_y = screen_center_y - 100 * menu_scale;
        var essence_y = screen_center_y - 70 * menu_scale;
        var items_start_y = screen_center_y + 0 * menu_scale;
        var item_spacing = 35 * menu_scale;
        var instructions_y = screen_center_y + 110 * menu_scale;

        
        // Menu items (only show if animation is far enough along)
        if (menu_scale > 0.7) {
            draw_set_halign(fa_center); // Center align for cleaner look on the page
            
            // Define colors
            var dark_purple = make_color_rgb(64, 32, 96);  // Dark purple for normal text
            
            for (var i = 0; i < array_length(menu_items); i++) {
                var item_y = items_start_y + (i * item_spacing);
                
                // Menu item text with selection styling
                if (i == selected_index && animation_timer >= entrance_duration) {
                    // Selected item: White text with dark purple outline
                    // Draw outline by drawing text multiple times with offset
                    draw_set_color(dark_purple);
                    var outline_offset = 1;
                    // Draw outline in 8 directions
                    draw_text_transformed(screen_center_x - outline_offset, item_y - outline_offset, menu_items[i].text, menu_scale, menu_scale, 0);
                    draw_text_transformed(screen_center_x + outline_offset, item_y - outline_offset, menu_items[i].text, menu_scale, menu_scale, 0);
                    draw_text_transformed(screen_center_x - outline_offset, item_y + outline_offset, menu_items[i].text, menu_scale, menu_scale, 0);
                    draw_text_transformed(screen_center_x + outline_offset, item_y + outline_offset, menu_items[i].text, menu_scale, menu_scale, 0);
                    draw_text_transformed(screen_center_x - outline_offset, item_y, menu_items[i].text, menu_scale, menu_scale, 0);
                    draw_text_transformed(screen_center_x + outline_offset, item_y, menu_items[i].text, menu_scale, menu_scale, 0);
                    draw_text_transformed(screen_center_x, item_y - outline_offset, menu_items[i].text, menu_scale, menu_scale, 0);
                    draw_text_transformed(screen_center_x, item_y + outline_offset, menu_items[i].text, menu_scale, menu_scale, 0);
                    
                    // Draw main white text on top
                    draw_set_color(c_white);
                    draw_text_transformed(screen_center_x, item_y, menu_items[i].text, menu_scale, menu_scale, 0);
                } else {
                    // Non-selected item: Dark purple text
                    draw_set_color(dark_purple);
                    draw_text_transformed(screen_center_x, item_y, menu_items[i].text, menu_scale, menu_scale, 0);
                }
            }
        }
        
      
    }
}

// Reset draw settings at the VERY END (exactly like collection UI)
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);