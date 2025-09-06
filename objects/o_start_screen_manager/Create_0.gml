// o_start_screen_manager Create Event
// This manages the layered start screen with moving clouds and fade-in title

// Cloud movement
cloud_x_offset = 0;
cloud_speed = 0.1; // Even slower, more peaceful movement

// Title fade animation
title_alpha = 0;
title_fade_speed = 0.008; // Very slow fade in
title_fully_visible = false;

// FIXED: Actually check if save data exists using our save system
has_save_data = scr_has_save_data();
show_debug_message("Save file check result: " + string(has_save_data));

// Menu items (same as your current system)
menu_items = [
    {text: "CONTINUE", action: "continue", enabled: has_save_data},
    {text: "NEW GAME", action: "new_game", enabled: true}, 
    {text: "SETTINGS", action: "settings", enabled: true},
    {text: "QUIT", action: "quit", enabled: true}
];


selected_index = 0;
menu_active = true;

