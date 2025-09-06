/// o_intro_manager : Draw GUI
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Full black background
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);

// FONT
var use_font = font_exists(fnt_intro_text) ? fnt_intro_text : ui_font;
draw_set_font(use_font);

// ALIGN: center horizontally, top vertically
draw_set_halign(fa_center);
draw_set_valign(fa_top);

// Text layout: centered horizontally, top-anchored at a comfortable Y
var wrap_w = gui_w * 0.8;     // tighten to 80% width
var text_x = gui_w * 0.5;     // center horizontally
var text_y = gui_h * 0.28;    // top anchor (adjust to taste; 0.25–0.35 feels good)

// Apply paragraph fade-in
draw_set_alpha(page_alpha);

// Shadow pass
draw_set_color(shadow_color);
draw_text_ext(text_x + shadow_ofs, text_y + shadow_ofs, current_text, line_spacing, wrap_w);

// Main pass
draw_set_color(text_color);
draw_text_ext(text_x, text_y, current_text, line_spacing, wrap_w);

// Continue prompt (blink) when fully visible
if (global_fade == "show" && page_state == "hold") {
    var show_prompt = (blink_timer div next_blink_interval) mod 2 == 0;
    if (show_prompt) {
        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_set_color(c_white);
        draw_text(gui_w * 0.5, gui_h - margin, continue_hint);
    }
}

// Update blink timer during show
if (global_fade == "show") blink_timer++;

// Screen fade overlay
if (fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

// Reset
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
