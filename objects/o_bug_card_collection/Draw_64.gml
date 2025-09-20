// o_bug_card_collection Draw_64 Event - Individual Card Display


// SAFETY: Only draw bug cards when on Collection tab (tab 0)
// Don't draw anything if we're on Items tab (tab 1)
// === TAB FILTERING ===
// SAFETY: Only draw bug cards when on Collection tab (tab 0)

if (o_bug_collection_ui.current_tab != 0) {
    exit; // Stop drawing, we're on Items tab
}

// Get GUI center position with slide animation
var gui_center_x = display_get_gui_width() / 2;
var cam = view_camera[0];
var view_y = camera_get_view_y(cam);
var gui_center_y = (y - view_y) * 2;

// Use same scaling as o_bug_card
var card_scale_x = 1.0;
var card_scale_y = 1.0;
var flip_scale = 1.0; // No flip animation for collection view

// Calculate frame dimensions exactly the same way
var frame_w_gui = sprite_get_width(s_card_template) * card_scale_x * 2; // *2 for GUI scaling
var frame_h_gui = sprite_get_height(s_card_template) * card_scale_y * 2;

// Pixel-perfect positioning
var tl_x = round(gui_center_x - frame_w_gui * 0.5);
var tl_y = round(gui_center_y - frame_h_gui * 0.5);
var cx_gui = tl_x + frame_w_gui * 0.5;
var cy_gui = tl_y + frame_h_gui * 0.5;

// Template scaling
var scale_x_template = (card_scale_x * 2) * flip_scale;
var scale_y_template = (card_scale_y * 2);

// ===== DROP SHADOW =====
var shadow_offset_x = 8;
var shadow_offset_y = 8;
var shadow_alpha = 0.4;

draw_sprite_ext(
    s_card_template, 1, // frame 1 = front
    cx_gui + shadow_offset_x, cy_gui + shadow_offset_y,
    scale_x_template, scale_y_template,
    0, // no rotation
    c_black, shadow_alpha * content_fade_alpha
);

// ===== CARD BACKGROUND =====
draw_sprite_ext(
    s_card_template, 1, // frame 1 = front
    cx_gui, cy_gui,
    scale_x_template, scale_y_template,
    0, // no rotation
    c_white, content_fade_alpha
);

