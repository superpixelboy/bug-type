// o_bug_card_collection Draw_64 Event - FINAL BEAUTIFUL VERSION

// Get GUI center position
var gui_center_x = display_get_gui_width() / 2;
var gui_center_y = display_get_gui_height() / 2;

// Card scaling
var card_scale = 1.5; // Make it bigger than normal cards
var card_w = sprite_get_width(s_card_template) * card_scale;
var card_h = sprite_get_height(s_card_template) * card_scale;

// ===== CARD SHADOW =====
var shadow_offset = 12;
draw_sprite_ext(s_card_template, 1, 
               gui_center_x + shadow_offset, gui_center_y + shadow_offset,
               card_scale, card_scale, 0, c_black, 0.4);

// ===== CARD BACKGROUND =====
draw_sprite_ext(s_card_template, 1, 
               gui_center_x, gui_center_y,
               card_scale, card_scale, 0, c_white, 1);

// Only draw content when ready
if (content_ready && content_fade_alpha > 0) {
    
    // ===== GEM (upper right corner) =====
    if (gem_pop_scale > 0) {
        var gem_x = gui_center_x + (card_w * 0.32);
        var gem_y = gui_center_y - (card_h * 0.38);
        
        draw_sprite_ext(gem_sprite, 0, gem_x, gem_y,
                        card_scale * 0.8 * gem_pop_scale, card_scale * 0.8 * gem_pop_scale, 0,
                        c_white, content_fade_alpha);
    }
    
    // ===== COIN (upper left corner) =====
    if (gem_pop_scale > 0) {
        var coin_x = gui_center_x - (card_w * 0.32);
        var coin_y = gui_center_y - (card_h * 0.38);
        
        draw_sprite_ext(coin_sprite, 0, coin_x, coin_y,
                        card_scale * 0.8 * gem_pop_scale, card_scale * 0.8 * gem_pop_scale, 0,
                        c_white, content_fade_alpha);
        
        // Coin number
        draw_set_font(fnt_card_title_2x);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        var cream = make_color_rgb(245,235,215);
        var dark_outline = make_color_rgb(25,15,30);
        var nstr = string(coin_value);
        
        // Outline
        draw_set_color(dark_outline);
        draw_text(coin_x + 3, coin_y + 3, nstr);
        draw_text(coin_x - 3, coin_y - 3, nstr);
        draw_text(coin_x + 3, coin_y - 3, nstr);
        draw_text(coin_x - 3, coin_y + 3, nstr);
        
        // Main text
        draw_set_color(cream);
        draw_text(coin_x, coin_y, nstr);
    }
    
    // ===== BUG SPRITE =====
    if (bug_pop_scale > 0) {
        var target_bug_size = card_h * 0.35;
        var bug_w = sprite_get_width(bug_sprite);
        var bug_h = sprite_get_height(bug_sprite);
        var bug_scale = min(target_bug_size / bug_w, target_bug_size / bug_h) * bug_pop_scale;
        var bug_y_offset = -card_h * 0.20;
        
        // Bug shadow
        draw_sprite_ext(bug_sprite, 0, gui_center_x + 4, gui_center_y + bug_y_offset + 4,
                       bug_scale, bug_scale, 0, c_black, 0.6 * content_fade_alpha);
        
        // Bug sprite
        draw_sprite_ext(bug_sprite, 0, gui_center_x, gui_center_y + bug_y_offset,
                       bug_scale, bug_scale, 0, c_white, content_fade_alpha);
    }
    
    // ===== BUG NAME =====
    draw_set_font(fnt_card_title_2x);
    var cream = make_color_rgb(245,235,215);
    var dark_purple = make_color_rgb(45, 25, 60);
    var name_y_offset = card_h * 0.08;
    var name_width = card_w * 0.8;
    var name_line_sep = 18;
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Name shadow
    draw_set_alpha(0.5 * content_fade_alpha);
    draw_set_color(c_black);
    draw_text_ext(gui_center_x + 5, gui_center_y + name_y_offset + 5, bug_name, name_line_sep, name_width);
    draw_set_alpha(1);
    
    // Name outline
    draw_set_color(dark_purple);
    draw_text_ext(gui_center_x + 2, gui_center_y + name_y_offset + 2, bug_name, name_line_sep, name_width);
    draw_text_ext(gui_center_x - 2, gui_center_y + name_y_offset - 2, bug_name, name_line_sep, name_width);
    draw_text_ext(gui_center_x + 2, gui_center_y + name_y_offset - 2, bug_name, name_line_sep, name_width);
    draw_text_ext(gui_center_x - 2, gui_center_y + name_y_offset + 2, bug_name, name_line_sep, name_width);
    
    // Main name text
    draw_set_color(cream);
    draw_text_ext(gui_center_x, gui_center_y + name_y_offset, bug_name, name_line_sep, name_width);
    
    // ===== FLAVOR TEXT =====
    draw_set_font(fnt_flavor_text_2x);
    var light_gold = make_color_rgb(255,223,128);
    var flavor_y_offset = card_h * 0.22;
    var flavor_width = card_w * 0.75;
    var flavor_line_sep = 15;
    
    // Flavor text shadow
    draw_set_alpha(0.5 * content_fade_alpha);
    draw_set_color(c_black);
    draw_text_ext(gui_center_x + 4, gui_center_y + flavor_y_offset + 4, flavor_text, flavor_line_sep, flavor_width);
    draw_set_alpha(1);
    
    // Main flavor text
    draw_set_color(light_gold);
    draw_text_ext(gui_center_x, gui_center_y + flavor_y_offset, flavor_text, flavor_line_sep, flavor_width);
    
    // ===== ESSENCE VALUE =====
    draw_set_font(fnt_flavor_text_2x);
    var essence_y_offset = card_h * 0.35;
    var essence_text = "Essence: +" + string(essence_value);
    
    // Essence shadow
    draw_set_alpha(0.5 * content_fade_alpha);
    draw_set_color(c_black);
    draw_text(gui_center_x + 4, gui_center_y + essence_y_offset + 4, essence_text);
    draw_set_alpha(1);
    
    // Main essence text
    draw_set_color(make_color_rgb(255,215,0));
    draw_text(gui_center_x, gui_center_y + essence_y_offset, essence_text);
}

// ===== CLICK TO RETURN INSTRUCTION =====
if (card_state == "displayed") {
    draw_set_font(fnt_card_title_2x);
    var instruction_y = gui_center_y + card_h * 0.45;
    
    // Instruction shadow
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_text(gui_center_x + 3, instruction_y + 3, "Click to return");
    draw_set_alpha(1);
    
    // Main instruction text
    draw_set_color(c_white);
    draw_text(gui_center_x, instruction_y, "Click to return");
}

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);