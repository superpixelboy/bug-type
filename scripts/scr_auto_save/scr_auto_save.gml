/// @description scr_auto_save - Auto-save game progress
function scr_auto_save() {
    // Add a brief visual indicator of saving
    if (instance_exists(o_UI_Manager)) {
        // Could set a "saving..." indicator here
    }
    
    // Save the game
    var save_successful = scr_save_game();
    
    if (save_successful) {
        show_debug_message("Auto-save successful");
        // Could show a brief "Game Saved" message
    } else {
        show_debug_message("Auto-save failed!");
        // Could show error to player
    }
    
    return save_successful;
}