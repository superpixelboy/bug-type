// REPLACE both Step Event and Draw GUI Event for o_collection_button

// ===== STEP EVENT =====
// Don't process hover/input when collection is open (PRESERVED ORIGINAL LOGIC)
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// Don't process hover/input when pause menu is active
if (instance_exists(o_pause_menu)) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// UNIVERSAL: Don't process hover/input when ANY NPC dialogue is active
var npc_list = [o_ghost_raven_ow, o_babayaga, o_ghost_raven_manager];  // Add any new NPCs here
for (var i = 0; i < array_length(npc_list); i++) {
    var npc_type = npc_list[i];
    if (instance_exists(npc_type)) {
        var npc_instance = instance_find(npc_type, 0);
        if (npc_instance != noone && variable_instance_exists(npc_instance, "dialogue_active") && npc_instance.dialogue_active) {
            is_hovered = false;
            hover_scale = lerp(hover_scale, 1.0, 0.1);
            exit;
        }
    }
}

// [Rest of existing Step Event code - mouse detection, clicks, etc.]
var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

var btn_x = gui_width - btn_margin - (btn_sprite_width * base_scale / 2);
var btn_y = gui_height - btn_margin - (btn_sprite_height * base_scale / 2);

var button_width = btn_sprite_width * base_scale;
var button_height = btn_sprite_height * base_scale;

is_hovered = (mouse_gui_x >= btn_x - button_width/2 && 
              mouse_gui_x <= btn_x + button_width/2 && 
              mouse_gui_y >= btn_y - button_height/2 && 
              mouse_gui_y <= btn_y + button_height/2);

if (is_hovered) {
    hover_scale = lerp(hover_scale, 1.1, 0.1);
} else {
    hover_scale = lerp(hover_scale, 1.0, 0.1);
}

if (mouse_check_button_pressed(mb_left) && is_hovered) {
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui != noone) {
        collection_ui.is_open = !collection_ui.is_open;
        if (collection_ui.is_open) {
            collection_ui.page = 0;
        }
        collection_ui.detail_view_open = false;
        collection_ui.detail_bug_key = "";
        collection_ui.detail_bug_data = {};
        collection_ui.hovered_card = -1;
        collection_ui.hover_timer = 0;
    }
    
    audio_play_sound(sn_bugtap1, 1, false);
}

// ===== DRAW GUI EVENT =====
// Don't draw if collection is open
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    exit;
}

// Don't draw if pause menu is active
if (instance_exists(o_pause_menu)) {
    exit;
}

// UNIVERSAL: Don't draw if ANY NPC dialogue is active
var npc_list = [o_ghost_raven_ow, o_babayaga, o_ghost_raven_manager];
for (var i = 0; i < array_length(npc_list); i++) {
    var npc_type = npc_list[i];
    if (instance_exists(npc_type)) {
        var npc_instance = instance_find(npc_type, 0);
        if (npc_instance != noone && variable_instance_exists(npc_instance, "dialogue_active") && npc_instance.dialogue_active) {
            exit;
        }
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