// o_tree_parent - Create Event


image_speed = 0;  // Stop animation
image_index = irandom(sprite_get_number(sprite_index) - 1);  // Random frame

// Collision setup - adjust these per tree type
collision_height = 32;  // How many pixels from bottom should block player
trunk_width = 24;       // Width of collision area

// Calculate trunk base position (where collision happens)
trunk_y = y + sprite_height - collision_height;

// Depth sorting - trees sort based on their trunk position
depth = -trunk_y+15;

// Create invisible collision object at trunk level
collision_obj = instance_create_layer(x, trunk_y, "Walls", o_tree_collision);
collision_obj.image_xscale = trunk_width / sprite_get_width(s_tree_collision_mask);
collision_obj.image_yscale = collision_height / sprite_get_height(s_tree_collision_mask);
collision_obj.parent_tree = id;  // Reference back to tree