function scr_essence_multipliers(){
	// scr_essence_multipliers.gml
// Global essence multiplier system

// Function to calculate essence with multipliers
function get_essence_with_multiplier(base_essence, catch_count) {
    var multiplier = 1.0; // Default 1.0x
    
    if (catch_count >= 10) {
        multiplier = 2.0; // 2.0x for 10+ catches
    } else if (catch_count >= 5) {
        multiplier = 1.5; // 1.5x for 5-9 catches
    }
    
    return ceil(base_essence * multiplier); // Round up to avoid decimals
}

// Function for card display text
function get_essence_display_text(base_essence, catch_count) {
    var final_essence = get_essence_with_multiplier(base_essence, catch_count);
    var multiplier_text = "";
    
    // Show multiplier info for bonuses
    if (catch_count >= 10) {
        multiplier_text = " (x2.0)";
    } else if (catch_count >= 5) {
        multiplier_text = " (x1.5)";
    }
    
    return "Essence: +" + string(final_essence) + multiplier_text;
}
}