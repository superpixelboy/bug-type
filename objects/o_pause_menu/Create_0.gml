// o_pause_menu Create Event - SIMPLE VERSION
menu_active = true;
selected_index = 0;
menu_scale = 0; // Start scaled down for entrance animation
target_scale = 1;

// Menu items
menu_items = [
    {text: "RESUME", action: "resume"},
    {text: "COLLECTION", action: "collection"}, 
    {text: "SETTINGS", action: "settings"},
    {text: "MAIN MENU", action: "main_menu"},
    {text: "QUIT GAME", action: "quit"}
];

// Visual properties matching your GBA style
menu_width = 300;
menu_height = 250;
item_height = 35;

// Animation
animation_timer = 0;
entrance_duration = 15; // frames

// Set up global pause flag instead of deactivating instances
global.game_paused = true;

depth = -20000; // Draw on top of everything

show_debug_message("Pause menu created - game_paused set to true");