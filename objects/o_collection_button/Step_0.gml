// Don't process hover/input when collection is open (PRESERVED ORIGINAL LOGIC)
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// NEW: Don't process hover/input when pause menu is active
if (instance_exists(o_pause_menu)) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// NEW: Don't process hover/input when any dialogue is active
if (instance_exists(o_ghost_raven_ow) && o_ghost_raven_ow.dialogue_active) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// Also check for other dialogue systems (Baba Yaga, etc.)
if (instance_exists(o_babayaga) && o_babayaga.dialogue_active) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// Also check for ghost raven manager dialogue (intro scene)
if (instance_exists(o_ghost_raven_manager) && o_ghost_raven_manager.dialogue_active) {
    is_hovered = false;
    hover_scale = lerp(hover_scale, 1.0, 0.1);
    exit;
}

// SAFETY: Get GUI mouse coordinates for proper detection
var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Calculate actual position to match Draw event exactly
var btn_x = gui_width - btn_margin - (btn_sprite_width * base_scale / 2);
var btn_y = gui_height - btn_margin - (btn_sprite_height * base_scale / 2);

// Calculate button bounds for hover detection
var button_width = btn_sprite_width * base_scale;
var button_height = btn_sprite_height * base_scale;

// Check if mouse is within button bounds
is_hovered = (mouse_gui_x >= btn_x - button_width/2 && 
              mouse_gui_x <= btn_x + button_width/2 && 
              mouse_gui_y >= btn_y - button_height/2 && 
              mouse_gui_y <= btn_y + button_height/2);

// Smooth hover animation
if (is_hovered) {
    hover_scale = lerp(hover_scale, 1.1, 0.1);
} else {
    hover_scale = lerp(hover_scale, 1.0, 0.1);
}

// Handle clicks in GUI space
if (mouse_check_button_pressed(mb_left) && is_hovered) {
    // Toggle collection menu
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