// ===========================================
// o_bug_parent - Left Mouse Button Pressed Event
// ===========================================


if (state == "caught") {
    // Any click anywhere returns to overworld
    room_goto_previous();
} else {
    // Normal bug clicking behavior
    scr_bug_handle_click();
}