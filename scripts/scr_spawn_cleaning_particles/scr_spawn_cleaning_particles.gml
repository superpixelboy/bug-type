// scr_spawn_cleaning_particles - STRONGER particles for spin cleaning
function scr_spawn_cleaning_particles(x_pos, y_pos) {
    // Create brown dirt particles that fly outward
    for (var i = 0; i < 50; i++) {  // 6 particles per spin frame
        // Random direction outward
        var dir = random(360);
        var dist = random_range(15, 35);
        
        var target_x = x_pos + lengthdir_x(dist, dir);
        var target_y = y_pos + lengthdir_y(dist, dir);
        
        // Create a dirt particle using existing essence particle
        var particle = instance_create_layer(
            x_pos + random_range(-8, 8),
            y_pos + random_range(-8, 8),
            "Instances", 
            o_dust_particle
        );
        
        // Set the particle's target and timing
        if (instance_exists(particle)) {
            particle.target_x = target_x;
            particle.target_y = target_y;
            particle.flight_time = random_range(40, 60);  // LONGER flight time for bigger particles
            
            // STRONGER fade for spin cleaning - much more visible
            particle.fade_style = "ease_out";
            particle.alpha_start = 1.0;      // Start fully opaque
            particle.alpha_end = 0.2;        // Don't fade completely (was 0.0)
        }
    }
}

// scr_spawn_comet_trail - MINIMAL x-axis movement, focused on Y
function scr_spawn_comet_trail(x_pos, y_pos, movement_phase) {
    // Create 2-3 particles per call for a nice dense trail
    for (var i = 0; i < 3; i++) {
        var particle = instance_create_layer(
            x_pos + random_range(-4, 4),     // MUCH smaller x spread (was -12, 12)
            y_pos + random_range(-8, 8),
            "Instances",
            o_dust_particle
        );
        
        if (instance_exists(particle)) {
            // Trail particles behave differently based on movement phase
            if (movement_phase == "rising") {
                // During rise, particles fall downward with minimal x drift - SLOWER
                particle.target_x = x_pos + random_range(-8, 8);   // Small x drift
                particle.target_y = y_pos + random_range(20, 35);  // Shorter fall distance (was 30, 60)
                particle.flight_time = random_range(40, 60);       // MUCH slower (was 25, 40)
            } else if (movement_phase == "falling") {
                // During fall, particles still minimal x movement - SLOWER  
                particle.target_x = x_pos + random_range(-10, 10); // Small x movement
                particle.target_y = y_pos + random_range(15, 25);  // Shorter distance (was 20, 40)
                particle.flight_time = random_range(35, 50);       // MUCH slower (was 20, 35)
            }
            
            // Trail particles fade more subtly but are still visible
            particle.fade_style = "linear";
            particle.alpha_start = 0.8;     // Start strong (was 0.6)
            particle.alpha_end = 0.1;       // Don't fade completely (was 0.0)
        }
    }
}

// scr_spawn_emergence_particles - Keep dramatic but visible
function scr_spawn_emergence_particles(x_pos, y_pos) {
    // Create a BIG burst of dirt particles in all directions
    for (var i = 0; i < 15; i++) {
        // Random direction outward, but favor upward/outward directions
        var dir = random_range(-45, 225);  // Spread from lower-left to lower-right
        var dist = random_range(25, 60);   // Bigger spread than cleaning particles
        
        var target_x = x_pos + lengthdir_x(dist, dir);
        var target_y = y_pos + lengthdir_y(dist, dir);
        
        // Create dirt particle
        var particle = instance_create_layer(
            x_pos + random_range(-5, 5),   // Start closer to player
            y_pos + random_range(-5, 5),
            "Instances",
            o_dust_particle
        );
        
        // Set particle behavior for emergence burst
        if (instance_exists(particle)) {
            particle.target_x = target_x;
            particle.target_y = target_y;
            particle.flight_time = random_range(20, 40);
            
            // Dramatic emergence fade but still visible
            particle.fade_style = "ease_in";
            particle.alpha_start = 1.0;      // Start fully opaque for impact
            particle.alpha_end = 0.15;       // Don't fade completely (was 0.0)
        }
    }
}