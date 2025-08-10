// ===========================================
// o_bug_parent - Left Mouse Button Pressed Event
// ===========================================
show_debug_message("=== MOUSE CLICK DEBUG ===");
show_debug_message("Current state: " + string(state));
show_debug_message("global.showing_card: " + string(global.showing_card));
show_debug_message("Existing card count: " + string(instance_number(o_bug_card)));

if (state == "caught") {
    room_goto(global.return_room);
} else {
    scr_bug_handle_click();  // Only call click handler
    // Remove the second scr_bug_handle_catch() call completely
}

