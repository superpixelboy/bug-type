// Existing code...
global.bugs_caught = 0;
global.flipped_rocks = ds_list_create();
global.essence =0;


// Add this new map for tracking spawned rocks
if (!variable_global_exists("spawned_rocks")) {
    global.spawned_rocks = ds_map_create();
}

// Position memory
global.return_x = 626;
global.return_y = 525;

//Door Stuff
global.door_cooldown = 0;



// Create particle systems for different hit types
global.dirt_particle_system = part_system_create();
global.gold_particle_system = part_system_create();
global.magic_particle_system = part_system_create();

// Set depth for particles (draw above bugs but below UI)
part_system_depth(global.dirt_particle_system, -10);
part_system_depth(global.gold_particle_system, -10);
part_system_depth(global.magic_particle_system, -10);

// ===========================================
// DIRT PARTICLES (Combo 0-1)  
// ===========================================

// Create dirt particle type
global.dirt_particle = part_type_create();

// SUPER chunky pixels!
part_type_shape(global.dirt_particle, pt_shape_pixel);
part_type_size(global.dirt_particle, 8, 8, 0, 0);

// Brown/tan colors for dirt
part_type_color3(global.dirt_particle, 
    make_color_rgb(139, 89, 42),    // Dark brown
    make_color_rgb(205, 133, 63),   // Light brown  
    make_color_rgb(101, 67, 33));   // Darker brown

// Movement - small burst upward
part_type_direction(global.dirt_particle, 0, 180, 0, 5);
part_type_speed(global.dirt_particle, 1, 3, -0.1, 0);
part_type_gravity(global.dirt_particle, 0.1, 270);

// Fade out quickly
part_type_alpha3(global.dirt_particle, 0.8, 0.6, 0);
part_type_life(global.dirt_particle, 20, 40);

// ===========================================
// GOLD PARTICLES (Combo 2-3)
// ===========================================

global.gold_particle = part_type_create();

// Super chunky pixels for gold!
part_type_shape(global.gold_particle, pt_shape_pixel);
part_type_size(global.gold_particle, 8, 8, 0, 0);

// Golden colors
part_type_color3(global.gold_particle,
    make_color_rgb(255, 215, 0),    // Gold
    make_color_rgb(255, 255, 0),    // Yellow
    make_color_rgb(218, 165, 32));  // Dark gold

// More energetic movement
part_type_direction(global.gold_particle, 0, 360, 0, 5);
part_type_speed(global.gold_particle, 2, 4, -0.05, 0);
part_type_gravity(global.gold_particle, 0.05, 270);

// Twinkle effect
part_type_alpha3(global.gold_particle, 0, 1, 0);
part_type_life(global.gold_particle, 30, 50);

// ===========================================
// MAGIC PARTICLES (Combo 4-5)
// ===========================================

global.magic_particle = part_type_create();

// MEGA chunky magical pixels!
part_type_shape(global.magic_particle, pt_shape_pixel);
part_type_size(global.magic_particle, 8, 8, 0, 0);

// Magical rainbow colors
part_type_color3(global.magic_particle,
    make_color_rgb(147, 0, 211),    // Purple
    make_color_rgb(0, 191, 255),    // Blue
    make_color_rgb(255, 20, 147));  // Pink

// Magical swirling motion
part_type_direction(global.magic_particle, 0, 360, 0, 10);
part_type_speed(global.magic_particle, 2, 4, -0.08, 0);
part_type_gravity(global.magic_particle, -0.02, 90);

// Sparkle and fade
part_type_alpha3(global.magic_particle, 0, 1, 0);
part_type_life(global.magic_particle, 40, 60);

// ===========================================
// PARTICLE SPAWNING SCRIPTS
// ===========================================

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
    // Mix of gold and magic particles for epic effect - MORE PARTICLES!
    part_particles_create(global.gold_particle_system, x_pos, y_pos, global.gold_particle, 12);
    part_particles_create(global.magic_particle_system, x_pos, y_pos, global.magic_particle, 18);
}


// Screen flash variables (add to existing Create Event)
flash_alpha = 0;
flash_duration = 0;
flash_timer = 0;

// Items
global.has_oak_wand = false;
global.has_lucky_clover = false;
global.has_rabbit_foot=false;
global.has_horseshoe=false;


scr_initialize_bug_data()

//For the Bug Selector object
global.next_forced_bug = -1;
display_set_gui_size(960, 540);     // 2× the 480×270 world
gpu_set_texfilter(false);           // nearest-neighbor for crisp downscales/rotations


audio_play_sound(sn_main_theme, 1, true);  // true = loop