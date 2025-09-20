/// @description Get list of all discovered items based on global variables
/// @return Array of item structs that player has discovered

function scr_get_discovered_items() {
    var discovered = [];
    
    // Check each item's global variable and add if owned
    
    // Lucky Clover
    if (variable_global_exists("has_lucky_clover") && global.has_lucky_clover) {
        array_push(discovered, {
            id: "lucky_clover",
            name: "Lucky Clover",
            description: "Increases luck while foraging.",
            sprite: s_item_clover
        });
    }
    
    // Oak Wand
    if (variable_global_exists("has_oak_wand") && global.has_oak_wand) {
        array_push(discovered, {
            id: "oak_wand",
            name: "Oak Wand",
            description: "Double damage per click.",
            sprite: s_item_oak_wand
        });
    }
    
    // Rabbit Foot (if you have this sprite)
    if (variable_global_exists("has_rabbit_foot") && global.has_rabbit_foot) {
        array_push(discovered, {
            id: "rabbit_foot",
            name: "Rabbit's Foot",
            description: "Brings extra luck in the hunt.",
            sprite: s_item_rabbit_foot // Update if different sprite name
        });
    }
    
    // Horseshoe (if you have this sprite)
    if (variable_global_exists("has_horseshoe") && global.has_horseshoe) {
        array_push(discovered, {
            id: "horseshoe",
            name: "Horseshoe",
            description: "Wards off bad luck.",
            sprite: s_item_horseshoe // Update if different sprite name
        });
    }
    
    // TODO: Add more items as you create them
    // Just follow the same pattern
    
    return discovered;
}