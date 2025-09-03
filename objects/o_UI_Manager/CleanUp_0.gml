// o_UI_Manager CleanUp Event - SAFE cleanup to prevent crashes
// Clean up data structures
if (ds_exists(global.flipped_rocks, ds_type_list)) {
    ds_list_destroy(global.flipped_rocks);
}

if (ds_exists(global.spawned_rocks, ds_type_map)) {
    ds_map_destroy(global.spawned_rocks);
}

if (variable_global_exists("bug_catch_counts") && ds_exists(global.bug_catch_counts, ds_type_map)) {
    ds_map_destroy(global.bug_catch_counts);
}

// Clean up particle systems SAFELY
if (variable_global_exists("dirt_particle_system") && part_system_exists(global.dirt_particle_system)) {
    part_system_destroy(global.dirt_particle_system);
}

if (variable_global_exists("gold_particle_system") && part_system_exists(global.gold_particle_system)) {
    part_system_destroy(global.gold_particle_system);
}

if (variable_global_exists("magic_particle_system") && part_system_exists(global.magic_particle_system)) {
    part_system_destroy(global.magic_particle_system);
}

// Clean up particle types SAFELY
if (variable_global_exists("dirt_particle") && part_type_exists(global.dirt_particle)) {
    part_type_destroy(global.dirt_particle);
}

if (variable_global_exists("gold_particle") && part_type_exists(global.gold_particle)) {
    part_type_destroy(global.gold_particle);
}

if (variable_global_exists("magic_particle") && part_type_exists(global.magic_particle)) {
    part_type_destroy(global.magic_particle);
}

// Clean up essence fill surface
if (surface_exists(essence_fill_surface)) {
    surface_free(essence_fill_surface);
}