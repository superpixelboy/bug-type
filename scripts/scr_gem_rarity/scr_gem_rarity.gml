function scr_gem_rarity(bug_type) {
    if (!variable_struct_exists(global.bug_data, bug_type)) return 5;
    
    var bug_data = global.bug_data[$ bug_type];
    var locations = bug_data.locations;
    var location_names = variable_struct_get_names(locations);
    
    var total_rarity = 0;
    var valid_locations = 0;
    
    for (var i = 0; i < array_length(location_names); i++) {
        var rarity = locations[$ location_names[i]];
        if (rarity != "x") {
            total_rarity += rarity;
            valid_locations++;
        }
    }
    
    var avg_rarity = valid_locations > 0 ? total_rarity / valid_locations : 5;
    
    // Convert to gem tiers (1=ultra rare, 5=very common)
    if (avg_rarity >= 8) return 1;      // Ultra Rare
    else if (avg_rarity >= 6) return 2; // Rare
    else if (avg_rarity >= 4) return 3; // Uncommon
    else if (avg_rarity >= 2) return 4; // Common
    else return 5;                      // Very Common
}

function get_gem_sprite(rarity_tier) {
    switch(rarity_tier) {
        case 1: return s_gem_ultra_rare;
        case 2: return s_gem_rare;
        case 3: return s_gem_uncommon;
        case 4: return s_gem_common;
        case 5: return s_gem_very_common;
        default: return s_gem_common;
    }
}
