// Add this at the START of o_bug_card Draw Event
// DEBUG: Draw a simple rectangle to see if card exists
draw_set_color(c_red);
draw_rectangle(x-50, y-50, x+50, y+50, false);
draw_set_color(c_white);
draw_text(x, y-70, "CARD HERE! State: " + card_state);