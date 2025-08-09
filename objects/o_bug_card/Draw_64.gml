/// o_bug_card Draw Event

// 1) Early exits
if (card_state == "hidden" || card_state == "waiting") exit;

// 2) World -> GUI
var cam = view_camera[0];
var vx  = camera_get_view_x(cam);
var vy  = camera_get_view_y(cam);

// GUI is 2× the view
var gui_x = (x - vx) * 2;
var gui_y = (y - vy) * 2;

// 3) Card dimensions in GUI space
var frame_w_gui = sprite_get_width(s_card_template)  * card_scale_x * 2;
var frame_h_gui = sprite_get_height(s_card_template) * card_scale_y * 2;

// 4) Pixel-perfect basis (top-left + derived center)
var tl_x  = round(gui_x - frame_w_gui * 0.5);
var tl_y  = round(gui_y - frame_h_gui * 0.5);
var cx_gui = tl_x + frame_w_gui * 0.5;
var cy_gui = tl_y + frame_h_gui * 0.5;

// 5) Flip state (which side + x-scale squash)
var card_frame = 0;           // 0 = back, 1 = front
var show_front_content = false;

if (card_state == "flipping_in") {
    if (flip_progress < 0.5) { card_frame = 0; show_front_content = false; }
    else                      { card_frame = 1; show_front_content = true;  }
} else if (card_state == "showing") {
    card_frame = 1; show_front_content = true;
} else if (card_state == "flipping_out") {
    if (flip_progress < 0.5) { card_frame = 1; show_front_content = true;  }
    else                      { card_frame = 0; show_front_content = false; }
}

var flip_t = clamp(flip_progress, 0, 1);
var flip_scale = (card_state == "flipping_in" || card_state == "flipping_out")
    ? abs(dcos(flip_t * 180)) : 1;

// template is 1x art drawn into 2x GUI
var scale_x_template = (card_scale_x * 2) * flip_scale;
var scale_y_template = (card_scale_y * 2);

// surface is already 2x, so no extra *2
var scale_x_surface = (card_scale_x) * flip_scale;
var scale_y_surface = (card_scale_y);

// ----------------- CARD BACKGROUND -----------------
draw_sprite_ext(
    s_card_template, card_frame,
    cx_gui, cy_gui,
    scale_x_template, scale_y_template,
    card_rotation,
    c_white, image_alpha
);

// ----------------- FRONT CONTENT (only when front is showing) -----------------
if (show_front_content) {
    // ---- RARITY GEM ----
    var gem_x = cx_gui + (frame_w_gui * 0.32) - (frame_w_gui * 0.5); // offset from center basis
    var gem_y = cy_gui - (frame_h_gui * 0.38) - (frame_h_gui * 0.0); // stays centered vertically

    // Put gem in card space (center-based):
    gem_x = cx_gui + (frame_w_gui * 0.32) - (frame_w_gui * 0.5);
    gem_y = cy_gui - (frame_h_gui * 0.38) - 0;

    if (bug_rarity_tier <= 2) {
        gem_glow_timer += 0.15;
        var glow_alpha = 0.3 + (sin(gem_glow_timer) * 0.2);
        var glow_color = (bug_rarity_tier == 1) ? make_color_rgb(255, 100, 255) : make_color_rgb(255, 100, 100);

        draw_set_alpha(glow_alpha);
        draw_sprite_ext(gem_sprite, 0, gem_x, gem_y, 2.4, 2.4, 0, glow_color, 1);
        draw_set_alpha(1);
    }
    draw_sprite_ext(gem_sprite, 0, gem_x, gem_y, 2.0, 2.0, 0, c_white, image_alpha);

    // ---- Build 2× text surface ----
    var surf_w = max(1, sprite_get_width(s_card_template)  * 2);
    var surf_h = max(1, sprite_get_height(s_card_template) * 2);
    var text_surf = surface_create(surf_w, surf_h);

    if (surface_exists(text_surf)) {
        surface_set_target(text_surf);
        draw_clear_alpha(c_black, 0);

        var cx = surf_w * 0.5;
        var cy = surf_h * 0.5;

        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        // ---- BUG SPRITE ----
        var tgt_bug_h_px = (sprite_get_height(s_card_template) * 0.35) * 2;
        var spr_w = sprite_get_width(bug_sprite);
        var spr_h = sprite_get_height(bug_sprite);
        var bug_scale = min(tgt_bug_h_px / spr_w, tgt_bug_h_px / spr_h) * bug_bounce_scale;
        var bug_y_off = -sprite_get_height(s_card_template) * 0.20 * 2;
        draw_sprite_ext(bug_sprite, 0, cx, cy + bug_y_off, bug_scale, bug_scale, 0, c_white, image_alpha);

        // ---- NAME ----
        draw_set_font(fnt_card_title_2x);
        var cream   = make_color_rgb(245,235,215);
        var outline = make_color_rgb(45,25,60);
        var name_y  = sprite_get_height(s_card_template) * 0.08 * 2;
        var name_w  = (sprite_get_width(s_card_template) - 45) * 2;
        var name_sep = 14 * 2;

        draw_set_color(outline);
        draw_text_ext(cx + 2, cy + name_y + 2, bug_name, name_sep, name_w);
        draw_text_ext(cx - 2, cy + name_y - 2, bug_name, name_sep, name_w);
        draw_text_ext(cx + 2, cy + name_y - 2, bug_name, name_sep, name_w);
        draw_text_ext(cx - 2, cy + name_y + 2, bug_name, name_sep, name_w);

        draw_set_color(cream);
        draw_text_ext(cx, cy + name_y, bug_name, name_sep, name_w);

        // ---- FLAVOR ----
        draw_set_font(fnt_flavor_text_2x);
        var light_gold = make_color_rgb(255,223,128);
        var flavor_y = sprite_get_height(s_card_template) * 0.28 * 2;
        var txt_w    = (sprite_get_width(s_card_template) - 60) * 2;
        var flavor_sep = 12 * 2;

        draw_set_color(c_black);
        draw_text_ext(cx + 2, cy + flavor_y + 2, flavor_text, flavor_sep, txt_w);
        draw_text_ext(cx - 2, cy + flavor_y - 2, flavor_text, flavor_sep, txt_w);

        draw_set_color(light_gold);
        draw_text_ext(cx, cy + flavor_y, flavor_text, flavor_sep, txt_w);

        // ---- ESSENCE ----
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

        // ---- Draw surface ONCE (after creation) ----
        draw_surface_ext(
            text_surf,
            tl_x, tl_y,
            scale_x_surface, scale_y_surface,
            card_rotation,
            c_white, image_alpha
        );

        surface_free(text_surf);
    }
}
