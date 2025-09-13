// Skip all player logic if movement is disabled (during intro)
// Add this as the VERY FIRST LINE in o_player Step Event
// Exit early if game is paused
if (variable_global_exists("game_paused") && global.game_paused) {
    exit; // Skip the rest of the Step event
}

// Exit early if movement is disabled (during intro)
if (movement_mode == "disabled") {
    exit;
}


// CHECK FOR DIALOGUE PAUSE - Add this at the very beginning
var any_npc_talking = false;
with (o_npc_parent) {
    if (dialogue_active) {
        any_npc_talking = true;
        break;
    }
}

// STOP MOVEMENT AND INTERACTION when in dialogue
if (any_npc_talking) {
    // Don't process movement, animation, or interactions during dialogue
    exit;
}
// ... rest of your existing Step event code continues below ...
// Exit early if collection UI is open
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    exit;
}


// NEW: Exit early if ANY NPC dialogue is active (blocks all movement and interaction)
var npc_list = [o_ghost_raven_ow_old, o_babayaga_old, o_ghost_raven_manager];
for (var i = 0; i < array_length(npc_list); i++) {
    var npc_type = npc_list[i];
    if (instance_exists(npc_type)) {
        var npc_instance = instance_find(npc_type, 0);
        if (npc_instance != noone && variable_instance_exists(npc_instance, "dialogue_active") && npc_instance.dialogue_active) {
            // Player is frozen during dialogue - no movement, no interactions, no animations
            exit;
        }
    }
}

// Get input
input_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
input_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
input_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
input_right = keyboard_check(vk_right) || keyboard_check(ord("D"));



// Calculate movement
var move_x = input_right - input_left;
var move_y = input_down - input_up;

// Normalize diagonal movement
if (move_x != 0 && move_y != 0) {
    move_x *= 0.7;
    move_y *= 0.7;
}

// Apply movement with collision checking
var new_x = x + (move_x * move_speed);
var new_y = y + (move_y * move_speed);

// Check horizontal collision
if (!place_meeting(new_x, y, o_barrier)) {
    x = new_x;
}

// Check vertical collision  
if (!place_meeting(x, new_y, o_barrier)) {
    y = new_y;
}

// Keep player in room bounds
x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);

// Update facing direction and movement state
var previous_facing = facing_direction;
is_moving = (move_x != 0 || move_y != 0);

if (move_x > 0) facing_direction = "right";
else if (move_x < 0) facing_direction = "left";
else if (move_y < 0) facing_direction = "up";
else if (move_y > 0) facing_direction = "down";

// Enhanced Animation system
if (is_moving) {
    // Set walking sprite based on direction
    switch(facing_direction) {
        case "down":
            if (sprite_index != s_player_walk_d) {
                sprite_index = s_player_walk_d;
                image_index = 0; // Reset to start of animation
            }
            break;
        case "left":
            if (sprite_index != s_player_walk_l) {
                sprite_index = s_player_walk_l;
                image_index = 0;
            }
            break;
        case "right":
            if (sprite_index != s_player_walk_r) {
                sprite_index = s_player_walk_r;
                image_index = 0;
            }
            break;
        case "up":
            if (sprite_index != s_player_walk_u) {
                sprite_index = s_player_walk_u;
                image_index = 0;
            }
            break;
    }
} else {
    // Set idle sprite based on direction
    switch(facing_direction) {
        case "down":
            if (sprite_index != s_player_idle_d) {
                sprite_index = s_player_idle_d;
                image_index = 0;
            }
            break;
        case "left":
            if (sprite_index != s_player_idle_l) {
                sprite_index = s_player_idle_l;
                image_index = 0;
            }
            break;
        case "right":
            if (sprite_index != s_player_idle_r) {
                sprite_index = s_player_idle_r;
                image_index = 0;
            }
            break;
        case "up":
            if (sprite_index != s_player_idle_u) {
                sprite_index = s_player_idle_u;
                image_index = 0;
            }
            break;
    }
}

