// Hide during collection menu AND bug card display
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    exit; // Don't draw when collection menu is open
}

// ALSO hide when bug card is showing (final catch phase)
if (instance_exists(o_bug_card)) {
    exit; // Don't draw during bug card display
}

// Keep hidden once bug is ready to catch - clicking anywhere works at that point
if (instance_exists(o_bug_parent)) {
    with(o_bug_parent) {
        if (state == "ready_to_catch" || state == "capturing" || state == "caught") {
            other.should_hide = true;
        }
    }
    if (should_hide) {
        should_hide = false; // Reset for next frame
        exit; // Stay hidden - clicking anywhere works now
    }
}

// Draw the escape button (available until bug is ready to catch)

// Calculate GUI position - LOWER LEFT corner, moved right
var gui_x = gui_x_offset;  // Distance from left edge (now 120px)
var gui_y = display_get_gui_height() - gui_y_offset;  // Distance from bottom

// Calculate final scale (base scale + hover effect)
var final_scale = base_scale * hover_scale;

// Optional: Drop shadow for depth
if (is_hovered) {
    draw_sprite_ext(sprite_index, image_index, gui_x + 2, gui_y + 2, 
                   final_scale, final_scale, 0, c_black, 0.3);
}

// Draw the main button sprite in GUI space
draw_sprite_ext(sprite_index, image_index, gui_x, gui_y, 
               final_scale, final_scale, 0, c_white, 1);