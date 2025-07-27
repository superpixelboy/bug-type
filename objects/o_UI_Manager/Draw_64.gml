
// Replace bug counter with essence counter
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var essence_text = "Essence: " + string(global.essence);
var counter_x = 20;
var counter_y = 20;

// Black outline
draw_set_color(c_black);
draw_text(counter_x+1, counter_y+1, essence_text);
draw_text(counter_x-1, counter_y-1, essence_text);
draw_text(counter_x+1, counter_y-1, essence_text);
draw_text(counter_x-1, counter_y+1, essence_text);

// White text
draw_set_color(c_white);
draw_text(counter_x, counter_y, essence_text);

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw screen flash overlay (add at the END of Draw GUI Event)
if (flash_alpha > 0) {
    draw_set_alpha(flash_alpha);
    draw_set_color(c_white);
    draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

