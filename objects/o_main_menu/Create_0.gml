// o_main_menu Create Event - Main Menu System
menu_active = true;
selected_index = 0;
menu_scale = 0; // Start at zero for entrance animation
target_scale = 1;

// Menu items - following your pause menu pattern
menu_items = [
    {text: "CONTINUE", action: "continue"},
    {text: "NEW GAME", action: "new_game"}, 
    {text: "SETTINGS", action: "settings"},
    {text: "QUIT", action: "quit"}
];

// Visual properties matching your GBA style
menu_width = 300;
menu_height = 200;
item_height = 40; // Slightly taller for main menu

// Animation - same system as pause menu
animation_timer = 0;
entrance_duration = 20; // Slightly longer for main menu entrance

// Check if save data exists for Continue button
has_save_data = false;
// TODO: Check your save system here
// has_save_data = file_exists("savegame.dat") or however you handle saves

// Set appropriate depth
depth = -5000; // High priority but not as high as collection UI

show_debug_message("Main menu created - has_save_data: " + string(has_save_data));