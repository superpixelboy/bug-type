// === ADD TO rm_wichhouse Room Start Event ===
show_debug_message("🏠 ENTERING WITCH HOUSE");
show_debug_message("  Tutorial state on entry: " + string(global.met_baba_yaga));

// === ADD TO rm_wichhouse Room End Event ===  
show_debug_message("🚪 LEAVING WITCH HOUSE");
show_debug_message("  Tutorial state on exit: " + string(global.met_baba_yaga));

// === CHECK FOR AUTO-DIALOGUE TRIGGERS ===
// Look for any code that might automatically start dialogue when room loads
// Common places this might happen:
// - o_babayaga Create Event
// - Room Start events
// - Any "Game Start" or initialization code

// === ADD TO o_babayaga Create Event ===
show_debug_message("👵 BABA YAGA CREATED");
show_debug_message("  Current tutorial state: " + string(global.met_baba_yaga));
show_debug_message("  Dialogue will be set up based on this state");

// Make sure no dialogue automatically starts!
// Remove any code that might set dialogue_active = true automatically