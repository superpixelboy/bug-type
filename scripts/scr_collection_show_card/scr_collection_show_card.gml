/// scr_collection_show_card(bug_key, [ui_owner])
function scr_collection_show_card(bug_key, ui_owner) {
    show_debug_message("=== COLLECTION CARD CLICK DEBUG ===");

    // Resolve ui_owner if not provided
    if (argument_count < 2 || !instance_exists(ui_owner)) {
        ui_owner = instance_exists(o_bug_collection_ui) ? instance_find(o_bug_collection_ui, 0) : noone;
    }

    if (instance_exists(o_bug_card_collection)) {
        with (o_bug_card_collection) instance_destroy();
    }

    if (!variable_global_exists("bug_data") || !variable_struct_exists(global.bug_data, bug_key)) {
        show_debug_message("ERROR: Bug data not found for key: " + string(bug_key));
        return false;
    }

    var bug_data = global.bug_data[$ bug_key];
    var card = instance_create_layer(room_width / 2, room_height + 100, "Instances", o_bug_card_collection);
    if (!instance_exists(card)) return false;

    with (card) {
        // CRITICAL: bind card to its UI controller
        ui_owner = ui_owner;

        type_id       = bug_key;
        bug_name      = bug_data.name;
        flavor_text   = bug_data.flavor_text;
        bug_sprite    = bug_data.sprite;
        essence_value = bug_data.essence;

        if (type_id != "unknown") {
            bug_rarity_tier = scr_gem_rarity(type_id);
            gem_sprite      = get_gem_sprite(bug_rarity_tier);
        } else {
            bug_rarity_tier = 5;
            gem_sprite      = s_gem_very_common;
        }
        gem_float_timer = 0;
        gem_glow_timer  = 0;
    }

    return true;
}
