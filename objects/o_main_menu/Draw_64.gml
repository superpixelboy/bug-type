// o_main_menu Draw GUI Event - FIXED TO SHOW DISABLED ITEMS
// Exit early if menu not active (following your pattern)
if (!menu_active) {
    exit;
}

// Use the same positioning system as your pause menu
var screen_center_x = (480 / 2) * 2; // gui_scale is 2
var screen_center_y = (270 / 2) * 2; 

// SAFETY: Try to set custom font, fall back to default if missing
if (font_exists(fnt_flavor_text_2x)) {
    draw_set_font(fnt_flavor_text_2x);
} else {
    draw_set_font(-1); // Use default font as fallback
    show_debug_message("WARNING: fnt_flavor_text_2x missing, using default font");
}

// Only draw menu if scale is visible
if (menu_scale > 0.01) {
    // SAFETY: Try to draw menu background sprite, fall back to rectangle if missing
    if (sprite_exists(s_menu_page)) {
        draw_sprite_ext(s_menu_page, 0, screen_center_x, screen_center_y, 
                       menu_scale * 2, menu_scale * 2, 0, c_white, 1);
    } else {
        // Fallback: Draw a simple menu background
        draw_set_alpha(0.9);
        draw_set_color(make_color_rgb(40, 30, 60)); // Dark purple background
        var bg_w = 300 * menu_scale;
        var bg_h = 250 * menu_scale;
        draw_rectangle(screen_center_x - bg_w/2, screen_center_y - bg_h/2, 
                      screen_center_x + bg_w/2, screen_center_y + bg_h/2, false);
        draw_set_alpha(1);
        show_debug_message("WARNING: s_menu_page missing, using fallback background");
    }
    
    // Only draw text content after animation is mostly complete
    if (menu_scale > 0.3) {
        // Calculate positioning - tighter spacing for main menu
        var title_y = screen_center_y - 110 * menu_scale;
        var items_start_y = screen_center_y - 20 * menu_scale; 
        var item_spacing = 28 * menu_scale;
        
        // Game title at the top
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        draw_text_transformed(screen_center_x, title_y, "WITCH BUG CATCHER", 
                            menu_scale * 1.2, menu_scale * 1.2, 0);
        
        // Draw menu items with your UI style (white with purple outline for selected)
        for (var i = 0; i < array_length(menu_items); i++) {
            var item = menu_items[i];
            var item_y = items_start_y + (i * item_spacing);
            var is_selected = (i == selected_index);
            
            if (!item.enabled) {
                // Disabled items are greyed out
                draw_set_color(c_gray);
                draw_text_transformed(screen_center_x, item_y, item.text, menu_scale, menu_scale, 0);
            } else if (is_selected) {
                // Selected item: White text with purple outline (your UI style)
                var dark_purple = make_color_rgb(75, 50, 130);
                var outline_offset = 1 * menu_scale;
                
                // Draw purple outline in 8 directions
                draw_set_color(dark_purple);
                draw_text_transformed(screen_center_x - outline_offset, item_y - outline_offset, item.text, menu_scale, menu_scale, 0);
                draw_text_transformed(screen_center_x + outline_offset, item_y - outline_offset, item.text, menu_scale, menu_scale, 0);
                draw_text_transformed(screen_center_x - outline_offset, item_y + outline_offset, item.text, menu_scale, menu_scale, 0);
                draw_text_transformed(screen_center_x + outline_offset, item_y + outline_offset, item.text, menu_scale, menu_scale, 0);
                draw_text_transformed(screen_center_x - outline_offset, item_y, item.text, menu_scale, menu_scale, 0);
                draw_text_transformed(screen_center_x + outline_offset, item_y, item.text, menu_scale, menu_scale, 0);
                draw_text_transformed(screen_center_x, item_y - outline_offset, item.text, menu_scale, menu_scale, 0);
                draw_text_transformed(screen_center_x, item_y + outline_offset, item.text, menu_scale, menu_scale, 0);
                
                // Draw main white text on top
                draw_set_color(c_white);
                draw_text_transformed(screen_center_x, item_y, item.text, menu_scale, menu_scale, 0);
            } else {
                // Non-selected enabled items: Regular dark purple text
                var dark_purple = make_color_rgb(75, 50, 130);
                draw_set_color(dark_purple);
                draw_text_transformed(screen_center_x, item_y, item.text, menu_scale, menu_scale, 0);
            }
        }
    }
}

// Reset draw settings at the VERY END
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);