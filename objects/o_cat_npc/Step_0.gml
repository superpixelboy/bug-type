// o_cat_npc Step Event
// SAFETY: Only adding cat-specific behavior, parent handles all interaction

// Call parent step event (handles all interaction and dialogue)
event_inherited();

// GENTLE IDLE SWAYING (only when not in dialogue)
if (!dialogue_active) {
    idle_sway_timer += idle_sway_speed;
    
    // Very subtle side-to-side sway
    var sway_offset = sin(idle_sway_timer) * idle_sway_amount;
    image_xscale = abs(image_xscale) + (sway_offset * 0.01); // Barely noticeable breathing
}

// CHECK IF DIALOGUE JUST ENDED - Time to befriend!
// Parent system sets dialogue_active to false when dialogue completes
if (dialogue_cooldown == 29 && !dialogue_active && !cat_befriended) {
    // Dialogue just ended (cooldown just started at 30, now 29)
    // This means player completed the conversation!
    
    cat_befriended = true;
    global.cat_befriended = true;
    
    // Play happy meow sound (if you have one)
    // audio_play_sound(sn_cat_meow, 1, false);
    
    // DEBUG: Confirm befriending worked
    show_debug_message("🐱 CAT BEFRIENDED! Converting to companion...");
    
    // SPAWN THE COMPANION VERSION
    // Create the following cat at player's position
    var companion = instance_create_depth(o_player.x, o_player.y - 20, depth, o_cat_companion);
    
    // Pass any necessary state to companion
    if (instance_exists(companion)) {
        companion.target_x = o_player.x;
        companion.target_y = o_player.y;
    }
    
    // AUTO-SAVE the befriend state
    if (script_exists(asset_get_index("scr_auto_save"))) {
        scr_auto_save();
    }
    
    // Remove this static NPC version
    instance_destroy();
}

// Update depth for proper rendering with player
depth = -y;