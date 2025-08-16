// o_player - Other 4 Event (Room Start) - Updated for jump intro

// Check if this is the main spooky forest room and if we should do intro
var should_do_jump_intro = false;

// Do jump intro if:
// 1. We're in the main spooky forest room
// 2. We're NOT coming from a door (no door entrance position set)
// 3. We're NOT returning from sleep
if (room == rm_spooky_forest) {
    if (!variable_global_exists("door_entrance_x") || global.door_entrance_x == undefined) {
        if (!variable_global_exists("is_sleeping") || !global.is_sleeping) {
            // Check if this is a "fresh start" (not returning from bug catching)
            if (!variable_global_exists("return_x") || 
                (global.return_x == 626 && global.return_y == 525)) {
                should_do_jump_intro = true;
            }
        }
    }
}

if (should_do_jump_intro) {
    // Find the hole object to get exact position
    var hole_obj = instance_find(o_hole, 0);
    var hole_x = 626;  // Fallback position
    var hole_y = 525;  // Fallback position
    
    if (instance_exists(hole_obj)) {
        hole_x = hole_obj.x;
        hole_y = hole_obj.y;
    }
    
    // Create the wake-up prompt object
    var prompt_obj = instance_create_layer(hole_x, hole_y, "Instances", o_wake_up_prompt);
    
    // Hide and disable this player until wake-up sequence is complete
    x = hole_x;
    y = hole_y;
    visible = false;
    movement_mode = "disabled";
    
    exit;  // Skip normal positioning logic
}

// Normal room start logic (existing code)
// PRIORITY 1: Handle sleep position restoration
if (variable_global_exists("is_sleeping") && global.is_sleeping) {
    if (instance_exists(o_player)) {
        o_player.x = global.temp_player_x;
        o_player.y = global.temp_player_y;
    }
    global.is_sleeping = false;
}
// PRIORITY 2: Position player at door entrance when coming FROM a door
else if (variable_global_exists("door_entrance_x") && global.door_entrance_x != undefined) {
    o_player.x = global.door_entrance_x;
    o_player.y = global.door_entrance_y;
    // Clear the door entrance globals so they don't interfere next time
    global.door_entrance_x = undefined;
    global.door_entrance_y = undefined;
}
// PRIORITY 3: Default return position for any forest room
else if (variable_global_exists("return_x") && 
         (room == rm_spooky_forest || room == rm_deep_woods || 
          room == rm_forest_clearing || room == rm_shadow_grove)) {
    o_player.x = global.return_x;
    o_player.y = global.return_y;
}