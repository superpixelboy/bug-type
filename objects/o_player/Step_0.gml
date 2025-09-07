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

// ... rest of your existing Step event code continues below ...
// Exit early if collection UI is open
if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    exit;
}


// NEW: Exit early if ANY NPC dialogue is active (blocks all movement and interaction)
var npc_list = [o_ghost_raven_ow, o_babayaga, o_ghost_raven_manager];
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

// Rock interaction (find closest rock - keep existing logic)
var nearest_rock = instance_nearest(x, y, o_rock_small);
var nearest_mossy = instance_nearest(x, y, o_rock_small_mossy);
var nearest_cracked = instance_nearest(x, y, o_rock_small_cracked);

var closest_rock = noone;
var closest_distance = 999;
var rock_type = "normal";

// Find the closest rock (keep existing logic)
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

// Check if we can interact with rocks (keep existing logic)
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

// FIXED: Handle exclamation mark display for rocks (using source tracking)
if (can_interact) {
    // Can interact with rock - show exclamation if not already shown by something else
    if (!show_exclamation) {
        // Nothing is showing exclamation, so we can show it for rock
        show_exclamation = true;
        exclamation_appeared = false;
        exclamation_animation_timer = 0;
        exclamation_alpha = 0;
        exclamation_bounce_y = 0;
        exclamation_source = "rock";
    }
    // If exclamation is already showing from NPC, don't override it
} else {
    // Can't interact with rocks - ONLY hide exclamation if WE (rock system) are showing it
    if (show_exclamation && exclamation_source == "rock") {
        show_exclamation = false;
        exclamation_appeared = false;
        exclamation_source = "none";
    }
    // If exclamation_source is "npc", leave it alone - the NPC will manage it
}

// Animate exclamation mark (keep existing animation logic)
if (show_exclamation) {
    exclamation_animation_timer++;
    
    if (!exclamation_appeared) {
        // Bounce-in animation (first 10 frames)
        if (exclamation_animation_timer <= 10) {
            var bounce_progress = exclamation_animation_timer / 10;
            
            // Easing: bounce UP from below with overshoot
            var ease_progress = 1 - power(1 - bounce_progress, 3);
            exclamation_bounce_y = lerp(12, 0, ease_progress);
            
            // Add a little bounce back
            if (bounce_progress > 0.7) {
                var bounce_back = sin((bounce_progress - 0.7) * 3.14 * 3) * -2;
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

// Rock interaction (keep existing spacebar logic)
if (keyboard_check_pressed(vk_space) && can_interact) {
    // Store current position before leaving
    global.return_x = x;
    global.return_y = y;
    global.return_room = room;
    
    global.current_rock_id = closest_rock.rock_unique_id;
    global.current_rock_type = rock_type;
    audio_play_sound(sn_rock_click, 1, false);
    room_goto(rm_rock_catching);
}


// Update player depth for tree sorting
depth = -y;  // Player sorts based on feet position

// Add this as the FIRST LINE in Step events of objects that should pause
// (like o_player_walk, o_bug_parent, etc.)

// ===============================================
// NPC INTERACTION SYSTEM (matches rock system exactly)
// ===============================================

// Find nearest interactable NPC (any object with dialogue_active variable)
var npc_list = [o_ghost_raven_ow, o_babayaga];  // Add any new NPCs here
var nearest_npc = noone;
var npc_distance = 999;
var can_interact_npc = false;

// Find the closest NPC from our list
for (var i = 0; i < array_length(npc_list); i++) {
    var npc_type = npc_list[i];
    var closest_of_type = instance_nearest(x, y, npc_type);
    
    if (closest_of_type != noone) {
        var dist = distance_to_object(closest_of_type);
        if (dist < npc_distance) {
            npc_distance = dist;
            nearest_npc = closest_of_type;
        }
    }
}

// Check if we can interact with the nearest NPC (same logic as rocks)
if (nearest_npc != noone && npc_distance <= 28) {
    var dx = nearest_npc.x - x;
    var dy = nearest_npc.y - y;
    
    // EXACT same switch case logic as rocks
    switch(facing_direction) {
        case "up":
            can_interact_npc = (dy < -4 && abs(dx) < 20);
            break;
        case "down":
            can_interact_npc = (dy > 4 && abs(dx) < 20);
            break;
        case "left":
            can_interact_npc = (dx < -4 && abs(dy) < 20);
            break;
        case "right":
            can_interact_npc = (dx > 4 && abs(dy) < 20);
            break;
    }
}

// Handle NPC exclamation mark (same pattern as rocks)
if (can_interact_npc && nearest_npc != noone && !nearest_npc.dialogue_active) {
    // Can interact with NPC AND dialogue is not active - show exclamation if not already shown
    if (!show_exclamation) {
        show_exclamation = true;
        exclamation_appeared = false;
        exclamation_animation_timer = 0;
        exclamation_alpha = 0;
        exclamation_bounce_y = 0;
        exclamation_source = "npc";
    }
} else {
    // Can't interact with NPC OR dialogue is active - ONLY hide if WE are showing it
    if (show_exclamation && exclamation_source == "npc") {
        show_exclamation = false;
        exclamation_appeared = false;
        exclamation_source = "none";
    }
}

// Handle NPC dialogue interaction (same spacebar logic as rocks)
if (keyboard_check_pressed(vk_space) && can_interact_npc && nearest_npc.dialogue_cooldown <= 0) {
    // Hide exclamation during dialogue
    show_exclamation = false;
    exclamation_appeared = false;
    exclamation_source = "none";
    
    // Trigger dialogue based on NPC type
    if (nearest_npc.object_index == o_ghost_raven_ow) {
        // Ghost Raven dialogue (typewriter system)
        nearest_npc.dialogue_active = true;
        nearest_npc.dialogue_index = 0;
        nearest_npc.input_cooldown = 10;
        
        // Initialize typewriter for first message
        var current_message = nearest_npc.dialogue_messages[nearest_npc.dialogue_index];
        nearest_npc.typewriter_text = "";
        nearest_npc.typewriter_char_index = 0;
        nearest_npc.typewriter_complete = false;
        nearest_npc.typewriter_timer = 0;
        
    } else if (nearest_npc.object_index == o_babayaga) {
        // Baba Yaga dialogue (simple system)
        nearest_npc.dialogue_active = true;
        nearest_npc.dialogue_index = 0;
        
        // Set dialogue state based on progress
        if (global.bugs_caught == 0) {
            nearest_npc.dialogue_state = "greeting";
        } else if (global.bugs_caught < 5) {
            nearest_npc.dialogue_state = "progress";
        } else {
            nearest_npc.dialogue_state = "encouragement";
        }
    }
    
    // Play interaction sound (same as rocks)
    var snd = asset_get_index("sn_bugtap1");
    if (snd != -1) audio_play_sound(snd, 1, false);
}