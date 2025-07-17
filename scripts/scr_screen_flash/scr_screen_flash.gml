/// @description Create a screen flash effect
function scr_screen_flash() {
    // Create flash effect in UI Manager
    with (o_UI_Manager) {
        flash_alpha = 0.8;        // Start bright
        flash_duration = 15;      // Flash for 15 frames (quarter second)
        flash_timer = 0;
    }
}