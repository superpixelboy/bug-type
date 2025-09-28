// scr_cat_companion_helper
// Helper functions for cat companion system
// SAFETY: New script, doesn't modify existing systems

/// @function cat_spawn_companion_in_room()
/// @description Spawns cat companion in current room if befriended
function cat_spawn_companion_in_room() {
    // Only spawn if cat is befriended and companion doesn't already exist
    if (global.cat_befriended && !instance_exists(o_cat_companion)) {
        
        // Create companion near player
        if (instance_exists(o_player)) {
            var cat = instance_create_depth(
                o_player.x + irandom_range(-24, 24),
                o_player.y + irandom_range(-24, 24),
                -o_player.y,
                o_cat_companion
            );
            
            // Set flag so cat knows it spawned from room transition
            cat.spawn_near_player_on_create = true;
            cat.target_x = cat.x;
            cat.target_y = cat.y;
            
            show_debug_message("🐱 Cat companion spawned in room: " + room_get_name(room));
        }
    }
}

/// @function cat_cleanup_on_room_transition()
/// @description Call this before room transitions to clean up cat
function cat_cleanup_on_room_transition() {
    // Destroy companion before room change
    // It will respawn in the new room via Room Start
    if (instance_exists(o_cat_companion)) {
        instance_destroy(o_cat_companion);
        show_debug_message("🐱 Cat companion cleaned up for room transition");
    }
}

/// @function cat_should_follow_through_door()
/// @description Returns true if cat should follow player through doors
/// @returns {bool}
function cat_should_follow_through_door() {
    return (global.cat_befriended && instance_exists(o_cat_companion));
}