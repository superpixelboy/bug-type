// o_bug_collection_ui - Draw GUI Event with New Sprites and Polish Effects

// Only draw collection panel when open
if (!is_open) {
    exit;
}

// Draw the book background (centered on screen)
var screen_center_x = (480 / 2) * gui_scale;
var screen_center_y = (270 / 2) * gui_scale;
var book_scale = gui_scale * .5;  // Half scale since sprite is double resolution
draw_sprite_ext(s_collection_page, 0, screen_center_x, screen_center_y, book_scale, book_scale, 0, c_white, 1);

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

// Calculate grid positioning - MICRO ADJUSTMENTS
var left_page_center = ui_width * 0.31;   // Move left columns slightly left
var right_page_center = ui_width * 0.69;  // Move right columns slightly right
var grid_start_y = ui_height * 0.30;      // Move all cards down a fraction
var card_spacing_y = ui_height * 0.36;    // Vertical gap between rows

// Calculate horizontal spacing for 2 cards per page
var horizontal_spread = ui_width * 0.15;

// Draw each card using ORIGINAL positioning logic
for (var i = 0; i < cards_per_page_grid; i++) {
    var bug_index = start_bug + i;
    if (bug_index >= total_bugs) break;
    
    // Calculate row and column
    var row = floor(i / cards_per_row);
    var col = i % cards_per_row;
    
    // Calculate card position based on which page (left/right) - ORIGINAL LOGIC
    var card_x, card_y_pos;
    
    if (col < 2) {
        // Left page (columns 0 and 1)
        var local_col = col; // 0 or 1
        card_x = (left_page_center + ((local_col - 0.5) * horizontal_spread)) * gui_scale;
    } else {
        // Right page (columns 2 and 3)
        var local_col = col - 2; // 0 or 1 (relative to right page)
        card_x = (right_page_center + ((local_col - 0.5) * horizontal_spread)) * gui_scale;
    }
    
    card_y_pos = (grid_start_y + (row * card_spacing_y)) * gui_scale;

    // Get bug data using the bug key
    var bug_key = all_bug_keys[bug_index];
    var bug_data = global.bug_data[$ bug_key];
    // Check if discovered using the bug_key
    var is_discovered = ds_map_exists(global.discovered_bugs, bug_key);
    
    // Calculate hover scale with smooth animation
    var hover_scale = 1.0;
    var hover_offset_y = 0;
    if (hovered_card == i && hover_timer > 0) {
        var hover_progress = hover_timer / 20.0; // Smooth 0-1 progress
        hover_scale = lerp(1.0, 1.1, hover_progress); // 10% larger when hovered
        hover_offset_y = lerp(0, -3, hover_progress); // Slight float up
    }
    var final_collection_scale = 0.4 * hover_scale; // Base scale * hover effect
    card_y_pos += hover_offset_y; // Apply hover float
    if (ds_map_exists(global.discovered_bugs, bug_key)) {
        // Draw drop shadow for discovered cards (enhanced for hovered cards)
        var shadow_alpha = 0.3;
        var shadow_offset = 2;
        if (hovered_card == i) {
            shadow_alpha = 0.5; // Stronger shadow when hovered
            shadow_offset = 3;   // Larger shadow when hovered
        }
        
        draw_set_alpha(shadow_alpha);
        draw_set_color(c_black);
        draw_sprite_ext(s_card_template, 1, // Use frame 1 (front) for discovered cards shadow
                       card_x + shadow_offset, card_y_pos + shadow_offset, 
                       final_collection_scale * gui_scale, final_collection_scale * gui_scale, 
                       0, c_black, 1);
        draw_set_alpha(1);
        draw_set_color(c_white);
        
        // Draw the main card (frame 1 = front)
        draw_sprite_ext(s_card_template, 1, card_x, card_y_pos, // Use frame 1 (front) for discovered cards
                       final_collection_scale * gui_scale, final_collection_scale * gui_scale, 0, c_white, 1);
        
        // Calculate scaled card dimensions for positioning
        var card_w_scaled = sprite_get_width(s_card_template) * final_collection_scale * gui_scale;
        var card_h_scaled = sprite_get_height(s_card_template) * final_collection_scale * gui_scale;
        
        // Draw bug sprite on card (scaled and positioned)
        var target_bug_size = card_h_scaled * 0.35;
        var bug_w = sprite_get_width(bug_data.sprite);
        var bug_h = sprite_get_height(bug_data.sprite);
        var bug_scale = min(target_bug_size / bug_w, target_bug_size / bug_h);
        var bug_y_offset = card_h_scaled * -0.20;
        
        draw_sprite_ext(bug_data.sprite, 0, card_x, card_y_pos + bug_y_offset, 
                       bug_scale, bug_scale, 0, c_white, 1);
        
        // Draw gems and coins OVER the card (scaled with hover)
        // Gem (upper right)
        var gem_x = card_x + (card_w_scaled * 0.32);
        var gem_y = card_y_pos - (card_h_scaled * 0.38);
        var gem_rarity = scr_gem_rarity(bug_key);
        var gem_sprite = get_gem_sprite(gem_rarity);
        draw_sprite_ext(gem_sprite, 0, gem_x, gem_y, 
                       final_collection_scale * gui_scale, final_collection_scale * gui_scale, 0, c_white, 1);
        
        // Coin (upper left)
        var coin_x = card_x - (card_w_scaled * 0.32);
        var coin_y = card_y_pos - (card_h_scaled * 0.38);
        var coin_value = (bug_index % 15) + 1;
        var coin_sprite = s_coin_copper;
        if (coin_value > 9) coin_sprite = s_coin_gold;
        else if (coin_value > 4) coin_sprite = s_coin_silver;
        
        draw_sprite_ext(coin_sprite, 0, coin_x, coin_y, 
                       final_collection_scale * gui_scale, final_collection_scale * gui_scale, 0, c_white, 1);
        
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
        
        // ---- BUG NAME ----
        // Use regular fonts for smaller text
        draw_set_font(fnt_card_title);
        var cream = make_color_rgb(245,235,215);
        var dark_purple = make_color_rgb(45, 25, 60);
        var name_y_offset = card_h_scaled * 0.08; // Same proportion as catch screen
        var name_width = card_w_scaled * 0.8; // 80% of card width
        var name_line_sep = 7 * final_collection_scale * gui_scale; // Scale line separation with hover
        
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
        var flavor_line_sep = 10 * final_collection_scale * gui_scale; // Scale with hover
        
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
        
    } else {
        // Draw card back with bug silhouette (no shadow for undiscovered)
        draw_sprite_ext(s_card_template, 0, card_x, card_y_pos, 
                       0.4 * gui_scale, 0.4 * gui_scale, 0, c_white, 1);
        
        // Draw bug silhouette
        var bug_sprite = bug_data.sprite;
        draw_sprite_ext(bug_sprite, 0, card_x, card_y_pos - (15 * gui_scale), 
                       0.3 * gui_scale, 0.3 * gui_scale, 0, c_black, 0.75);
    }
}

