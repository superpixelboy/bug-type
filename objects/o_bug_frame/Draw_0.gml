// Draw the frame sprite
draw_self();

// Draw bug on top if we should show it
if (show_bug) {
    // Choose which bug sprite based on frame type
    var bug_to_draw = s_bug_test; // default
    
    if (frame_bug_type == "fast") {
        bug_to_draw = s_bug_fast;
    } else if (frame_bug_type == "jumpy") {
        bug_to_draw = s_bug_jumpy;
    }
    
    // Draw the bug smaller and centered on the frame
    draw_sprite_ext(bug_to_draw, 0, x, y, 0.5, 0.5, 0, c_white, 1);
}