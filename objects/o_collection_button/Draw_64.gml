// Don't draw if collection is open
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    exit;
}

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Bottom right corner
var btn_x = gui_width - btn_width - btn_margin;
var btn_y = gui_height - btn_height - btn_margin;

// Draw button background
draw_set_color(c_ltgray);
draw_rectangle(btn_x, btn_y, btn_x + btn_width, btn_y + btn_height, false);
draw_set_color(c_black);
draw_rectangle(btn_x, btn_y, btn_x + btn_width, btn_y + btn_height, true);

// Draw button text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_text(btn_x + btn_width/2, btn_y + btn_height/2, "Collection");

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);