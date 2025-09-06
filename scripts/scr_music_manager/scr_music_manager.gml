// ===========================================
// Music Manager System - scr_music_manager
// ===========================================


// Toggle music on/off
function scr_music_toggle() {
    global.music_enabled = !global.music_enabled;
    
    if (!global.music_enabled) {
        scr_music_stop();
    }
    
    return global.music_enabled;
}
