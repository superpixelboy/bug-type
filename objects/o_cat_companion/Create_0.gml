// o_cat_companion Create Event
// SAFETY: New object, no modifications to existing systems
// This is the cat that follows player after befriending

// IMPORTANT: Do NOT call event_inherited() - this object should NOT inherit from o_npc_parent
// The companion cat doesn't need dialogue - it just follows the player

// SPRITE SETUP
sprite_index = s_cat_idle_down;
image_speed = 0.15;

// FOLLOWING BEHAVIOR VARIABLES
follow_distance = 40;        // How far behind player to stay
follow_speed = 2;          // Base movement speed
catch_up_speed = 3.5;        // Speed when far behind
max_follow_distance = 80;    // Distance at which cat teleports to player

// SMOOTH FOLLOWING - Cat moves toward where player WAS
target_x = x;
target_y = y;
follow_delay = 8;            // Frames before starting to follow
follow_delay_timer = 0;

// MOVEMENT STATE
is_moving = false;
move_direction = "down";     // Current facing direction

// IDLE BEHAVIOR
idle_timer = 0;
idle_state = "normal";       // "normal", "sit", "groom"
idle_state_duration = 0;

// CAT ANIMATION
walk_frame_speed = 0.2;      // Animation speed when walking

// COLLISION WITH PLAYER
can_collide_with_player = false; // Cat can walk through player

// ROOM TRANSITION HANDLING
spawn_near_player_on_create = false; // Set to true when transitioning rooms

// If spawning from room transition, appear near player
if (spawn_near_player_on_create && instance_exists(o_player)) {
    x = o_player.x + irandom_range(-16, 16);
    y = o_player.y + irandom_range(-16, 16);
    target_x = x;
    target_y = y;
}

// DEPTH SORTING
depth = -y;

// ===== CAT SHADOW CONFIGURATION =====
// Manual shadow setup for companion cat (since it doesn't inherit from shadow_parent)
shadow_enabled = true;
shadow_offset_x = 2;        // Slight offset to the right (cats have small shadows)
shadow_offset_y = 4;        // Just below the cat's base
shadow_scale_x = 1.1;       // Slightly narrower than the cat sprite
shadow_scale_y = 0.5;       // Flat, cat-like shadow
shadow_alpha = 0.35;        // Semi-transparent, natural looking