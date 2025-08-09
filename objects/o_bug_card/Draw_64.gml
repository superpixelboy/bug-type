if (card_state == "hidden" || card_state == "waiting") exit;
if (!(card_state == "showing" || (card_state == "flipping_in" && flip_progress > 0.5))) exit;

// --- convert world (x,y) to GUI coords (assumes camera 0) ---
var cam = view_camera[0];
var vx = camera_get_view_x(cam);
var vy = camera_get_view_y(cam);

// GUI is 2× the view, so multiply by 2
var gui_x = (x - vx) * 2;
var gui_y = (y - vy) * 2;

// Card dimensions in GUI pixels (because GUI is 2×)
var frame_w_gui = sprite_get_width(s_card_template)  * card_scale_x * 2;
var frame_h_gui = sprite_get_height(s_card_template) * card_scale_y * 2;

// --- build a 2× surface exactly the size of the unscaled card frame ---
var surf_w = max(1, sprite_get_width(s_card_template)  * 2);
var surf_h = max(1, sprite_get_height(s_card_template) * 2);
var text_surf = surface_create(surf_w, surf_h);

// In o_bug_card Draw_64 Event, add this AFTER the main card surface is drawn:
// Draw rarity gem in upper right corner
if (card_state == "showing" || (card_state == "flipping_in" && flip_progress > 0.5)) {
    var gem_x = gui_x + (frame_w_gui * 0.85);
    var gem_y = gui_y + (frame_h_gui * 0.15);
    
    gem_float_timer += 0.1;
    var float_offset = sin(gem_float_timer) * 2;
    
    // Glow effect for rare gems
    if (bug_rarity_tier <= 2) {
        gem_glow_timer += 0.15;
        var glow_alpha = 0.3 + (sin(gem_glow_timer) * 0.2);
        var glow_color = (bug_rarity_tier == 1) ? make_color_rgb(255, 100, 255) : make_color_rgb(255, 100, 100);
        
        draw_set_alpha(glow_alpha);
        draw_sprite_ext(gem_sprite, 0, gem_x, gem_y + float_offset, 1.2, 1.2, 0, glow_color, 1);
        draw_set_alpha(1);
    }
    
    // Draw main gem
    draw_sprite_ext(gem_sprite, 0, gem_x, gem_y + float_offset, 1.0, 1.0, 0, c_white, image_alpha);
}
if (surface_exists(text_surf)) {
    surface_set_target(text_surf);
    draw_clear_alpha(c_black, 0);

    var cx = surf_w * 0.5;
    var cy = surf_h * 0.5;

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // --------- BUG SPRITE (rendered at 2×) ----------
    // size relative to the card so it “tracks” scale nicely
    var tgt_bug_h_px = (sprite_get_height(s_card_template) * 0.35) * 2;
    var spr_w = sprite_get_width(bug_sprite);
    var spr_h = sprite_get_height(bug_sprite);
    var bug_scale = min(tgt_bug_h_px / spr_w, tgt_bug_h_px / spr_h) * bug_bounce_scale;
    var bug_y_off = -sprite_get_height(s_card_template) * 0.20 * 2;
    draw_sprite_ext(bug_sprite, 0, cx, cy + bug_y_off, bug_scale, bug_scale, 0, c_white, image_alpha);

    // --------- BUG NAME (use actual 2× font assets) ----------
    draw_set_font(fnt_card_title_2x);
    var cream = make_color_rgb(245,235,215);
    var outline = make_color_rgb(45,25,60);
    var name_y = sprite_get_height(s_card_template) * 0.08 * 2;
    var name_w = (sprite_get_width(s_card_template) - 45) * 2;
    var name_sep = 14 * 2;

    draw_set_color(outline);
    draw_text_ext(cx + 2, cy + name_y + 2, bug_name, name_sep, name_w);
    draw_text_ext(cx - 2, cy + name_y - 2, bug_name, name_sep, name_w);
    draw_text_ext(cx + 2, cy + name_y - 2, bug_name, name_sep, name_w);
    draw_text_ext(cx - 2, cy + name_y + 2, bug_name, name_sep, name_w);

    draw_set_color(cream);
    draw_text_ext(cx, cy + name_y, bug_name, name_sep, name_w);

    // --------- FLAVOR TEXT ----------
    draw_set_font(fnt_flavor_text_2x);
    var light_gold = make_color_rgb(255,223,128);
    var flavor_y = sprite_get_height(s_card_template) * 0.28 * 2;
    var txt_w = (sprite_get_width(s_card_template) - 60) * 2;
    var flavor_sep = 12 * 2;

    draw_set_color(c_black);
    draw_text_ext(cx + 2, cy + flavor_y + 2, flavor_text, flavor_sep, txt_w);
    draw_text_ext(cx - 2, cy + flavor_y - 2, flavor_text, flavor_sep, txt_w);

    draw_set_color(light_gold);
    draw_text_ext(cx, cy + flavor_y, flavor_text, flavor_sep, txt_w);

    // --------- ESSENCE ----------
    draw_set_font(fnt_flavor_text);
    var essence_y = sprite_get_height(s_card_template) * 0.40 * 2;
    var essence_text = "Essence: +" + string(essence_value);

    draw_set_color(c_black);
    draw_text(cx + 2, cy + essence_y + 2, essence_text);
    draw_text(cx - 2, cy + essence_y - 2, essence_text);
    draw_text(cx + 2, cy + essence_y - 2, essence_text);
    draw_text(cx - 2, cy + essence_y + 2, essence_text);

    draw_set_color(make_color_rgb(255,215,0));
    draw_text(cx, cy + essence_y, essence_text);

    surface_reset_target();

    // ---- draw surface into GUI with card scale + rotation ----
    // Position top-left in GUI space, rounding for pixel-perfect alignment
    var draw_w_gui = frame_w_gui; // already includes 2× and card_scale
    var draw_h_gui = frame_h_gui;

    var tl_x = round(gui_x - draw_w_gui * 0.5);
    var tl_y = round(gui_y - draw_h_gui * 0.5);

    // Since surface is 2×, we scale by 0.5 * card_scale * (GUI scale 2×) == card_scale
    // but we already baked GUI 2× into draw_w_gui/draw_h_gui above,
    // so just use 0.5 * card_scale here to preserve crispness.
    draw_surface_ext(
        text_surf,
        tl_x, tl_y,
        0.5 * card_scale_x * 2,   // == card_scale_x
        0.5 * card_scale_y * 2,   // == card_scale_y
        card_rotation,
        c_white, image_alpha
    );

    surface_free(text_surf);
}
