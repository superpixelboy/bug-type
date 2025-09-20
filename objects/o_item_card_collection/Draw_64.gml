// o_item_card_collection Draw GUI Event - Individual Item Card Display

// === TAB FILTERING ===
// Only draw item cards when on Items tab (tab 1)
if (instance_exists(o_bug_collection_ui)) {
    if (o_bug_collection_ui.current_tab != 1) {
        exit; // Stop drawing if we're on Collection tab
    }
}

// Get GUI center position
var gui_center_x = display_get_gui_width() / 2;
var gui_center_y = display_get_gui_height() / 2;

// Card scaling (same as bug cards)
var card_scale_x = 1.0 * card_pop_scale;
var card_scale_y = 1.0 * card_pop_scale;

// Calculate frame dimensions
var frame_w_gui = sprite_get_width(s_item_card) * card_scale_x * 2; // *2 for GUI scaling
var frame_h_gui = sprite_get_height(s_item_card) * card_scale_y * 2;

// Pixel-perfect positioning
var tl_x = round(gui_center_x - frame_w_gui * 0.5);
var tl_y = round(gui_center_y - frame_h_gui * 0.5);
var cx_gui = tl_x + frame_w_gui * 0.5;
var cy_gui = tl_y + frame_h_gui * 0.5;

// Template scaling
var scale_x_template = (card_scale_x * 2);
var scale_y_template = (card_scale_y * 2);

// ===== DROP SHADOW =====
var shadow_offset_x = 8;
var shadow_offset_y = 8;
var shadow_alpha = 0.4;

draw_sprite_ext(
    s_item_card, 0,
    cx_gui + shadow_offset_x, cy_gui + shadow_offset_y,
    scale_x_template, scale_y_template,
    0, c_black, shadow_alpha * content_fade_alpha
);

// ===== CARD BACKGROUND =====
draw_sprite_ext(
    s_item_card, 0,
    cx_gui, cy_gui,
    scale_x_template, scale_y_template,
    0, c_white, content_fade_alpha
);

// ===== FRONT CONTENT (only when ready) =====
if (content_ready && content_fade_alpha > 0) {

    // ===== BUILD TEXT SURFACE FOR CONTENT =====
    if (item_pop_scale > 0) {
        var surf_w = max(1, sprite_get_width(s_item_card) * 2);
        var surf_h = max(1, sprite_get_height(s_item_card) * 2);
        var text_surf = surface_create(surf_w, surf_h);

        if (surface_exists(text_surf)) {
            surface_set_target(text_surf);
            draw_clear_alpha(c_black, 0);

            var cx = surf_w * 0.5;
            var cy = surf_h * 0.5;
            
            // Shadow offset for all content
            var content_shadow_x = 3;
            var content_shadow_y = 3;

            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);

            // ===== ITEM SPRITE =====
            var tgt_item_h_px = (sprite_get_height(s_item_card) * 0.40) * 2; // Larger for items
            var spr_w = sprite_get_width(item_sprite);
            var spr_h = sprite_get_height(item_sprite);
            var item_scale = min(tgt_item_h_px / spr_w, tgt_item_h_px / spr_h) * item_pop_scale;
            var item_y_off = -sprite_get_height(s_item_card) * 0.15 * 2; // Higher up
            
            // Item shadow
            draw_sprite_ext(item_sprite, 0, cx + content_shadow_x, cy + item_y_off + content_shadow_y, 
                           item_scale, item_scale, 0, c_black, 0.6 * content_fade_alpha);
            // Item sprite
            draw_sprite_ext(item_sprite, 0, cx, cy + item_y_off, 
                           item_scale, item_scale, 0, c_white, content_fade_alpha);

            // ===== ITEM NAME =====
            draw_set_font(fnt_card_title_2x);
            var cream = make_color_rgb(245,235,215);
            var dark_purple = make_color_rgb(45, 25, 60);
            var name_y = sprite_get_height(s_item_card) * 0.12 * 2; // Below item
            var name_w = (sprite_get_width(s_item_card) - 45) * 2;
            var name_sep = 14 * 2;
            
            var shadow_offset = 4;

            // Semi-transparent name shadow
            draw_set_alpha(0.5 * content_fade_alpha);
            draw_set_color(c_black);
            draw_text_ext(cx + shadow_offset, cy + name_y + shadow_offset, item_name, name_sep, name_w);
            draw_set_alpha(1);
            
            // 8-direction outline
            draw_set_color(dark_purple);
            draw_text_ext(cx + 2, cy + name_y + 2, item_name, name_sep, name_w);
            draw_text_ext(cx - 2, cy + name_y - 2, item_name, name_sep, name_w);
            draw_text_ext(cx + 2, cy + name_y - 2, item_name, name_sep, name_w);
            draw_text_ext(cx - 2, cy + name_y + 2, item_name, name_sep, name_w);
            draw_text_ext(cx + 2, cy + name_y, item_name, name_sep, name_w);
            draw_text_ext(cx - 2, cy + name_y, item_name, name_sep, name_w);
            draw_text_ext(cx, cy + name_y + 2, item_name, name_sep, name_w);
            draw_text_ext(cx, cy + name_y - 2, item_name, name_sep, name_w);
            
            // Main name text
            draw_set_color(cream);
            draw_text_ext(cx, cy + name_y, item_name, name_sep, name_w);

            // ===== ITEM DESCRIPTION =====
            draw_set_font(fnt_flavor_text_2x);
            var light_gold = make_color_rgb(255,223,128);
            var desc_y = sprite_get_height(s_item_card) * 0.30 * 2; // Below name
            var txt_w = (sprite_get_width(s_item_card) - 60) * 2;
            var desc_sep = 12 * 2;

            // 8-direction outline
            draw_set_color(c_black);
            draw_text_ext(cx + 2, cy + desc_y + 2, item_description, desc_sep, txt_w);
            draw_text_ext(cx - 2, cy + desc_y - 2, item_description, desc_sep, txt_w);
            draw_text_ext(cx + 2, cy + desc_y - 2, item_description, desc_sep, txt_w);
            draw_text_ext(cx - 2, cy + desc_y + 2, item_description, desc_sep, txt_w);
            draw_text_ext(cx + 2, cy + desc_y, item_description, desc_sep, txt_w);
            draw_text_ext(cx - 2, cy + desc_y, item_description, desc_sep, txt_w);
            draw_text_ext(cx, cy + desc_y + 2, item_description, desc_sep, txt_w);
            draw_text_ext(cx, cy + desc_y - 2, item_description, desc_sep, txt_w);

            // Main description text
            draw_set_color(light_gold);
            draw_text_ext(cx, cy + desc_y, item_description, desc_sep, txt_w);

            surface_reset_target();

            // Draw the text surface
            draw_surface_ext(text_surf, tl_x, tl_y, 1, 1, 0, c_white, content_fade_alpha);
            surface_free(text_surf);
        }
    }
}

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_font(-1);