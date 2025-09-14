// ===========================================
// o_bug_parent - Left Mouse Button Pressed Event
// ===========================================

if (state == "caught") {
    // Any click anywhere returns to overworld
    room_goto(global.return_room);
} else {
    // Mouse click - pass true to use mouse position for particles
    scr_bug_handle_click(true);
}

if (state == "ready_to_catch") {
    scr_bug_handle_catch();
}