// SAFETY: Completely replacing old rectangle drawing with sprite-based rendering

// Don't draw if collection is open (PRESERVED ORIGINAL LOGIC)
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    exit;
}

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Don't draw if collection is open (PRESERVED ORIGINAL LOGIC)
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    exit;
}

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Calculate sprite center position to match hitbox exactly
var btn_x = gui_width - btn_margin - (btn_sprite_width * base_scale / 2);
var btn_y = gui_height - btn_margin - (btn_sprite_height * base_scale / 2);

var final_scale = base_scale * hover_scale;

// Optional: Add a subtle drop shadow for depth when hovered
if (is_hovered) {
    draw_sprite_ext(s_collection_button, image_index, 
                   btn_x + 2, btn_y + 2, 
                   final_scale, final_scale, 0, c_black, 0.3);
}

// Draw the main collection button sprite (now with Middle Centre origin!)
draw_sprite_ext(s_collection_button, image_index, 
               btn_x, btn_y, 
               final_scale, final_scale, 0, c_white, 1);

// SAFETY: Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);

// SAFETY: Reset draw settings to prevent interference with other draw calls
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);