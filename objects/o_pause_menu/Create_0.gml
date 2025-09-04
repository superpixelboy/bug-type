// o_pause_menu Create Event - MATCH COLLECTION UI DEPTH EXACTLY
menu_active = true;
selected_index = 0;
menu_scale = 0; // Start at zero scale for entrance animation
target_scale = 1;

// Menu items
menu_items = [
    {text: "RESUME", action: "resume"},
    {text: "SAVE GAME", action: "save"}, // <- ADD THIS LINE
    {text: "BUG COLLECTION", action: "collection"},
    {text: "SETTINGS", action: "settings"},
    {text: "MAIN MENU", action: "main_menu"},
	{text: "QUIT", action: "quit"}
];


// Visual properties matching your GBA style
menu_width = 300;
menu_height = 250;
item_height = 35;

// Animation
animation_timer = 0; // Start animation from beginning
entrance_duration = 15; // frames

// Set up global pause flag
global.game_paused = true;

// CRITICAL: Use EXACT same depth as collection UI
depth = -10000;  // Exactly the same as collection UI

show_debug_message("Pause menu created - depth: " + string(depth) + " - game_paused: " + string(global.game_paused));