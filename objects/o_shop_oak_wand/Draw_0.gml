// In o_shop_oak_wand Draw Event
draw_self();

// Always show item name underneath
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_text(x, y + 50, item_name);

// Show detailed popup when player is close
if (distance_to_object(o_player) < 32 && o_player.y > y - 10) {
    
    // Much bigger popup using top half of screen
    var popup_x = 40;
    var popup_y = 30;
    var popup_width = 400;
    var popup_height = 120;
    
    // Black border (thicker for better visibility)
    draw_set_color(c_black);
    draw_rectangle(popup_x, popup_y, popup_x + popup_width, popup_y + popup_height, false);
    
    // White background
    draw_set_color(c_white);
    draw_rectangle(popup_x + 3, popup_y + 3, popup_x + popup_width - 3, popup_y + popup_height - 3, false);
    
    // Title
    draw_set_halign(fa_center);
    draw_set_color(c_black);
    draw_set_font(-1);
    draw_text(popup_x + popup_width/2, popup_y + 15, item_name);
    
    // Description (bigger text, more space)
    draw_set_color(make_color_rgb(60, 60, 60));
    draw_text(popup_x + popup_width/2, popup_y + 35, item_description);
    
    // Price (much more prominent)
    if (!global.has_oak_wand) {
        if (global.essence >= item_price) {
            draw_set_color(c_green);
        } else {
            draw_set_color(c_red);
        }
        draw_text(popup_x + popup_width/2, popup_y + 60, "Cost: " + string(item_price) + " Essence");
        
        // Current essence
        draw_set_color(c_blue);
        draw_text(popup_x + popup_width/2, popup_y + 80, "You have: " + string(global.essence) + " Essence");
        
        // Interaction hint
        draw_set_color(c_gray);
        draw_text(popup_x + popup_width/2, popup_y + 100, "Press SPACE to purchase");
    } else {
        draw_set_color(c_green);
        draw_text(popup_x + popup_width/2, popup_y + 70, "OWNED - Effect Active!");
    }
}

// Reset alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);