// Draw the empty rock sprite (dirt, stones, whatever you make)
draw_self();

// Draw "Nothing found..." message
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var text_x = room_width/2;
var text_y = room_height/2 - 60;

// Black outline for visibility
draw_set_color(c_black);
for (var dx = -1; dx <= 1; dx++) {
    for (var dy = -1; dy <= 1; dy++) {
        if (dx != 0 || dy != 0) {
            draw_text(text_x + dx, text_y + dy, "Nothing found...");
          
        }
    }
}

// White text
draw_set_color(c_white);
draw_text(text_x, text_y, "Nothing found...");


// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);