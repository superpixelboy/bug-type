// o_bug_collection_ui - Enhanced Draw GUI Event with EXACT Card Matching
// REMOVED: Collection button drawing - let o_collection_button handle it

// Only draw collection panel when open
if (!is_open) {
    exit;
}

// Draw the book background (centered on screen)
var screen_center_x = (480 / 2) * gui_scale;
var screen_center_y = (270 / 2) * gui_scale;
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

// Define grid layout
var cards_per_row = 4;
var rows = 2;
var cards_per_page_grid = cards_per_row * rows; // 8 cards per page
var total_pages = ceil(total_bugs / cards_per_page_grid);

// Draw cards in 2 rows of 4 (8 cards per page)
var start_bug = page * cards_per_page_grid;

// Calculate grid positioning
var grid_start_x = ui_width * 0.2; // Start further from left edge
var grid_start_y = ui_height * 0.25; // Start from upper portion
var card_spacing_x = (ui_width * 0.6) / (cards_per_row - 1); // Spread across 60% of width
var card_spacing_y = ui_height * 0.35; // Vertical spacing between rows

for (var i = 0; i < cards_per_page_grid; i++) {
    var bug_index = start_bug + i;
    if (bug_index >= total_bugs) break;
    
    // Calculate row and column
    var row = floor(i / cards_per_row);
    var col = i % cards_per_row;
    
    // Calculate card position
    var card_x = (grid_start_x + (col * card_spacing_x)) * gui_scale;
    var card_y_pos = (grid_start_y + (row * card_spacing_y)) * gui_scale;
    
    // Add wiggle effect if this card is hovered and within duration
    var wiggle_x = 0;
    var wiggle_y = 0;
    if (hovered_card == i && hover_timer < wiggle_duration) {
        // Create a fade-out effect as the wiggle duration ends
        var wiggle_strength = 1 - (hover_timer / wiggle_duration);
        wiggle_x = sin(hover_timer) * wiggle_amount * wiggle_strength;
        wiggle_y = cos(hover_timer * 1.3) * wiggle_amount * 0.5 * wiggle_strength;
    }
    
    card_x += wiggle_x;
    card_y_pos += wiggle_y;
    
    // Get bug data using the bug key
    var bug_key = all_bug_keys[bug_index];
    var bug_data = global.bug_data[$ bug_key];
    
    // Check if discovered using the bug_key
    var is_discovered = ds_map_exists(global.discovered_bugs, bug_key);
    
    if (is_discovered) {
        // SIMPLER APPROACH - Scale everything together properly
        var collection_scale = 0.4; // Overall scale for collection view
        
        // 1. Draw card background first
        draw_sprite_ext(s_card_template, 1, card_x, card_y_pos, 
                       collection_scale * gui_scale, collection_scale * gui_scale, 0, c_white, 1);
        
        // 2. Calculate scaled card dimensions for positioning
        var card_w_scaled = sprite_get_width(s_card_template) * collection_scale * gui_scale;
        var card_h_scaled = sprite_get_height(s_card_template) * collection_scale * gui_scale;
        
        // 3. Position everything relative to card center
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        // ---- BUG SPRITE ----
        // Scale the bug to fit proportionally (same as catch screen logic but scaled)
        var target_bug_size = card_h_scaled * 0.35; // Same proportion as catch screen
        var bug_w = sprite_get_width(bug_data.sprite);
        var bug_h = sprite_get_height(bug_data.sprite);
        var bug_scale = min(target_bug_size / bug_w, target_bug_size / bug_h);
        var bug_y_offset = card_h_scaled * -0.20; // Same proportion as catch screen
        
        // Draw bug shadow
        draw_sprite_ext(bug_data.sprite, 0, card_x + 2, card_y_pos + bug_y_offset + 2, 
                       bug_scale, bug_scale, 0, c_black, 0.6);
        // Draw bug
        draw_sprite_ext(bug_data.sprite, 0, card_x, card_y_pos + bug_y_offset, 
                       bug_scale, bug_scale, 0, c_white, 1);
        
        // ---- BUG NAME ----
        // Use regular fonts for smaller text
        draw_set_font(fnt_card_title);
        var cream = make_color_rgb(245,235,215);
        var dark_purple = make_color_rgb(45, 25, 60);
        var name_y_offset = card_h_scaled * 0.08; // Same proportion as catch screen
        var name_width = card_w_scaled * 0.8; // 80% of card width
        var name_line_sep = 7 * collection_scale * gui_scale; // Scale line separation (half of original)
        
        // Shadow
        draw_set_alpha(0.5);
        draw_set_color(c_black);
        draw_text_ext(card_x + 2, card_y_pos + name_y_offset + 2, bug_data.name, name_line_sep, name_width);
        draw_set_alpha(1);
        
        // Outline
        draw_set_color(dark_purple);
        draw_text_ext(card_x + 1, card_y_pos + name_y_offset + 1, bug_data.name, name_line_sep, name_width);
        draw_text_ext(card_x - 1, card_y_pos + name_y_offset - 1, bug_data.name, name_line_sep, name_width);
        draw_text_ext(card_x + 1, card_y_pos + name_y_offset - 1, bug_data.name, name_line_sep, name_width);
        draw_text_ext(card_x - 1, card_y_pos + name_y_offset + 1, bug_data.name, name_line_sep, name_width);
        
        // Main text
        draw_set_color(cream);
        draw_text_ext(card_x, card_y_pos + name_y_offset, bug_data.name, name_line_sep, name_width);
        
        // ---- FLAVOR TEXT ----
        draw_set_font(fnt_flavor_text);
        var light_gold = make_color_rgb(255,223,128);
        var flavor_y_offset = card_h_scaled * 0.28; // Same proportion as catch screen
        var flavor_width = card_w_scaled * 0.65; // 65% of card width (tighter)
        var flavor_line_sep = 10 * collection_scale * gui_scale; // Good spacing for readability
        
        // Outline
        draw_set_color(c_black);
        draw_text_ext(card_x + 1, card_y_pos + flavor_y_offset + 1, bug_data.flavor_text, flavor_line_sep, flavor_width);
        draw_text_ext(card_x - 1, card_y_pos + flavor_y_offset - 1, bug_data.flavor_text, flavor_line_sep, flavor_width);
        draw_text_ext(card_x + 1, card_y_pos + flavor_y_offset - 1, bug_data.flavor_text, flavor_line_sep, flavor_width);
        draw_text_ext(card_x - 1, card_y_pos + flavor_y_offset + 1, bug_data.flavor_text, flavor_line_sep, flavor_width);
        
        // Main text
        draw_set_color(light_gold);
        draw_text_ext(card_x, card_y_pos + flavor_y_offset, bug_data.flavor_text, flavor_line_sep, flavor_width);
        
        // ---- ESSENCE TEXT ----
        draw_set_font(fnt_flavor_text);
        var essence_y_offset = card_h_scaled * 0.40; // Same proportion as catch screen
        var essence_text = "Essence: +" + string(bug_data.essence);
        
        // Outline
        draw_set_color(c_black);
        draw_text(card_x + 1, card_y_pos + essence_y_offset + 1, essence_text);
        draw_text(card_x - 1, card_y_pos + essence_y_offset - 1, essence_text);
        draw_text(card_x + 1, card_y_pos + essence_y_offset - 1, essence_text);
        draw_text(card_x - 1, card_y_pos + essence_y_offset + 1, essence_text);
        
        // Main text
        draw_set_color(make_color_rgb(255,215,0));
        draw_text(card_x, card_y_pos + essence_y_offset, essence_text);
        
        // 5. Draw gems and coins OVER the card
        var card_w_scaled = sprite_get_width(s_card_template) * collection_scale * gui_scale;
        var card_h_scaled = sprite_get_height(s_card_template) * collection_scale * gui_scale;
        
        // Gem (upper right)
        var gem_x = card_x + (card_w_scaled * 0.32);
        var gem_y = card_y_pos - (card_h_scaled * 0.38);
        var gem_rarity = scr_gem_rarity(bug_key);
        var gem_sprite = get_gem_sprite(gem_rarity);
        draw_sprite_ext(gem_sprite, 0, gem_x, gem_y, 
                       collection_scale * gui_scale, collection_scale * gui_scale, 0, c_white, 1);
        
        // Coin (upper left)
        var coin_x = card_x - (card_w_scaled * 0.32);
        var coin_y = card_y_pos - (card_h_scaled * 0.38);
        var coin_value = (bug_index % 15) + 1;
        var coin_sprite = s_coin_copper;
        if (coin_value > 9) coin_sprite = s_coin_gold;
        else if (coin_value > 4) coin_sprite = s_coin_silver;
        
        draw_sprite_ext(coin_sprite, 0, coin_x, coin_y, 
                       collection_scale * gui_scale, collection_scale * gui_scale, 0, c_white, 1);
        
        // Coin number
        draw_set_font(fnt_card_title);  // Use smaller font for collection
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        var cream = make_color_rgb(245,235,215);
        var dark_outline = make_color_rgb(25,15,30);
        var nstr = string(coin_value);
        
        // Outline (scaled down)
        draw_set_color(dark_outline);
        draw_text(coin_x + 0.5, coin_y + 0.5, nstr);
        draw_text(coin_x - 0.5, coin_y - 0.5, nstr);
        draw_text(coin_x + 0.5, coin_y - 0.5, nstr);
        draw_text(coin_x - 0.5, coin_y + 0.5, nstr);
        
        // Main text
        draw_set_color(cream);
        draw_text(coin_x, coin_y, nstr);
        
    } else {
        // Draw card back with bug silhouette
        draw_sprite_ext(s_card_template, 0, card_x, card_y_pos, 
                       0.4 * gui_scale, 0.4 * gui_scale, 0, c_white, 1);
        
        // Draw bug silhouette
        var bug_sprite = bug_data.sprite;
        draw_sprite_ext(bug_sprite, 0, card_x, card_y_pos - (15 * gui_scale), 
                       0.3 * gui_scale, 0.3 * gui_scale, 0, c_black, 0.75);
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
        draw_text(60 * gui_scale, (ui_height/2) * gui_scale, "<");
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

draw_set_color(c_ltgray);
draw_rectangle(close_x, close_y, close_x + close_size, close_y + close_size, false);
draw_set_color(c_black);
draw_rectangle(close_x, close_y, close_x + close_size, close_y + close_size, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_font(fnt_card_title_2x);
draw_text(close_x + close_size/2, close_y + close_size/2, "X");

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);