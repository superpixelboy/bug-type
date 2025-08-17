/// o_bug_card - Destroy Event - FIXED
// Clean up high-res viewport when card is destroyed
if (variable_instance_exists(id, "high_res_viewport")) {
    view_visible[high_res_viewport] = false;
}

// CRITICAL: Reset the global flag so new cards can be created
global.showing_card = false;
show_debug_message("o_bug_card destroyed - reset showing_card = false");