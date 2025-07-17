// Existing cleanup
ds_list_destroy(global.flipped_rocks);

// Add spawned rocks cleanup
ds_map_destroy(global.spawned_rocks);


// Clean up particle systems when game ends
part_system_destroy(global.dirt_particle_system);
part_system_destroy(global.gold_particle_system);  
part_system_destroy(global.magic_particle_system);

part_type_destroy(global.dirt_particle);
part_type_destroy(global.gold_particle);
part_type_destroy(global.magic_particle);