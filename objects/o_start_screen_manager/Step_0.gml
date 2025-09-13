// o_start_screen_manager Step Event - ENHANCED WITH UNIFIED INPUT
// SAFETY: This replaces direct keyboard checks with unified input manager calls

// STEP 1: Update input manager (call this first thing every frame)
scr_update_input_manager();

// Move clouds slowly across the screen (unchanged)
cloud_x_offset += cloud_speed;

// NEW ENHANCED TITLE FADE SYSTEM (unchanged)
// First, handle the delay before title starts fading
if (!title_started_fading) {
    title_fade_timer++;
    if (title_fade_timer >= title_fade_delay) {
        title_started_fading = true;
    }
} else {
    // Now handle the actual title fade (only after delay)
    if (title_alpha < 1) {
        title_alpha += title_fade_speed;
        if (title_alpha >= 1) {
            title_alpha = 1;
            title_fully_visible = true;
            // Start menu fade when title is done
            menu_should_start_fading = true;
        }
    }
}

// NEW MENU FADE SYSTEM (unchanged)
// Only start fading menu after title is complete
if (menu_should_start_fading && menu_alpha < 1) {
    menu_alpha += menu_fade_speed;
    if (menu_alpha >= 1) {
        menu_alpha = 1;
    }
}

// ===== ENHANCED MENU NAVIGATION WITH UNIFIED INPUT =====
// Menu navigation (only after menu is visible AND title is done)
if (title_fully_visible && menu_alpha > 0.8 && menu_active) {
    
    // REPLACED: Direct keyboard checks with unified input manager
    // OLD: var move_up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
    // OLD: var move_down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
    // OLD: var confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
    
    // NEW: Use unified input system (supports WASD, arrows, controller)
    var move_up = input_get_menu_up_pressed();
    var move_down = input_get_menu_down_pressed();
    var confirm = input_get_menu_select_pressed();
    
    // ===== MOUSE HOVER DETECTION =====
    // NEW: Add mouse hover support for menu items
    var mouse_gui_x = device_mouse_x_to_gui(0);
    var mouse_gui_y = device_mouse_y_to_gui(0);
    
    // Calculate menu item positions (same as Draw event)
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var gui_scale = 2;
    var menu_start_y = gui_h * 0.67;
    var menu_spacing = 25 * gui_scale;
    var title_x = gui_w / 2;
    
    // Check mouse hover over menu items
    var mouse_over_item = -1;
    for (var i = 0; i < array_length(menu_items); i++) {
        var item = menu_items[i];
        if (!item.enabled) continue; // Skip disabled items
        
        var item_y = menu_start_y + (i * menu_spacing);
        
        // Get text dimensions for hover detection
        if (font_exists(fnt_flavor_text_2x)) {
            draw_set_font(fnt_flavor_text_2x);
        }
        var text_width = string_width(item.text) * gui_scale;
        var text_height = string_height(item.text) * gui_scale;
        
        // Check if mouse is over this menu item
        if (mouse_gui_x >= title_x - text_width/2 && 
            mouse_gui_x <= title_x + text_width/2 &&
            mouse_gui_y >= item_y - text_height/2 && 
            mouse_gui_y <= item_y + text_height/2) {
            mouse_over_item = i;
            break;
        }
    }
    
    // Update selection based on mouse hover
    if (mouse_over_item != -1 && mouse_over_item != selected_index) {
        selected_index = mouse_over_item;
        // Optional: Play hover sound
        // audio_play_sound(sn_bugtap1, 1, false);
    }
    
    // ===== KEYBOARD/CONTROLLER NAVIGATION =====
    if (move_up) {
        // Find previous enabled item
        var new_index = selected_index;
        do {
            new_index--;
            if (new_index < 0) new_index = array_length(menu_items) - 1;
        } until (menu_items[new_index].enabled || new_index == selected_index);
        
        if (new_index != selected_index) {
            selected_index = new_index;
            audio_play_sound(sn_bugtap1, 1, false);
        }
    }
    
    if (move_down) {
        // Find next enabled item
        var new_index = selected_index;
        do {
            new_index++;
            if (new_index >= array_length(menu_items)) new_index = 0;
        } until (menu_items[new_index].enabled || new_index == selected_index);
        
        if (new_index != selected_index) {
            selected_index = new_index;
            audio_play_sound(sn_bugtap1, 1, false);
        }
    }
    
    // ===== MENU SELECTION =====
    // Handle selection with mouse click OR keyboard/controller
    var mouse_clicked = false;
    if (mouse_over_item == selected_index) {
        mouse_clicked = mouse_check_button_pressed(mb_left);
    }
    
    if (confirm || mouse_clicked) {
        var selected_item = menu_items[selected_index];
        if (selected_item.enabled) {
            // Play selection sound
            audio_play_sound(sn_bugtap1, 1, false);
            
            // Handle menu actions
            switch(selected_item.action) {
                case "continue":
                    show_debug_message("Loading saved game...");
                    if (scr_load_game()) {
                        show_debug_message("Save loaded successfully!");
                        room_goto(rm_spooky_forest);
                    } else {
                        show_debug_message("ERROR: Failed to load save!");
                        // Could show error message to player here
                    }
                    break;
                    
                case "new_game":
                    show_debug_message("Starting new game...");
                    scr_initialize_new_game();
                    room_goto(rm_backstory);
                    break;
                    
                case "settings":
                    show_debug_message("Settings menu - placeholder");
                    // Toggle fullscreen as a placeholder settings action
                    if (window_get_fullscreen()) {
                        window_set_fullscreen(false);
                    } else {
                        window_set_fullscreen(true);
                    }
                    break;
                    
                case "quit":
                    show_debug_message("Quitting game...");
                    game_end();
                    break;
                    
                default:
                    show_debug_message("Unknown menu action: " + selected_item.action);
                    break;
            }
        }
    }
    
    // ===== DEBUG INFO =====
    // Show current input method for debugging
    if (global.input_manager.controller_connected) {
        var controller_slot = global.input_manager.controller_slot;
        show_debug_message("Controller connected in slot: " + string(controller_slot));
    }
}