// o_bug_card_collection Destroy Event
// Clean up the overlay when card is destroyed

if (variable_instance_exists(id, "overlay_instance") && instance_exists(overlay_instance)) {
    with(overlay_instance) instance_destroy();
    show_debug_message("Destroyed overlay with collection card");
}

show_debug_message("Collection card destroyed: " + bug_name);