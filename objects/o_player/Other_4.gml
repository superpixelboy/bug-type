// o_player - Room Start Event - FIXED

show_debug_message("=== PLAYER ROOM START ===");
show_debug_message("Room: " + room_get_name(room));
show_debug_message("Player x before: " + string(x));
show_debug_message("Player y before: " + string(y));

// Check if this is the main spooky forest room and if we should do intro
var should_do_jump_intro = false;

if (room == rm_spooky_forest) {
    if (!variable_global_exists("door_entrance_x") || global.door_entrance_x == undefined) {
        if (!variable_global_exists("is_sleeping") || !global.is_sleeping) {
            if (!variable_global_exists("return_x") || 
                (global.return_x == 626 && global.return_y == 525)) {
                should_do_jump_intro = true;
            }
        }
    }
}

if (should_do_jump_intro) {
    var hole_obj = instance_find(o_hole, 0);
    var hole_x = 626;
    var hole_y = 525;
    
    if (instance_exists(hole_obj)) {
        hole_x = hole_obj.x;
        hole_y = hole_obj.y;
    }
    
    var prompt_obj = instance_create_layer(hole_x, hole_y, "Instances", o_wake_up_prompt);
    
    x = hole_x;
    y = hole_y;
    visible = false;
    movement_mode = "disabled";
    
    exit;
}

// Normal room start logic
// PRIORITY 1: Handle sleep position restoration
if (variable_global_exists("is_sleeping") && global.is_sleeping) {
    if (instance_exists(o_player)) {
        o_player.x = global.temp_player_x;
        o_player.y = global.temp_player_y;
    }
    global.is_sleeping = false;
}
// PRIORITY 2: Position player at door entrance when coming FROM a door
// FIXED: Check for undefined directly, not just existence
else if (variable_global_exists("door_entrance_x") && 
         global.door_entrance_x != undefined && 
         is_real(global.door_entrance_x)) {
    show_debug_message("EXECUTING PRIORITY 2 - Door entrance");
    o_player.x = global.door_entrance_x;
    o_player.y = global.door_entrance_y;
    
    // Clear by deleting, not setting to undefined
    variable_global_set("door_entrance_x", undefined);
    variable_global_set("door_entrance_y", undefined);
}
// PRIORITY 3: Default return position
else if (variable_global_exists("return_x") && 
         (room == rm_spooky_forest || room == rm_graveyard || 
          room == rm_forest_clearing || room == rm_shadow_grove)) {
    show_debug_message("EXECUTING PRIORITY 3 - Return position");
    o_player.x = global.return_x;
    o_player.y = global.return_y;
}

show_debug_message("Player x after: " + string(x));
show_debug_message("Player y after: " + string(y));
show_debug_message("=== END PLAYER ROOM START ===");