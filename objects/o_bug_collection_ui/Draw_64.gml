// DETAIL VIEW - Add this to the very end of your Draw_64 event
// DEBUG - Add this to the very start of your Draw_64 event temporarily
draw_set_font(fnt_card_title_2x);
draw_set_color(c_red);
draw_text(10, 10, "is_open: " + string(is_open));
draw_text(10, 30, "detail_view_open: " + string(detail_view_open));

if (is_open) {
    draw_text(10, 50, "Collection should be visible!");
}

// Check if bug data exists
if (!variable_global_exists("bug_data")) {
    draw_set_halign(fa_center);
    draw_set_color(c_red);
    draw_text((ui_x + ui_width/2) * gui_scale, (ui_y + 100) * gui_scale, "Bug data not loaded!");
    draw_set_halign(fa_left);
    exit;
}
// Also draw a simple test rectangle when collection is open
if (is_open) {
    draw_set_color(c_yellow);
    draw_rectangle(100, 100, 200, 200, false);
    draw_set_color(c_black);
    draw_text(110, 150, "TEST");
}

// Add this right before the collection panel code
if (is_open) {
    draw_set_color(c_lime);
    draw_text(10, 70, "About to draw collection panel!");
}
// Debug bug data
if (is_open) {
    if (!variable_global_exists("bug_data")) {
        draw_set_color(c_red);
        draw_text(10, 90, "BUG DATA MISSING!");
    } else {
        draw_set_color(c_lime);
        draw_text(10, 90, "Bug data exists!");
        var all_bug_keys = variable_struct_get_names(global.bug_data);
        draw_text(10, 110, "Bug count: " + string(array_length(all_bug_keys)));
    }
}
if (detail_view_open && detail_bug_data != {}) {
    // Draw dark overlay
    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
    
    // Center position for the big card
    var center_x = display_get_gui_width() * 0.5;
    var center_y = display_get_gui_height() * 0.5;
    var detail_scale = 1.5; // Make it bigger than catch screen
    
    // Draw the big card (reuse your catch screen logic)
    draw_sprite_ext(s_card_template, 1, center_x, center_y, 
                   detail_scale * gui_scale, detail_scale * gui_scale, 0, c_white, 1);
    
    // Calculate card dimensions for positioning
    var card_w = sprite_get_width(s_card_template) * detail_scale * gui_scale;
    var card_h = sprite_get_height(s_card_template) * detail_scale * gui_scale;
    
    // Position everything relative to card center
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // ---- BUG SPRITE ----
    var target_bug_size = card_h * 0.35;
    var bug_w = sprite_get_width(detail_bug_data.sprite);
    var bug_h = sprite_get_height(detail_bug_data.sprite);
    var bug_scale = min(target_bug_size / bug_w, target_bug_size / bug_h);
    var bug_y_offset = card_h * -0.20;
    
    // Draw bug shadow
    draw_sprite_ext(detail_bug_data.sprite, 0, center_x + 3, center_y + bug_y_offset + 3, 
                   bug_scale, bug_scale, 0, c_black, 0.6);
    // Draw bug
    draw_sprite_ext(detail_bug_data.sprite, 0, center_x, center_y + bug_y_offset, 
                   bug_scale, bug_scale, 0, c_white, 1);
    
    // ---- BUG NAME ----
    draw_set_font(fnt_card_title_2x);
    var cream = make_color_rgb(245,235,215);
    var dark_purple = make_color_rgb(45, 25, 60);
    var name_y_offset = card_h * 0.08;
    var name_width = card_w * 0.8;
    var name_line_sep = 14 * detail_scale * gui_scale;
    
    // Shadow
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_text_ext(center_x + 4, center_y + name_y_offset + 4, detail_bug_data.name, name_line_sep, name_width);
    draw_set_alpha(1);
    
    // Outline
    draw_set_color(dark_purple);
    draw_text_ext(center_x + 2, center_y + name_y_offset + 2, detail_bug_data.name, name_line_sep, name_width);
    draw_text_ext(center_x - 2, center_y + name_y_offset - 2, detail_bug_data.name, name_line_sep, name_width);
    draw_text_ext(center_x + 2, center_y + name_y_offset - 2, detail_bug_data.name, name_line_sep, name_width);
    draw_text_ext(center_x - 2, center_y + name_y_offset + 2, detail_bug_data.name, name_line_sep, name_width);
    
    // Main text
    draw_set_color(cream);
    draw_text_ext(center_x, center_y + name_y_offset, detail_bug_data.name, name_line_sep, name_width);
    
    // ---- FLAVOR TEXT ----
    draw_set_font(fnt_flavor_text_2x);
    var light_gold = make_color_rgb(255,223,128);
    var flavor_y_offset = card_h * 0.28;
    var flavor_width = card_w * 0.75;
    var flavor_line_sep = 12 * detail_scale * gui_scale;
    
    // Outline
    draw_set_color(c_black);
    draw_text_ext(center_x + 2, center_y + flavor_y_offset + 2, detail_bug_data.flavor_text, flavor_line_sep, flavor_width);
    draw_text_ext(center_x - 2, center_y + flavor_y_offset - 2, detail_bug_data.flavor_text, flavor_line_sep, flavor_width);
    draw_text_ext(center_x + 2, center_y + flavor_y_offset - 2, detail_bug_data.flavor_text, flavor_line_sep, flavor_width);
    draw_text_ext(center_x - 2, center_y + flavor_y_offset + 2, detail_bug_data.flavor_text, flavor_line_sep, flavor_width);
    
    // Main text
    draw_set_color(light_gold);
    draw_text_ext(center_x, center_y + flavor_y_offset, detail_bug_data.flavor_text, flavor_line_sep, flavor_width);
    
    // ---- ESSENCE TEXT ----
    draw_set_font(fnt_flavor_text_2x);
    var essence_y_offset = card_h * 0.40;
    var essence_text = "Essence: +" + string(detail_bug_data.essence);
    
    // Outline
    draw_set_color(c_black);
    draw_text(center_x + 2, center_y + essence_y_offset + 2, essence_text);
    draw_text(center_x - 2, center_y + essence_y_offset - 2, essence_text);
    draw_text(center_x + 2, center_y + essence_y_offset - 2, essence_text);
    draw_text(center_x - 2, center_y + essence_y_offset + 2, essence_text);
    
    // Main text
    draw_set_color(make_color_rgb(255,215,0));
    draw_text(center_x, center_y + essence_y_offset, essence_text);
    
    // Draw gems and coins
    var gem_x = center_x + (card_w * 0.32);
    var gem_y = center_y - (card_h * 0.38);
    var coin_x = center_x - (card_w * 0.32);
    var coin_y = center_y - (card_h * 0.38);
    
    // Get the bug's index for coin value (you might need to calculate this)
    var coin_value = 5; // Placeholder - you'll need to calculate this based on the bug
    var coin_sprite = s_coin_copper;
    if (coin_value > 9) coin_sprite = s_coin_gold;
    else if (coin_value > 4) coin_sprite = s_coin_silver;
    
    // Draw coin
    draw_sprite_ext(coin_sprite, 0, coin_x, coin_y, 
                   detail_scale * gui_scale, detail_scale * gui_scale, 0, c_white, 1);
    
    // Coin number
    draw_set_font(fnt_card_title_2x);
    draw_set_color(cream);
    draw_text(coin_x, coin_y, string(coin_value));
    
    // Draw gem
    var gem_rarity = scr_gem_rarity(detail_bug_key);
    var gem_sprite = get_gem_sprite(gem_rarity);
    draw_sprite_ext(gem_sprite, 0, gem_x, gem_y, 
                   detail_scale * gui_scale, detail_scale * gui_scale, 0, c_white, 1);
    
    // Instructions
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_set_font(fnt_flavor_text_2x);
    draw_text(center_x, center_y + (card_h * 0.6), "Press TAB or ESC to close");
    
    // Reset draw settings
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}