// Use sprite's built-in animation speed
image_speed = 1;

// o_player Step Event
// ENHANCED: Dual interaction system - facing OR touching for rocks

// ... (all your existing movement and animation code should stay here) ...


// ROCK INTERACTION SYSTEM (EXISTING - KEEP AS IS)
// Find closest rocks
var nearest_rock = instance_nearest(x, y, o_rock_small);
var nearest_mossy = instance_nearest(x, y, o_rock_small_mossy);
var nearest_cracked = instance_nearest(x, y, o_rock_small_cracked);

var closest_rock = noone;
var closest_distance = 999;
var rock_type = "";

if (nearest_rock != noone) {
    var dist = distance_to_object(nearest_rock);
    if (dist < closest_distance) {
        closest_distance = dist;
        closest_rock = nearest_rock;
        rock_type = "normal";
    }
}

if (nearest_mossy != noone) {
    var dist = distance_to_object(nearest_mossy);
    if (dist < closest_distance) {
        closest_distance = dist;
        closest_rock = nearest_mossy;
        rock_type = "mossy";
    }
}

if (nearest_cracked != noone) {
    var dist = distance_to_object(nearest_cracked);
    if (dist < closest_distance) {
        closest_distance = dist;
        closest_rock = nearest_cracked;
        rock_type = "cracked";
    }
}

// Check if we can iteract with rocks
var can_interact_rock_facing = false;
var can_interact_rock_touching = false;

if (closest_distance <= 28 && closest_rock != noone) {
    var dx = closest_rock.x - x;
    var dy = closest_rock.y - y;
    
    // METHOD 1: Facing the rock (existing system)
    switch(facing_direction) {
        case "up":
            can_interact_rock_facing = (dy < -4 && abs(dx) < 20);
            break;
        case "down":
            can_interact_rock_facing = (dy > 4 && abs(dx) < 20);
            break;
        case "left":
            can_interact_rock_facing = (dx < -4 && abs(dy) < 20);
            break;
        case "right":
            can_interact_rock_facing = (dx > 4 && abs(dy) < 20);
            break;
    }
    
    // METHOD 2: Direct touching
    can_interact_rock_touching = (closest_distance <= 8);
}

// REPLACE it with these lines:
var can_interact_rock_base = can_interact_rock_facing || can_interact_rock_touching;

// TUTORIAL GATE: Only allow rock interaction after meeting Baba Yaga
var can_interact_rock = can_interact_rock_base && global.met_baba_yaga;

// BACKUP: Store this for Draw event to use
global.player_can_interact_rock = can_interact_rock;

// NPC INTERACTION SYSTEM (NEW - EXACT SAME PATTERN AS ROCKS)
// Find closest NPC
var nearest_npc = instance_nearest(x, y, o_npc_parent);
var closest_npc = noone;
var closest_npc_distance = 999;

if (nearest_npc != noone) {
    closest_npc_distance = distance_to_object(nearest_npc);
    closest_npc = nearest_npc;
}

// Check if we can interact with NPCs (EXACT SAME LOGIC AS ROCKS)
var can_interact_npc_facing = false;
var can_interact_npc_touching = false;

if (closest_npc_distance <= 28 && closest_npc != noone && !closest_npc.dialogue_active) {
    var dx = closest_npc.x - x;
    var dy = closest_npc.y - y;
    
    // METHOD 1: Facing the NPC (same as rocks)
    switch(facing_direction) {
        case "up":
            can_interact_npc_facing = (dy < -4 && abs(dx) < 20);
            break;
        case "down":
            can_interact_npc_facing = (dy > 4 && abs(dx) < 20);
            break;
        case "left":
            can_interact_npc_facing = (dx < -4 && abs(dy) < 20);
            break;
        case "right":
            can_interact_npc_facing = (dx > 4 && abs(dy) < 20);
            break;
    }
    
    // METHOD 2: Direct touching (same as rocks)
    can_interact_npc_touching = (closest_npc_distance <= 8);
}

