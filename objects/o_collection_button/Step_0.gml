// SAFETY: Preserving all original click logic, adding sprite hover effects

// Don't process hover when collection is open
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    is_hovered = false;
    hover_scale = 1.0;
    image_index = 0;
    exit;
}

// Get GUI mouse coordinates for proper hover detection
var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Calculate sprite position - FIXED positioning to match actual sprite center
var btn_x = gui_width - btn_margin - (btn_sprite_width * base_scale / 2);
var btn_y = gui_height - btn_margin - (btn_sprite_height * base_scale / 2);

// REFINED: Make hitbox skinnier to match the book shape better
var current_scale = base_scale * hover_scale;
var half_width = (btn_sprite_width * current_scale * 0.8) / 2;  // 20% narrower
var half_height = (btn_sprite_height * current_scale * 0.9) / 2; // 10% shorter

is_hovered = (mouse_gui_x >= btn_x - half_width && 
              mouse_gui_x <= btn_x + half_width && 
              mouse_gui_y >= btn_y - half_height && 
              mouse_gui_y <= btn_y + half_height);

// Update sprite frame and scale based on hover
if (is_hovered) {
    image_index = 1; // Assume frame 1 is hover/lit state
    hover_scale = lerp(hover_scale, 1.05, 0.15); // Gentle scale up
} else {
    image_index = 0; // Normal state
    hover_scale = lerp(hover_scale, 1.0, 0.15); // Scale back to normal
}

// SAFETY: Keeping exact original click logic
if (mouse_check_button_pressed(mb_left)) {
    // Check if click is on button using the same hover bounds
    if (is_hovered) {
        // Find and toggle the collection (ORIGINAL LOGIC PRESERVED)
        var collection_ui = instance_find(o_bug_collection_ui, 0);
        if (collection_ui != noone) {
            // Toggle the collection
            collection_ui.is_open = !collection_ui.is_open;
            
            // Reset states when opening OR closing
            if (collection_ui.is_open) {
                // Opening - reset to first page
                collection_ui.page = 0;
            }
            
            // Always reset these when toggling
            collection_ui.detail_view_open = false;
            collection_ui.detail_bug_key = "";
            collection_ui.detail_bug_data = {};
            collection_ui.hovered_card = -1;
            collection_ui.hover_timer = 0;
        }
        
        // Add click sound feedback
        audio_play_sound(sn_rock_click, 1, false);
    }
}