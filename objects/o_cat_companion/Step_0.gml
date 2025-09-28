// o_cat_companion Step Event
// SAFETY: Self-contained following logic, doesn't modify player or other systems

// Exit if player doesn't exist
if (!instance_exists(o_player)) exit;

// FOLLOWING LOGIC
var player_distance = point_distance(x, y, o_player.x, o_player.y);

// TELEPORT if cat is too far behind (went through door without cat, etc)
if (player_distance > max_follow_distance) {
    // Teleport near player with slight offset so not directly on top
    x = o_player.x + irandom_range(-20, 20);
    y = o_player.y + irandom_range(-20, 20);
    target_x = x;
    target_y = y;
    is_moving = false;
    sprite_index = s_cat_idle_down;
}

// UPDATE TARGET POSITION (where cat wants to go)
// Cat follows toward where player was a moment ago for smooth trailing
if (player_distance > follow_distance) {
    follow_delay_timer++;
    
    if (follow_delay_timer >= follow_delay) {
        // Update target to player's current position
        target_x = o_player.x;
        target_y = o_player.y;
    }
} else {
    // Close enough - reset delay timer
    follow_delay_timer = 0;
}

// MOVE TOWARD TARGET
var distance_to_target = point_distance(x, y, target_x, target_y);

if (distance_to_target > follow_distance) {
    is_moving = true;
    
    // Choose speed based on distance
    var current_speed = (distance_to_target > follow_distance * 2) ? catch_up_speed : follow_speed;
    
    // Calculate direction to target
    var dir_to_target = point_direction(x, y, target_x, target_y);
    
    // Move toward target
    var move_x = lengthdir_x(current_speed, dir_to_target);
    var move_y = lengthdir_y(current_speed, dir_to_target);
    
    x += move_x;
    y += move_y;
    
    // UPDATE FACING DIRECTION AND SPRITE
    // Determine which direction cat is primarily moving
    if (abs(move_x) > abs(move_y)) {
        // Horizontal movement dominant
        if (move_x > 0) {
            move_direction = "right";
            sprite_index = s_cat_walk_right;
        } else {
            move_direction = "left";
            sprite_index = s_cat_walk_left;
        }
    } else {
        // Vertical movement dominant
        if (move_y > 0) {
            move_direction = "down";
            sprite_index = s_cat_walk_down;
        } else {
            move_direction = "up";
            sprite_index = s_cat_walk_up;
        }
    }
    
    image_speed = walk_frame_speed;
    
} else {
    // Close enough to target - stop moving
    is_moving = false;
    image_speed = 0.1; // Slower idle animation
    
    // Switch to idle sprite
    switch(move_direction) {
        case "up":
            sprite_index = s_cat_idle_up;
            break;
        case "down":
            sprite_index = s_cat_idle_down;
            break;
        case "left":
            sprite_index = s_cat_idle_left;
            break;
        case "right":
            sprite_index = s_cat_idle_right;
            break;
    }
    
    // CUTE IDLE BEHAVIORS
    idle_timer++;
    
    // Occasionally do cute idle animations
    if (idle_timer > 120 && irandom(100) < 2) {
        // Small chance each frame to do something cute
        // You could add special idle animations here
        idle_timer = 0;
    }
}

// UPDATE DEPTH for proper layering with player and environment
depth = -y;