
// UI state
is_open = false;
page = 0;
bugs_per_page = 4;  // 2x2 grid - very spacious
total_bugs = 10;    // Updated for 10 Spooky Woods bugs
total_pages = ceil(total_bugs / bugs_per_page);

// UI positioning
ui_x = 40;
ui_y = 20;
ui_width = 400;
ui_height = 230;

// Updated bug names for Spooky Woods collection
bug_names = [
    "Shadow Beetle",      // 0
    "Moss Grub",         // 1
    "Bark Crawler",      // 2
    "Whisper Weevil",    // 3
    "Glade Hopper",      // 4
    "Gloom Mite",        // 5
    "Moonlight Moth",    // 6
    "Ember Wasp",        // 7
    "Centipede",         // 8
    "Ancient Shell-Back" // 9
];

// Map bug sprites to collection indexes
bug_sprites = [
    s_bug_shadow_beetle,     // 0
    s_bug_moss_grub,        // 1
    s_bug_bark_crawler,     // 2
    s_bug_whisper_weevil,   // 3
    s_bug_glade_hopper,     // 4
    s_bug_gloom_might,      // 5
    s_bug_moonlight_moth,   // 6
    s_bug_ember_wasp,       // 7
    s_bug_centimpede,        // 8
    s_bug_ancient_shell_back // 9
];

// Track discovered bugs
if (!variable_global_exists("discovered_bugs")) {
    global.discovered_bugs = ds_map_create();
}