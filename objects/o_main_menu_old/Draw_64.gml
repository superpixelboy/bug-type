// o_start_screen_manager Draw GUI Event
// Layer 3: Title and menu items with enhanced fade animations

// Get screen dimensions
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var gui_scale = 2; // Assuming same scale as your other UI

// Set up font for menu items
if (font_exists(fnt_flavor_text_2x)) {
    draw_set_font(fnt_flavor_text_2x);
} else {
    draw_set_font(-1);
    show_debug_message("WARNING: fnt_flavor_text_2x missing, using default font");
}

// Title positioning (center of screen, positioned over the hole)
var title_x = gui_w / 2;
var title_y = gui_h * 0.35; // Position over the hole area

// Draw the game title sprite with fade effect (UNCHANGED LOGIC)
draw_set_alpha(menu_alpha); // Use fade alpha for menu

if (sprite_exists(s_title_title)) {
    // Use your beautiful title sprite
    draw_sprite_ext(s_title_title, 0, title_x, title_y, gui_scale, gui_scale, 0, c_white, title_alpha);
} else {
    // Fallback: Text title
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Draw shadow for visibility
    draw_set_color(c_black);
    var shadow_offset = 2;
    draw_text_transformed(title_x + shadow_offset, title_y + shadow_offset, 
                         "WITCH SEASON", gui_scale * 1.5, gui_scale * 1.5, 0);
    
    // Main title text
    draw_set_color(make_color_rgb(255, 215, 100)); // Warm golden color
    draw_text_transformed(title_x, title_y, "WITCH SEASON", gui_scale * 1.5, gui_scale * 1.5, 0);
    
    show_debug_message("WARNING: s_title_title missing, using text fallback");
}

// ENHANCED: Show menu with fade animation (replaces instant appearance)
if (title_fully_visible && menu_alpha > 0) {
    // Menu items positioning (below the title)
    var menu_start_y = gui_h * 0.67;
    var menu_spacing = 25 * gui_scale; // Reduced from 35 to 25 for tighter spacing
    
    // NEW: Use menu_alpha instead of full opacity
draw_set_alpha(title_alpha); // Use title alpha for title
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    for (var i = 0; i < array_length(menu_items); i++) {
        var item = menu_items[i];
        var item_y = menu_start_y + (i * menu_spacing);
        var is_selected = (i == selected_index);
        
        if (!item.enabled) {
            // Disabled items
            draw_set_color(c_gray);
            draw_text_transformed(title_x, item_y, item.text, gui_scale, gui_scale, 0);
        } else if (is_selected) {
            // Selected item: White text with dark purple outline (your existing style)
            var dark_purple = make_color_rgb(75, 50, 130);
            var outline_offset = 1;
            
            // Draw purple outline in 8 directions
            draw_set_color(dark_purple);
            draw_text_transformed(title_x - outline_offset, item_y - outline_offset, item.text, gui_scale, gui_scale, 0);
            draw_text_transformed(title_x + outline_offset, item_y - outline_offset, item.text, gui_scale, gui_scale, 0);
            draw_text_transformed(title_x - outline_offset, item_y + outline_offset, item.text, gui_scale, gui_scale, 0);
            draw_text_transformed(title_x + outline_offset, item_y + outline_offset, item.text, gui_scale, gui_scale, 0);
            draw_text_transformed(title_x - outline_offset, item_y, item.text, gui_scale, gui_scale, 0);
            draw_text_transformed(title_x + outline_offset, item_y, item.text, gui_scale, gui_scale, 0);
            draw_text_transformed(title_x, item_y - outline_offset, item.text, gui_scale, gui_scale, 0);
            draw_text_transformed(title_x, item_y + outline_offset, item.text, gui_scale, gui_scale, 0);
            
            // Draw main white text on top
            draw_set_color(c_white);
            draw_text_transformed(title_x, item_y, item.text, gui_scale, gui_scale, 0);
        } else {
            // Normal unselected items: Dark purple text
            draw_set_color(make_color_rgb(64, 32, 96));
            draw_text_transformed(title_x, item_y, item.text, gui_scale, gui_scale, 0);
        }
    }
}

// Reset draw settings (IMPORTANT: Reset alpha to 1)
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);