var can_interact_npc = can_interact_npc_facing || can_interact_npc_touching;

// EXCLAMATION MARK CONTROL (PRIORITY: rocks > npcs > doors)
if (can_interact_rock) {
    // Rocks have highest priority
    if (!show_exclamation || exclamation_source != "rock") {
        show_exclamation = true;
        exclamation_appeared = false;
        exclamation_animation_timer = 0;
        exclamation_alpha = 0;
        exclamation_bounce_y = 0;
        exclamation_source = "rock";
    }
} else if (can_interact_npc) {
    // NPCs have second priority
    if (!show_exclamation || exclamation_source != "npc") {
        show_exclamation = true;
        exclamation_appeared = false;
        exclamation_animation_timer = 0;
        exclamation_alpha = 0;
        exclamation_bounce_y = 0;
        exclamation_source = "npc";
    }
} else {
    // Turn off exclamation if nothing can be interacted with
    if (show_exclamation && (exclamation_source == "rock" || exclamation_source == "npc")) {
        show_exclamation = false;
        exclamation_appeared = false;
        exclamation_source = "none";
    }
}

// EXCLAMATION MARK ANIMATION (WORKS FOR ALL INTERACTION TYPES)
if (show_exclamation) {
    exclamation_animation_timer++;
    
    if (!exclamation_appeared) {
        // Bounce-in animation (first 20 frames) - POP UP from below!
        if (exclamation_animation_timer <= 10) {
            var bounce_progress = exclamation_animation_timer / 10;
            
            // Easing: bounce UP from below with overshoot
            var ease_progress = 1 - power(1 - bounce_progress, 3);
            exclamation_bounce_y = lerp(12, 0, ease_progress);  // Start below, move up!
            
            // Add a little bounce back (negative bounce for upward motion)
            if (bounce_progress > 0.7) {
                var bounce_back = sin((bounce_progress - 0.7) * 3.14 * 3) * -2;  // Negative for upward
                exclamation_bounce_y += bounce_back;
            }
            
            exclamation_alpha = lerp(0, 1, bounce_progress);
        } else {
            // Finished appearing
            exclamation_appeared = true;
            exclamation_bounce_y = 0;
            exclamation_alpha = 1;
        }
    } else {
        // Gentle idle float animation
        var float_offset = sin(exclamation_animation_timer * 0.1) * 1;
        exclamation_bounce_y = float_offset;
        exclamation_alpha = 1;
    }
} else {
    // Fade out when not interacting
    exclamation_alpha = max(exclamation_alpha - 0.1, 0);
}

// INTERACTION INPUT
if (keyboard_check_pressed(vk_space)) {
    // Check global input cooldown
    var input_blocked = (variable_global_exists("input_cooldown") && global.input_cooldown > 0);
    
    if (!input_blocked) {
        if (can_interact_rock) {
            // Rock interaction
            global.return_x = x;
            global.return_y = y;
            global.return_room = room;
            global.current_rock_id = closest_rock.rock_unique_id;
            global.current_rock_type = rock_type;
            audio_play_sound(sn_rock_click, 1, false);
            room_goto(rm_rock_catching);
        } else if (can_interact_npc) {
            // NPC interaction - call the function properly
            with (closest_npc) {
                npc_start_dialogue();
            }
        }
    }
}

// Update player depth for tree sorting
depth = -y;


// TEMPORARY: Manual tutorial completion for testing
if (keyboard_check_pressed(ord("T"))) {
    global.met_baba_yaga = !global.met_baba_yaga; // Toggle it
    show_debug_message("Tutorial toggled! Now: " + string(global.met_baba_yaga));
    
    // Play sound feedback
    audio_play_sound(sn_bug_catch1, 1, false);
}

// Debug output every few seconds
if (current_time % 3000 < 16) { // Every 3 seconds roughly
    show_debug_message("Current tutorial state: " + string(global.met_baba_yaga));
}