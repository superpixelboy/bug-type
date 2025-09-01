// o_UI_Manager CleanUp Event - COMPLETE with new cleanup
// Existing cleanup
ds_list_destroy(global.flipped_rocks);

// Add spawned rocks cleanup
ds_map_destroy(global.spawned_rocks);

// NEW: Clean up bug catch counts
if (variable_global_exists("bug_catch_counts")) {
    ds_map_destroy(global.bug_catch_counts);
}

// Clean up particle systems when game ends
part_system_destroy(global.dirt_particle_system);
part_system_destroy(global.gold_particle_system);  
part_system_destroy(global.magic_particle_system);

part_type_destroy(global.dirt_particle);
part_type_destroy(global.gold_particle);
part_type_destroy(global.magic_particle);

// Add to existing Cleanup Event - Clean up essence fill surface
if (surface_exists(essence_fill_surface)) {
    surface_free(essence_fill_surface);
}