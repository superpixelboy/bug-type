/// @description Spawn epic particle burst when orb fills completely
/// @param x_pos
/// @param y_pos
function scr_spawn_orb_burst_particles(x_pos, y_pos) {
    
    // MASSIVE burst of magic particles (rainbow colors)
    part_particles_create(global.magic_particle_system, x_pos, y_pos, global.magic_particle, 30);
    
    // Layer in some gold particles for extra sparkle
    part_particles_create(global.gold_particle_system, x_pos, y_pos, global.gold_particle, 25);
    
    // Add some white essence particles flying outward for extra effect
    for (var i = 0; i < 15; i++) {
        var particle = instance_create_layer(
            x_pos + random_range(-10, 10),
            y_pos + random_range(-10, 10),
            "Effects",
            o_essence_particle
        );
        
        if (instance_exists(particle)) {
            // Set particles to fly outward in random directions
            var angle = random(360);
            var distance = random_range(50, 120);
            particle.target_x = x_pos + lengthdir_x(distance, angle);
            particle.target_y = y_pos + lengthdir_y(distance, angle);
            particle.flight_time = random_range(30, 60);
            particle.timer = 0;
        }
    }
}