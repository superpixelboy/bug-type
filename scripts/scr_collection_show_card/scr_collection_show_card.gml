/// scr_collection_show_card(bug_key)
/// @description Create and show a collection bug card (separate from normal bug catching)
/// @param {string} bug_key The key of the bug to display

function scr_collection_show_card(bug_key) {
    show_debug_message("=== COLLECTION CARD CLICK DEBUG ===");
    show_debug_message("Creating collection card for: " + string(bug_key));
    
    // Clean up any existing collection cards
    if (instance_exists(o_bug_card_collection)) {
        show_debug_message("Destroying existing collection card...");
        with(o_bug_card_collection) instance_destroy();
    }
    
    // Get bug data
    if (!variable_global_exists("bug_data") || !variable_struct_exists(global.bug_data, bug_key)) {
        show_debug_message("ERROR: Bug data not found for key: " + string(bug_key));
        return false;
    }
    
    var bug_data = global.bug_data[$ bug_key];
    
    // Create the collection card
    var card = instance_create_layer(room_width / 2, room_height + 100, "Instances", o_bug_card_collection);
    
    // Sanity check creation
    if (!instance_exists(card)) {
        show_debug_message("ERROR: Failed to create o_bug_card_collection instance");
        return false;
    }
    
    // Set card data
    with (card) {
        // Basic bug info
        type_id = bug_key;
        bug_name = bug_data.name;
        flavor_text = bug_data.flavor_text;
        bug_sprite = bug_data.sprite;
        essence_value = bug_data.essence;
        
        // Rarity system
        if (bug_key != "unknown") {
            bug_rarity_tier = scr_gem_rarity(bug_key);
            gem_sprite = get_gem_sprite(bug_rarity_tier);
        } else {
            bug_rarity_tier = 5; // default very common
            gem_sprite = s_gem_very_common;
        }
        
        gem_float_timer = 0;
        gem_glow_timer = 0;
        
        show_debug_message("Collection card created for bug: " + bug_name + " | rarity tier: " + string(bug_rarity_tier));
    }
    
    return true;
}