// scr_bug_catch_tracking.gml
// Bug catch counting and coin tier system

/// @description Get catch count for a bug type
/// @param bug_key The bug type key to check
function get_bug_catch_count(bug_key) {
    if (!variable_global_exists("bug_catch_counts")) {
        global.bug_catch_counts = ds_map_create();
        return 0;
    }
    
    if (ds_map_exists(global.bug_catch_counts, bug_key)) {
        return ds_map_find_value(global.bug_catch_counts, bug_key);
    }
    return 0;
}

/// @description Increment catch count and return new count
/// @param bug_key The bug type key to increment
function increment_bug_catch_count(bug_key) {
    if (!variable_global_exists("bug_catch_counts")) {
        global.bug_catch_counts = ds_map_create();
    }
    
    var current_count = get_bug_catch_count(bug_key);
    var new_count = current_count + 1;
    ds_map_set(global.bug_catch_counts, bug_key, new_count);
    return new_count;
}

/// @description Get coin sprite based on catch count
/// @param catch_count The number of times this bug has been caught
function get_coin_sprite_from_count(catch_count) {
    if (catch_count >= 20) {
        return s_coin_gold;  // Could add platinum sprite later
    } else if (catch_count >= 10) {
        return s_coin_gold;
    } else if (catch_count >= 5) {
        return s_coin_silver;
    } else {
        return s_coin_copper;
    }
}

/// @description Check if this catch count triggers a coin tier advancement
/// @param old_count Previous catch count
/// @param new_count New catch count
function check_coin_tier_advancement(old_count, new_count) {
    var old_tier = get_coin_tier_from_count(old_count);
    var new_tier = get_coin_tier_from_count(new_count);
    return new_tier > old_tier;
}

/// @description Get coin tier number from catch count
/// @param count Catch count
function get_coin_tier_from_count(count) {
    if (count >= 20) return 4;  // Platinum (future)
    if (count >= 10) return 3;  // Gold
    if (count >= 5) return 2;   // Silver
    return 1;  // Copper
}

/// @description Get bonus essence for tier advancement
/// @param new_tier The new tier reached
function get_tier_advancement_bonus(new_tier) {
    switch(new_tier) {
        case 2: return 5;   // Silver bonus
        case 3: return 10;  // Gold bonus  
        case 4: return 20;  // Platinum bonus
        default: return 0;
    }
}

function get_essence_multiplier_from_count(catch_count) {
    if (catch_count >= 20) {
        return 2.5;  // Platinum multiplier
    } else if (catch_count >= 10) {
        return 2.0;  // Gold multiplier
    } else if (catch_count >= 5) {
        return 1.5;  // Silver multiplier
    } else {
        return 1.0;  // Copper (base) multiplier
    }
}