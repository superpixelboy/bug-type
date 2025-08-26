/// @description Epic burst with LOTS of purple particles, no system particles
/// @param x_pos
/// @param y_pos
function scr_spawn_orb_burst_particles(x_pos, y_pos) {
    
    show_debug_message(">>> PURPLE BURST STARTING <<<");
    
    // NO system particles at all
    // part_particles_create(global.magic_particle_system, x_pos, y_pos, global.magic_particle, 30);
    // part_particles_create(global.gold_particle_system, x_pos, y_pos, global.gold_particle, 25);
    
    // Create LOTS of custom purple burst particles
    var directions = [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330];  // 12 directions instead of 8
    var particles_created = 0;
    
    // First ring: Main directional particles
    for (var i = 0; i < array_length(directions); i++) {
        var particle = instance_create_layer(
            x_pos + random_range(-3, 3),
            y_pos + random_range(-3, 3),
            "Effects",
            o_burst_particle
        );
        
        if (instance_exists(particle)) {
            particles_created++;
            var angle = directions[i];
            var distance = random_range(70, 110);  // Fly farther
            
            particle.target_x = x_pos + (cos(degtorad(angle)) * distance);
            particle.target_y = y_pos + (sin(degtorad(angle)) * distance);
            particle.flight_time = random_range(50, 80);  // Longer flight time
            particle.timer = 0;
        }
    }
    
    // Second ring: More random particles for density
    for (var j = 0; j < 25; j++) {  // Even MORE particles
        var particle = instance_create_layer(
            x_pos + random_range(-8, 8),  // Wider spawn area
            y_pos + random_range(-8, 8),
            "Effects",
            o_burst_particle
        );
        
        if (instance_exists(particle)) {
            particles_created++;
            var random_angle = random(360);
            var distance = random_range(40, 130);  // Varied distances
            
            particle.target_x = x_pos + (cos(degtorad(random_angle)) * distance);
            particle.target_y = y_pos + (sin(degtorad(random_angle)) * distance);
            particle.flight_time = random_range(35, 75);
            particle.timer = 0;
        }
    }
    
    // Third ring: Close particles for immediate impact
    for (var k = 0; k < 15; k++) {
        var particle = instance_create_layer(
            x_pos + random_range(-5, 5),
            y_pos + random_range(-5, 5),
            "Effects",
            o_burst_particle
        );
        
        if (instance_exists(particle)) {
            particles_created++;
            var close_angle = random(360);
            var close_distance = random_range(25, 60);  // Shorter distances
            
            particle.target_x = x_pos + (cos(degtorad(close_angle)) * close_distance);
            particle.target_y = y_pos + (sin(degtorad(close_angle)) * close_distance);
            particle.flight_time = random_range(25, 45);  // Faster completion
            particle.timer = 0;
        }
    }
    
    show_debug_message("Created " + string(particles_created) + " PURPLE particles (no system particles!)");
    show_debug_message(">>> PURPLE BURST COMPLETE <<<");
}