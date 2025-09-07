// o_collection_button Step Event
// UPDATED: Works with new NPC parent system + Input cooldown

// Reduce global input cooldown
if (variable_global_exists("input_cooldown") && global.input_cooldown > 0) {
    global.input_cooldown--;
}

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

// NEW: Don't process hover/input when ANY NPC dialogue is active (using parent system)
with (o_npc_parent) {
    if (dialogue_active) {
        other.is_hovered = false;
        other.hover_scale = lerp(other.hover_scale, 1.0, 0.1);
        exit;
    }
}

// Don't process input during global cooldown
var input_blocked = (variable_global_exists("input_cooldown") && global.input_cooldown > 0);
if (input_blocked) {
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