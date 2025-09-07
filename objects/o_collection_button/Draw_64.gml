// Don't draw if collection is open
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    exit;
}

// Don't draw if pause menu is active
if (instance_exists(o_pause_menu)) {
    exit;
}


// NEW: Don't draw if ANY NPC dialogue is active (using parent system)
with (o_npc_parent) {
    if (dialogue_active) {
        exit;
    }
}
// [Rest of existing Draw GUI code]
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

var btn_x = gui_width - btn_margin - (btn_sprite_width * base_scale / 2);
var btn_y = gui_height - btn_margin - (btn_sprite_height * base_scale / 2);

var final_scale = base_scale * hover_scale;

if (is_hovered) {
    draw_sprite_ext(s_collection_button, image_index, 
                   btn_x + 2, btn_y + 2, 
                   final_scale, final_scale, 0, c_black, 0.3);
}

draw_sprite_ext(s_collection_button, image_index, 
               btn_x, btn_y, 
               final_scale, final_scale, 0, c_white, 1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);