// ===== FRONT CONTENT (only when ready) =====
if (content_ready && content_fade_alpha > 0) {

    // Gem position calculation
    var gem_base_x = cx_gui + (frame_w_gui * 0.32);
    var gem_base_y = cy_gui - (frame_h_gui * 0.38);

    // ===== RARITY GEM =====
    if (gem_pop_scale > 0) {
        var gem_x = gem_base_x;
        var gem_y = gem_base_y;

        draw_sprite_ext(gem_sprite, 0, gem_x, gem_y,
                        2.0 * gem_pop_scale, 2.0 * gem_pop_scale, 0,
                        c_white, content_fade_alpha);
    }

    // ===== COIN (mirrored to upper-left) =====
    if (gem_pop_scale > 0) {
        // Mirror X across the card center, keep Y same as gem's
        var coin_x = (2 * cx_gui) - gem_base_x;
        var coin_y = gem_base_y; // same Y as gem for upper alignment

        draw_sprite_ext(coin_sprite, 0, coin_x, coin_y,
                        2.0 * gem_pop_scale, 2.0 * gem_pop_scale, 0,
                        c_white, content_fade_alpha);

        // Coin number with exact styling
        draw_set_font(fnt_card_title_2x);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        var cream = make_color_rgb(245,235,215);
        var dark_outline = make_color_rgb(25,15,30);
        var nstr = string(coin_value);

        // 8-direction outline
        draw_set_color(dark_outline);
        draw_text(coin_x + 2, coin_y + 2, nstr);
        draw_text(coin_x - 2, coin_y - 2, nstr);
        draw_text(coin_x + 2, coin_y - 2, nstr);
        draw_text(coin_x - 2, coin_y + 2, nstr);
        draw_text(coin_x + 2, coin_y,     nstr);
        draw_text(coin_x - 2, coin_y,     nstr);
        draw_text(coin_x,     coin_y + 2, nstr);
        draw_text(coin_x,     coin_y - 2, nstr);

        draw_set_color(cream);
        draw_text(coin_x, coin_y, nstr);
    }

    // ===== BUILD TEXT SURFACE FOR CONTENT =====
    if (bug_pop_scale > 0) {
        var surf_w = max(1, sprite_get_width(s_card_template) * 2);
        var surf_h = max(1, sprite_get_height(s_card_template) * 2);
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

            // ===== BUG SPRITE =====
            var tgt_bug_h_px = (sprite_get_height(s_card_template) * 0.35) * 2;
            var spr_w = sprite_get_width(bug_sprite);
            var spr_h = sprite_get_height(bug_sprite);
            var bug_scale = min(tgt_bug_h_px / spr_w, tgt_bug_h_px / spr_h) * bug_pop_scale;
            var bug_y_off = -sprite_get_height(s_card_template) * 0.20 * 2;
            
            // Bug shadow
            draw_sprite_ext(bug_sprite, 0, cx + content_shadow_x, cy + bug_y_off + content_shadow_y, 
                           bug_scale, bug_scale, 0, c_black, 0.6 * content_fade_alpha);
            // Bug sprite
            draw_sprite_ext(bug_sprite, 0, cx, cy + bug_y_off, 
                           bug_scale, bug_scale, 0, c_white, content_fade_alpha);

            // ===== BUG NAME =====
            draw_set_font(fnt_card_title_2x);
            var cream = make_color_rgb(245,235,215);
            var dark_purple = make_color_rgb(45, 25, 60);
            var name_y = sprite_get_height(s_card_template) * 0.08 * 2;
            var name_w = (sprite_get_width(s_card_template) - 45) * 2;
            var name_sep = 14 * 2;
            
            var shadow_offset = 4;

            // Semi-transparent name shadow
            draw_set_alpha(0.5 * content_fade_alpha);
            draw_set_color(c_black);
            draw_text_ext(cx + shadow_offset, cy + name_y + shadow_offset, bug_name, name_sep, name_w);
            draw_set_alpha(1);
            
            // 8-direction outline
            draw_set_color(dark_purple);
            draw_text_ext(cx + 2, cy + name_y + 2, bug_name, name_sep, name_w);
            draw_text_ext(cx - 2, cy + name_y - 2, bug_name, name_sep, name_w);
            draw_text_ext(cx + 2, cy + name_y - 2, bug_name, name_sep, name_w);
            draw_text_ext(cx - 2, cy + name_y + 2, bug_name, name_sep, name_w);
            draw_text_ext(cx + 2, cy + name_y, bug_name, name_sep, name_w);
            draw_text_ext(cx - 2, cy + name_y, bug_name, name_sep, name_w);
            draw_text_ext(cx, cy + name_y + 2, bug_name, name_sep, name_w);
            draw_text_ext(cx, cy + name_y - 2, bug_name, name_sep, name_w);
            
            // Main name text
            draw_set_color(cream);
            draw_text_ext(cx, cy + name_y, bug_name, name_sep, name_w);

            // ===== FLAVOR TEXT =====
            draw_set_font(fnt_flavor_text_2x);
            var light_gold = make_color_rgb(255,223,128);
            var flavor_y = sprite_get_height(s_card_template) * 0.28 * 2;
            var txt_w = (sprite_get_width(s_card_template) - 60) * 2;
            var flavor_sep = 12 * 2;

            // 8-direction outline
            draw_set_color(c_black);
            draw_text_ext(cx + 2, cy + flavor_y + 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx - 2, cy + flavor_y - 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx + 2, cy + flavor_y - 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx - 2, cy + flavor_y + 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx + 2, cy + flavor_y, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx - 2, cy + flavor_y, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx, cy + flavor_y + 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx, cy + flavor_y - 2, flavor_text, flavor_sep, txt_w);

            // Main flavor text
            draw_set_color(light_gold);
            draw_text_ext(cx, cy + flavor_y, flavor_text, flavor_sep, txt_w);

            // ===== ESSENCE TEXT =====
            var essence_y = sprite_get_height(s_card_template) * 0.40 * 2;
          var catch_count = get_bug_catch_count(type_id);
			var multiplier = 1.0;
			if (catch_count >= 10) {
			    multiplier = 2.0;
			} else if (catch_count >= 5) {
			    multiplier = 1.5;
			}
			var final_essence = ceil(essence_value * multiplier);
			var essence_text = "Essence: +" + string(final_essence);

			// Add multiplier display
			if (catch_count >= 10) {
			    essence_text += " (x2.0)";
			} else if (catch_count >= 5) {
			    essence_text += " (x1.5)";
			}

            // 8-direction outline
            draw_set_color(c_black);
            draw_text(cx + 2, cy + essence_y + 2, essence_text);
            draw_text(cx - 2, cy + essence_y - 2, essence_text);
            draw_text(cx + 2, cy + essence_y - 2, essence_text);
            draw_text(cx - 2, cy + essence_y + 2, essence_text);
            draw_text(cx + 2, cy + essence_y, essence_text);
            draw_text(cx - 2, cy + essence_y, essence_text);
            draw_text(cx, cy + essence_y + 2, essence_text);
            draw_text(cx, cy + essence_y - 2, essence_text);

            // Main essence text
            draw_set_color(make_color_rgb(255,215,0));
            draw_text(cx, cy + essence_y, essence_text);

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

