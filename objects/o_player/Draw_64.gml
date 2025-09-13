
// Check if input manager exists
if (variable_global_exists("input_manager")) {
    var inp = global.input_manager;
    
    draw_set_color(c_yellow);
    draw_text(10, 250, "=== INPUT DEBUG ===");
    draw_text(10, 265, "Controller Connected: " + string(inp.controller_connected));
    draw_text(10, 280, "Controller Slot: " + string(inp.controller_slot));
    draw_text(10, 295, "Last Input Method: " + string(inp.last_input_method));
    
    draw_text(10, 315, "Move Up: " + string(inp.move_up));
    draw_text(10, 330, "Move Down: " + string(inp.move_down));
    draw_text(10, 345, "Move Left: " + string(inp.move_left));
    draw_text(10, 360, "Move Right: " + string(inp.move_right));
    
    draw_text(10, 380, "Interact: " + string(inp.interact));
    draw_text(10, 395, "Menu Toggle: " + string(inp.menu_toggle));
    draw_text(10, 410, "Menu Toggle Pressed: " + string(inp.menu_toggle_pressed));
    
    // Show cooldown status
    if (variable_global_exists("input_cooldown")) {
        draw_text(10, 430, "Input Cooldown: " + string(global.input_cooldown));
    }
    
    draw_set_color(c_white);
} else {
    draw_set_color(c_red);
    draw_text(10, 250, "INPUT MANAGER NOT FOUND!");
    draw_text(10, 265, "Did you set up o_game_manager?");
    draw_set_color(c_white);
}