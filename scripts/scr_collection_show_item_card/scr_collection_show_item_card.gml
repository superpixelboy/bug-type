/// @description Show a zoomed-in item card in collection
/// @param item_data The item data struct with {id, name, description, sprite}
/// @return true if card was created, false if already exists

function scr_collection_show_item_card(item_data) {
    // Don't create if one already exists
    if (instance_exists(o_item_card_collection)) {
        return false;
    }
    
    // Create the card
    var card = instance_create_depth(0, 0, -10001, o_item_card_collection);
    
    // Set item data
    card.item_id = item_data.id;
    card.item_name = item_data.name;
    card.item_description = item_data.description;
    card.item_sprite = item_data.sprite;
    
    return true;
}