// o_fade_controller Create Event (Enhanced)

fade_alpha = 0;
fade_state = "none";
fade_speed = 0.03; // Default speed - can be overridden
action_to_perform = "";

// Position saving for sleep functionality
saved_player_x = 0;
saved_player_y = 0;

// NEW: Room transition support
target_room = -1;
room_transition_type = "normal"; // "normal", "intro", "menu"

// NEW: Auto-detect room entry fades
// If this fade controller is created for room entry, auto-configure
if (fade_state == "none") {
    // Check if we should auto-start a room entry fade
    // This can be set by the object that creates the fade controller
}

// NEW: Support for different fade speeds based on context
function set_fade_context(context) {
    switch(context) {
        case "intro":
        case "menu":
            fade_speed = 0.02; // Slower for dramatic effect
            break;
        case "room_entry":
            fade_speed = 0.04; // Faster for gameplay
            break;
        case "sleep":
            fade_speed = 0.03; // Medium speed
            break;
        case "quick":
            fade_speed = 0.06; // Fast transitions
            break;
        default:
            fade_speed = 0.03; // Default
            break;
    }
}