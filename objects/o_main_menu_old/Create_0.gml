// o_start_screen_manager Create Event
// This manages the layered start screen with moving clouds and enhanced fade animations

// Cloud movement
cloud_x_offset = 0;
cloud_speed = 0.1; // Even slower, more peaceful movement

// ENHANCED TITLE FADE ANIMATION SYSTEM
title_alpha = 0;
title_fade_speed = 0.008; // Keep same fade speed
title_fully_visible = false;

// NEW: Delay before title starts fading (half second = 30 frames at 60fps)
title_fade_delay = 120; // Half second delay
title_fade_timer = 0;  // Track delay time
title_started_fading = false;

// NEW: Menu fade animation system
menu_alpha = 0;
menu_fade_speed = 0.025; // Slightly faster than title for nice effect
menu_should_start_fading = false;

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