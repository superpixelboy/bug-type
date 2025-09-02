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


if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
    // Collection is open, don't move or interact
    exit;
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

// Rock interaction
var nearest_rock = instance_nearest(x, y, o_rock_small);
var nearest_mossy = instance_nearest(x, y, o_rock_small_mossy);
var nearest_cracked = instance_nearest(x, y, o_rock_small_cracked);

var closest_rock = noone;
var closest_distance = 999;
var rock_type = "normal";



// Find the closest rock
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

// Handle exclamation mark display
if (can_interact) {
    if (!show_exclamation) {
        // Just became able to interact - trigger bounce animation
        show_exclamation = true;
        exclamation_appeared = false;
        exclamation_animation_timer = 0;
        exclamation_alpha = 0;
        exclamation_bounce_y = 0;
    }
} else {
    if (show_exclamation) {
        // No longer can interact - fade out quickly
        show_exclamation = false;
        exclamation_appeared = false;
    }
}

// Animate exclamation mark
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

// Spacebar interaction
if (keyboard_check_pressed(vk_space) && can_interact) {
    // Store current position before leaving
    global.return_x = x;
    global.return_y = y;
	global.return_room = room;  // Add this line to remember which room we came from
    
    global.current_rock_id = closest_rock.rock_unique_id;
    global.current_rock_type = rock_type;
    audio_play_sound(sn_rock_click, 1, false);
    room_goto(rm_rock_catching);
}


// Update player depth for tree sorting
depth = -y;  // Player sorts based on feet position

// Add this as the FIRST LINE in Step events of objects that should pause
// (like o_player_walk, o_bug_parent, etc.)



// ... rest of your existing Step event code below ...