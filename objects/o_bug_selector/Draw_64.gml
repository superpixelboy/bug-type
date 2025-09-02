// o_bug_selector - Enhanced Draw GUI Event with Multi-Mode Display
if (menu_active) {
    // Larger window to accommodate new features
    var window_w = 600;
    var window_h = 350;
    var window_x = (display_get_gui_width() - window_w) / 2;
    var window_y = (display_get_gui_height() - window_h) / 2;
    
    // Semi-transparent background
    draw_set_alpha(0.9);
    draw_set_color(c_black);
    draw_rectangle(window_x, window_y, window_x + window_w, window_y + window_h, false);
    draw_set_alpha(1);
    
    // Menu border (GBA style)
    draw_set_color(c_white);
    draw_rectangle(window_x, window_y, window_x + window_w, window_y + window_h, true);
    draw_rectangle(window_x + 2, window_y + 2, window_x + window_w - 2, window_y + window_h - 2, true);
    
    // Title with current essence
    draw_set_font(-1);
    draw_set_color(c_yellow);
    draw_set_halign(fa_center);
    draw_text(window_x + window_w/2, window_y + 10, "F1 DEBUG CONSOLE - Essence: " + string(global.essence));
    
    // Mode tabs
    var tab_width = window_w / 3;
    var tab_y = window_y + 30;
    
    // Draw mode tabs
    for (var i = 0; i < 3; i++) {
        var tab_x = window_x + (i * tab_width);
        var tab_names = ["BUG SELECT", "ESSENCE", "AUTO-UNLOCK"];
        var tab_modes = ["bugs", "essence", "auto_unlock"];
        var is_active = (console_mode == tab_modes[i]);
        
        // Tab background
        draw_set_color(is_active ? c_blue : c_dkgray);
        draw_rectangle(tab_x + 5, tab_y, tab_x + tab_width - 5, tab_y + 25, false);
        
        // Tab border
        draw_set_color(c_white);
        draw_rectangle(tab_x + 5, tab_y, tab_x + tab_width - 5, tab_y + 25, true);
        
        // Tab text
        draw_set_color(is_active ? c_white : c_ltgray);
        draw_set_halign(fa_center);
        draw_text(tab_x + tab_width/2, tab_y + 5, tab_names[i]);
    }
    
    // Content area
    var content_y = tab_y + 35;
    var content_h = window_h - 85; // Leave space for instructions
    
    // ===== MODE-SPECIFIC CONTENT =====
    
    if (console_mode == "bugs") {
        // Original bug selection functionality
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_text(window_x + 10, content_y, "Select bug to force spawn from next rock:");
        
        var start_index = max(0, selected_index - bugs_per_page + 1);
        start_index = min(start_index, max(0, array_length(bug_list) - bugs_per_page));
        
        for (var i = 0; i < min(bugs_per_page, array_length(bug_list)); i++) {
            var list_index = start_index + i;
            if (list_index >= array_length(bug_list)) break;
            
            var item_y = content_y + 25 + (i * 22);
            var bug = bug_list[list_index];
            
            // Highlight selected
            if (list_index == selected_index) {
                draw_set_color(c_blue);
                draw_rectangle(window_x + 8, item_y - 2, window_x + window_w - 8, item_y + 18, false);
            }
            
            draw_set_color(c_white);
            draw_text(window_x + 15, item_y, bug.name + " (Essence: " + string(bug.essence) + ")");
        }
        
    } else if (console_mode == "essence") {
        // Essence adjustment mode
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_text(window_x + 10, content_y, "Current Essence: " + string(global.essence));
        
        // Input field
        var input_y = content_y + 25;
        draw_text(window_x + 10, input_y, "Set Essence:");
        
        // Input box
        var box_x = window_x + 120;
        var box_w = 120;
        var box_h = 20;
        
        draw_set_color(input_active ? c_white : c_gray);
        draw_rectangle(box_x, input_y - 2, box_x + box_w, input_y + box_h, true);
        
        if (input_active) {
            draw_set_color(c_ltgray);
            draw_rectangle(box_x + 1, input_y - 1, box_x + box_w - 1, input_y + box_h - 1, false);
        }
        
        // Input text with cursor
        draw_set_color(c_black);
        var display_text = essence_input_value;
        if (input_active && input_blink_timer < 30) {
            display_text += "_";
        }
        draw_text(box_x + 5, input_y, display_text);
        
        // Quick preset buttons
        draw_set_color(c_white);
        draw_text(window_x + 10, input_y + 35, "Quick Presets:");
        draw_text(window_x + 10, input_y + 55, "[1] 100   [2] 500   [3] 1K   [4] 5K   [5] 10K");
        
    } else if (console_mode == "auto_unlock") {
        // Auto-unlock mode
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_text(window_x + 10, content_y, "Instantly unlock bugs to your collection:");
        
        // Bug selection
        if (array_length(bug_list) > 0) {
            var bug = bug_list[selected_bug_for_unlock];
            var current_count = get_bug_catch_count(bug.id);
            var is_discovered = ds_map_exists(global.discovered_bugs, bug.id);
            
            draw_text(window_x + 10, content_y + 25, "Bug: " + bug.name);
            
            // Show current status
            var status_color = is_discovered ? c_lime : c_yellow;
            draw_set_color(status_color);
            var status_text = is_discovered ? ("Already caught " + string(current_count) + " times") : "Not yet discovered";
            draw_text(window_x + 10, content_y + 45, "Status: " + status_text);
            
            // Small selection indicator
            draw_set_color(c_yellow);
            draw_text(window_x - 5 + 10, content_y + 25, ">");
            draw_set_color(c_white);
            
            // Count input
            draw_text(window_x + 10, content_y + 70, "Add Count: " + unlock_count_input + " (max 99)");
            
            // Show essence calculation
            if (unlock_count_input != "" && real(unlock_count_input) > 0) {
                var unlock_amount = min(real(unlock_count_input), 99);
                var essence_gained = bug.essence * unlock_amount;
                draw_set_color(c_aqua);
                draw_text(window_x + 10, content_y + 90, "Will give: " + string(essence_gained) + " essence");
                draw_set_color(c_white);
            }
            
            // Instructions
            draw_text(window_x + 10, content_y + 115, "↑↓: Select Bug   ENTER: Add to Collection");
        }
    }
    
    // ===== BOTTOM INSTRUCTIONS =====
    var instr_y = window_y + window_h - 40;
    draw_set_color(c_ltgray);
    draw_set_halign(fa_center);
    
    if (input_active) {
        draw_text(window_x + window_w/2, instr_y, "Type numbers, ENTER to confirm, ESC to cancel");
    } else {
        draw_text(window_x + window_w/2, instr_y, "Q/E: Switch Modes   ENTER: Select/Action   ESC/F1: Close");
        draw_text(window_x + window_w/2, instr_y + 15, "1-5: Quick Essence Presets");
    }
    
    // Reset draw settings
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}