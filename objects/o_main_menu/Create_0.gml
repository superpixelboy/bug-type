// ===========================================
// o_main_menu Create Event - WITH MUSIC INTEGRATION
// ===========================================

// Your existing main menu code
show_debug_message("=== MAIN MENU STARTING UP ===");

menu_active = true;
selected_index = 0;
menu_scale = 0; // Start at zero for entrance animation
target_scale = 1;

// FIXED: Actually check if save data exists using our save system
has_save_data = scr_has_save_data();
show_debug_message("Save file check result: " + string(has_save_data));

// Menu items - Continue is enabled/disabled based on actual save data
menu_items = [
    {text: "NEW GAME", action: "new_game", enabled: true}, 
    {text: "CONTINUE", action: "continue", enabled: has_save_data},
    {text: "SETTINGS", action: "settings", enabled: true},
    {text: "QUIT", action: "quit", enabled: true}
];

// Visual properties matching your GBA style
menu_width = 300;
menu_height = 200;
item_height = 40;

// Animation - same system as pause menu
animation_timer = 0;
entrance_duration = 20;

// Set depth high priority for main menu
depth = -5000;

// NEW: Start menu music
scr_music_play_menu();

show_debug_message("Main menu created successfully!");
show_debug_message("Has save data: " + string(has_save_data));
show_debug_message("Depth set to: " + string(depth));


// DEBUG: Press M to manually test music
if (keyboard_check_pressed(ord("M"))) {
    show_debug_message("=== MANUAL MUSIC TEST ===");
    scr_music_play("menu");
}

// DEBUG: Press N to stop music
if (keyboard_check_pressed(ord("N"))) {
    show_debug_message("=== STOPPING MUSIC ===");
    if (global.current_music != noone) {
        audio_stop_sound(global.current_music);
        global.current_music = noone;
        global.target_music = noone;
    }
}

// DEBUG: Press V to test volume
if (keyboard_check_pressed(ord("V"))) {
    show_debug_message("=== MUSIC STATUS ===");
    show_debug_message("Music enabled: " + string(global.music_enabled));
    show_debug_message("Current music: " + (global.current_music == noone ? "none" : string(global.current_music)));
    show_debug_message("Target music: " + (global.target_music == noone ? "none" : audio_get_name(global.target_music)));
    show_debug_message("Volume: " + string(global.music_volume));
    if (global.current_music != noone) {
        show_debug_message("Is playing: " + string(audio_is_playing(global.current_music)));
        show_debug_message("Current gain: " + string(audio_sound_get_gain(global.current_music)));
    }
}