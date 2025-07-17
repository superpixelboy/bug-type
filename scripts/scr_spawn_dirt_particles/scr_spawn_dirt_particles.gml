
/// @description Spawn dirt particles for normal hits
/// @param x_pos
/// @param y_pos  
/// @param count
function scr_spawn_dirt_particles(x_pos, y_pos, count) {
    part_particles_create(global.dirt_particle_system, x_pos, y_pos, global.dirt_particle, count);
}

/// @description Spawn gold particles for medium combos
/// @param x_pos
/// @param y_pos
/// @param count
function scr_spawn_gold_particles(x_pos, y_pos, count) {
    part_particles_create(global.gold_particle_system, x_pos, y_pos, global.gold_particle, count);
}

/// @description Spawn magic particles for high combos
/// @param x_pos
/// @param y_pos
/// @param count
function scr_spawn_magic_particles(x_pos, y_pos, count) {
    part_particles_create(global.magic_particle_system, x_pos, y_pos, global.magic_particle, count);
}

/// @description Spawn massive particle burst for catching
/// @param x_pos
/// @param y_pos
function scr_spawn_catch_particles(x_pos, y_pos) {
    // Mix of gold and magic particles for epic effect
    part_particles_create(global.gold_particle_system, x_pos, y_pos, global.gold_particle, 8);
    part_particles_create(global.magic_particle_system, x_pos, y_pos, global.magic_particle, 12);
}

/// @description Spawn essence particles that fly to essence counter
/// @param x_pos
/// @param y_pos
/// @param essence_amount
/// @description Spawn white essence particles that fly to upper left corner
/// @param x_pos
/// @param y_pos
/// @param essence_amount
/// @description Spawn white essence particles that fly to upper left corner
/// @param x_pos
/// @param y_pos
/// @param essence_amount
function scr_spawn_essence_particles(x_pos, y_pos, essence_amount) {
    // Create LOTS of white particles for satisfying burst!
    var particle_count = essence_amount * 8; // Way more particles!
    
    for (var i = 0; i < particle_count; i++) {
        // Create individual particle objects that fly to target
        var particle = instance_create_layer(
            x_pos + random_range(-25, 25),  // Wider spread
            y_pos + random_range(-25, 25), 
            "Effects", 
            o_essence_particle
        );
        
        // Set target position (upper left corner near essence counter)
        particle.target_x = 60 + random_range(-10, 10);  // Slight spread at target
        particle.target_y = 30 + random_range(-5, 5);
        
        // Stagger the flight times more for a flowing effect
        particle.flight_time = random_range(20, 80);
        particle.timer = 0;
    }
}