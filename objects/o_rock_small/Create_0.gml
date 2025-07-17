// Just set default ID - spawn node will handle flipped logic
rock_unique_id = string(x) + "_" + string(y);

// Check if this rock was already flipped (only if the list exists)
if (variable_global_exists("flipped_rocks") && ds_list_find_index(global.flipped_rocks, rock_unique_id) != -1) {
    // This rock was already flipped, destroy it
    instance_destroy();
}