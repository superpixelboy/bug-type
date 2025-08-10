// ===========================================
// o_bug_parent - Left Mouse Button Pressed Event
// ===========================================


if (state == "caught") {
    // Any click anywhere returns to overworld
    room_goto(global.return_room);
} else {
    // Normal bug clicking behavior
    scr_bug_handle_click();
}

if (state == "ready_to_catch") {
    scr_bug_handle_catch();
}