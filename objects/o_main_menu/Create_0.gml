// o_main_menu Create Event - SAFE VERSION WITH DEBUG
show_debug_message("=== MAIN MENU STARTING UP ===");

menu_active = true;
selected_index = 0;
menu_scale = 0; // Start at zero for entrance animation
target_scale = 1;

// Menu items - matching your pause menu pattern
menu_items = [
    {text: "NEW GAME", action: "new_game"}, 
    {text: "CONTINUE", action: "continue"},
    {text: "SETTINGS", action: "settings"},
    {text: "QUIT", action: "quit"}
];

show_debug_message("Menu items created: " + string(array_length(menu_items)));

// Visual properties matching your GBA style
menu_width = 300;
menu_height = 200;
item_height = 40;

// Animation - same system as pause menu
animation_timer = 0;
entrance_duration = 20;

// Check if save data exists for Continue button
has_save_data = false;
// TODO: Replace with your actual save check
// has_save_data = file_exists("your_save_file.dat");

// Set depth high priority for main menu
depth = -5000;

show_debug_message("Main menu created successfully!");
show_debug_message("Has save data: " + string(has_save_data));
show_debug_message("Depth set to: " + string(depth));