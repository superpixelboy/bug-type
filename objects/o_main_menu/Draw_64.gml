// o_main_menu Draw GUI Event - Beautiful Main Menu with s_menu_page
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
        if (menu_scale > 0.7) {
            draw_set_halign(fa_center);
            draw_set_color(make_color_rgb(64, 32, 96)); // Dark purple
            draw_text_transformed(screen_center_x, title_y, "BUG WITCH", menu_scale * 1.2, menu_scale * 1.2, 0);
        }
        
        // Menu items (only show if animation is far enough along)
        if (menu_scale > 0.7) {
            draw_set_halign(fa_center);
            
            // Define colors
            var dark_purple = make_color_rgb(64, 32, 96);
            var disabled_gray = make_color_rgb(100, 100, 100);
            
            for (var i = 0; i < array_length(menu_items); i++) {
                var item_y = items_start_y + (i * item_spacing);
                
                // Check if this item should be disabled
                var is_disabled = (menu_items[i].action == "continue" && !has_save_data);
                
                // Menu item text with selection styling
                if (i == selected_index && animation_timer >= entrance_duration && !is_disabled) {
                    // Selected item: White text with dark purple outline
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
                } else if (is_disabled) {
                    // Disabled item: Gray text
                    draw_set_color(disabled_gray);
                    draw_text_transformed(screen_center_x, item_y, menu_items[i].text, menu_scale, menu_scale, 0);
                } else {
                    // Non-selected item: Dark purple text
                    draw_set_color(dark_purple);
                    draw_text_transformed(screen_center_x, item_y, menu_items[i].text, menu_scale, menu_scale, 0);
                }
            }
        }
        
        // Instructions at bottom
        if (menu_scale > 0.8) {
            var instructions_y = screen_center_y + 100 * menu_scale;
            draw_set_color(make_color_rgb(100, 100, 100));
            draw_text_transformed(screen_center_x, instructions_y, "ARROW KEYS • ENTER", menu_scale * 0.7, menu_scale * 0.7, 0);
        }
    }
}

// Reset draw settings at the VERY END (exactly like your other menus)
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);