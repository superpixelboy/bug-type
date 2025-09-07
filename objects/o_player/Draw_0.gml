
// Find closest rock (same logic as Step Event)
var nearest_rock = instance_nearest(x, y, o_rock_small);
var nearest_mossy = instance_nearest(x, y, o_rock_small_mossy);
var nearest_cracked = instance_nearest(x, y, o_rock_small_cracked);

var closest_rock = noone;
var closest_distance = 999;
var outline_sprite = -1;

if (nearest_rock != noone) {
    var dist = distance_to_object(nearest_rock);
    if (dist < closest_distance) {
        closest_distance = dist;
        closest_rock = nearest_rock;
        outline_sprite = s_rock_small_outline;
    }
}

if (nearest_mossy != noone) {
    var dist = distance_to_object(nearest_mossy);
    if (dist < closest_distance) {
        closest_distance = dist;
        closest_rock = nearest_mossy;
        outline_sprite = s_rock_small_mossy_outline;
    }
}

if (nearest_cracked != noone) {
    var dist = distance_to_object(nearest_cracked);
    if (dist < closest_distance) {
        closest_distance = dist;
        closest_rock = nearest_cracked;
        outline_sprite = s_rock_small_cracked_outline;
    }
}

// Check if we can interact
var can_interact = false;
if (closest_distance <= 28 && closest_rock != noone) {
    var dx = closest_rock.x - x;
    var dy = closest_rock.y - y;
    
    switch(facing_direction) {
        case "up":
            can_interact = (dy < -4 && abs(dx) < 20);
            break;
        case "down":
            can_interact = (dy > 4 && abs(dx) < 20);
            break;
        case "left":
            can_interact = (dx < -4 && abs(dy) < 20);
            break;
        case "right":
            can_interact = (dx > 4 && abs(dy) < 20);
            break;
    }
}

// Draw outline FIRST (behind everything)
if (can_interact) {
    var pulse_alpha = 0.4 + 0.3 * sin(current_time / 300);
    draw_set_alpha(pulse_alpha);
    draw_sprite(outline_sprite, 0, closest_rock.x, closest_rock.y);
    draw_set_alpha(1);
}

// Call parent draw (this draws shadow + player sprite)
event_inherited();

// Draw exclamation mark ABOVE player
if (exclamation_alpha > 0) {
    draw_set_alpha(exclamation_alpha);
    
    // Position above player head
    var exclamation_x = x;
    var exclamation_y = y - 24 + exclamation_bounce_y;  // 24 pixels above player
    
    // Draw exclamation mark - you can use text or create a sprite
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Black outline for visibility
    draw_set_color(c_black);
    for (var dx = -1; dx <= 1; dx++) {
        for (var dy = -1; dy <= 1; dy++) {
            if (dx != 0 || dy != 0) {
                draw_text(exclamation_x + dx, exclamation_y + dy, "!");
            }
        }
    }
    
    // Orange exclamation mark! 🧡
    draw_set_color(make_color_rgb(255, 140, 0));  // Nice bright orange
    draw_text(exclamation_x, exclamation_y, "!");
    
    // Reset draw settings
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

// TEMPORARY DEBUG - Add this to END of o_player Draw Event to visualize interaction zones
// Remove after testing

if (keyboard_check(vk_f3)) { // Hold F3 to see interaction zones
    // Draw touching range (very close)
    draw_set_alpha(0.2);
    draw_set_color(c_green);
    draw_circle(x, y, 16, false); // Touching range
    
    // Draw proximity range (medium distance)
    draw_set_alpha(0.1);
    draw_set_color(c_yellow);
    draw_circle(x, y, 32, false); // Proximity range
    
    // Draw facing interaction range for rocks
    draw_set_alpha(0.15);
    draw_set_color(c_blue);
    draw_circle(x, y, 28, false); // Rock facing range
    
    // Draw directional facing indicator
    draw_set_alpha(0.4);
    draw_set_color(c_red);
    var dir_x = x;
    var dir_y = y;
    switch(facing_direction) {
        case "up": dir_y -= 25; break;
        case "down": dir_y += 25; break;
        case "left": dir_x -= 25; break;
        case "right": dir_x += 25; break;
    }
    draw_line_width(x, y, dir_x, dir_y, 3);
    
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    // Legend
    draw_set_color(c_white);
    draw_text(10, 150, "F3 - Interaction Zones:");
    draw_set_color(c_green);
    draw_text(10, 165, "Green = Direct Touch (8px)");
    draw_set_color(c_yellow);
    draw_text(10, 180, "Yellow = Looking At (32px)");
    draw_set_color(c_blue);
    draw_text(10, 195, "Blue = Rock Facing (28px)");
    draw_set_color(c_red);
    draw_text(10, 210, "Red = Facing Direction");
    draw_set_color(c_white);
}