// Page navigation text - FIXED VERSION
if (total_pages > 1) {
    // SAFETY: Explicitly reset ALL draw states before drawing page text
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);        // CRITICAL: Reset vertical alignment 
    draw_set_font(fnt_card_title_2x);
    draw_set_color(make_color_rgb(58, 28, 16));
    draw_set_alpha(.65);
    
    // Draw the page text with consistent positioning
    draw_text(((ui_width/2) * gui_scale)-8, (ui_height - 48) * gui_scale,
              "Page " + string(page + 1) + "/" + string(total_pages));
              
    // SAFETY: Reset draw states after page text
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// Instructions
/*
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(101, 67, 33));
draw_set_font(fnt_flavor_text_2x);
draw_text((ui_width/2) * gui_scale, (ui_height - 25) * gui_scale,
          "TAB: Close  ←→: Navigate");*/

// Draw navigation arrows with NEW SPRITES and animations
if (total_pages > 1) {
    var arrow_scale = gui_scale * 0.8; // Scale for the carrot sprites (keep them big)
    
    // Left arrow (flipped carrot) - move UP to align with book's middle line
    if (page > 0) {
        var left_arrow_x = 60 * gui_scale;
        var left_arrow_y = screen_center_y - (20 * gui_scale); // Move UP by 20 pixels
        
        // Add gentle movement animation
        var animated_x = left_arrow_x + arrow_hover_offset;
        
        // Drop shadow
        var shadow_alpha = button_hover_states.left_arrow ? 0.6 : 0.3;
        draw_sprite_ext(s_carrot, 0, animated_x + 2, left_arrow_y + 2, 
                       -arrow_scale, arrow_scale, 0, c_black, shadow_alpha);
        
        // Main sprite (flipped horizontally for left arrow)
        var arrow_color = button_hover_states.left_arrow ? c_ltgray : c_white;
        draw_sprite_ext(s_carrot, 0, animated_x, left_arrow_y, 
                       -arrow_scale, arrow_scale, 0, arrow_color, 1);
    }
    
    // Right arrow (normal carrot) - move UP to align with book's middle line
    if (page < total_pages - 1) {
        var right_arrow_x = (ui_width - 60) * gui_scale; // 60 pixels from right edge
        var right_arrow_y = screen_center_y - (20 * gui_scale); // Move UP by 20 pixels (same as left)
        
        // Add gentle movement animation (opposite direction)
        var animated_x = right_arrow_x - arrow_hover_offset;
        
        // Drop shadow
        var shadow_alpha = button_hover_states.right_arrow ? 0.6 : 0.3;
        draw_sprite_ext(s_carrot, 0, animated_x - 2, right_arrow_y + 2, 
                       arrow_scale, arrow_scale, 0, c_black, shadow_alpha);
        
        // Main sprite
        var arrow_color = button_hover_states.right_arrow ? c_ltgray : c_white;
        draw_sprite_ext(s_carrot, 0, animated_x, right_arrow_y, 
                       arrow_scale, arrow_scale, 0, arrow_color, 1);
    }
}

// Draw close button with NEW SPRITE - FIXED scale to be half the size
var close_x = (ui_width - 64) * gui_scale; // Move LEFT (was -40, now -60)
var close_y = 12 * gui_scale; // Move UP (was 20, now 10)
var close_scale = gui_scale * 0.50; // Half the size (was 0.5, now 0.25)

// Drop shadow for close button
var close_shadow_alpha = button_hover_states.close_button ? 0.6 : 0.3;
draw_sprite_ext(s_book_x, 0, close_x - 2, close_y + 2, 
               close_scale, close_scale, 0, c_black, close_shadow_alpha);

// Main close button sprite
var close_color = button_hover_states.close_button ? c_ltgray : c_white;
draw_sprite_ext(s_book_x, 0, close_x, close_y, 
               close_scale, close_scale, 0, close_color, 1);

// Reset draw settings at the VERY END to ensure clean state
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_font(-1);

// If a collection card is showing, draw dark overlay OVER everything we just drew
if (instance_exists(o_bug_card_collection)) {
    draw_set_alpha(0.6); // Dark overlay
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}