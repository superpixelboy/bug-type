// o_wake_up_prompt - Create Event (FIXED)

// Find the hole object to get proper positioning
var hole_obj = instance_find(o_hole, 0);
var hole_center_x = x;
var hole_center_y = y;

if (instance_exists(hole_obj)) {
    hole_center_x = hole_obj.x;
    hole_center_y = hole_obj.y;
    // IMPORTANT: Disable hole's sleep functionality during intro
    hole_obj.intro_active = true;
}

// Position at hole
x = hole_center_x;
y = hole_center_y;

// Text display variables (THESE WERE MISSING!)
waiting_for_input = true;
prompt_text = "Press SPACE to wake up!";
text_alpha = 1;
text_pulse_timer = 0;
text_bounce_y = 0;
text_y_offset = -30;  // Position text above the hole

// Set depth to draw on top
depth = -1000;

// Disable player during intro sequence
if (instance_exists(o_player)) {
    o_player.visible = false;
    o_player.movement_mode = "disabled";
}