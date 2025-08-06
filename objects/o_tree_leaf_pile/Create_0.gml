event_inherited();  // Call parent create

// Override collision settings for oak trees
collision_height = 5;  // Shorter collision
trunk_width = 5;       // Wider trunk

depth = -trunk_y;
// Update collision object with new settings
if (instance_exists(collision_obj)) {
    collision_obj.image_xscale = trunk_width / sprite_get_width(s_tree_collision_mask);
    collision_obj.image_yscale = collision_height / sprite_get_height(s_tree_collision_mask);
}

// Configure shadows for leaves
shadow_offset_x = 2;      // Slight offset to the right
shadow_offset_y = +7;      // Below the tree base
shadow_scale_x = 1.2;     // Narrower than tree
shadow_scale_y = 0.6;     // Very flat
shadow_alpha = 0.3;       // More transparent for natural 
// obj_bush - Create Event
shake_timer = 0;
shake_intensity = 0;
shake_duration = 20; // frames
shake_max_intensity = 3; // pixels

original_x = x;
original_y = y;

// Particle system setup
particle_system = part_system_create();
particle_type = part_type_create();

// Configure leaf particles
part_type_sprite(particle_type, s_essence_particle, false, false, false); // Use your existing particle sprite
part_type_life(particle_type, 15, 25); // Much shorter life - only 15-25 frames
part_type_speed(particle_type, 0.5, 2, 0, 0); // Speed range with acceleration parameters
part_type_direction(particle_type, 0, 360, 0, 0); // All directions
part_type_gravity(particle_type, 0.1, 270); // Slight downward gravity
part_type_alpha2(particle_type, 1, .5); // Fade out over time
part_type_scale(particle_type, 0.5, 0.8); // Small particles
part_type_color1(particle_type,c_orange); // Natural forest green

// Cooldown to prevent constant shaking
shake_cooldown = 0;