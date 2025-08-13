// o_tree_parent - Create Event
//event_inherited(); 
shadow_enabled = true;
shadow_offset_x = 2;        // Horizontal offset from object
shadow_offset_y = 6;        // Vertical offset (positive = below object)
shadow_scale_x = 1.0;       // Horizontal scale of shadow
shadow_scale_y = 0.6;       // Vertical scale (0.6 = flattened)
shadow_alpha = 0.4;         // Transparency (0.4 = semi-transparent)

image_speed = 0;  // Stop animation
image_index = irandom(sprite_get_number(sprite_index) - 1);  // Random frame

// Collision setup - adjust these per tree type
collision_height = 20;  // How many pixels from bottom should block player
trunk_width = 125;       // Width of collision area

// Calculate trunk base position (where collision happens)
trunk_y = y + sprite_height - collision_height;

// Depth sorting - trees sort based on their trunk position
depth = -trunk_y+12;

// Create invisible collision object at trunk level
collision_obj = instance_create_layer(x, trunk_y, "Walls", o_tree_collision);
collision_obj.image_xscale = trunk_width / sprite_get_width(s_tree_collision_mask);
collision_obj.image_yscale = collision_height / sprite_get_height(s_tree_collision_mask);
collision_obj.parent_tree = id;  // Reference back to tree


// Configure shadows for trees
shadow_offset_x = 4;      // Slight offset to the right
shadow_offset_y = 3;      // Below the tree base
shadow_scale_x = 0.8;     // Narrower than tree
shadow_scale_y = 0.4;     // Very flat
shadow_alpha = 0.3;       // More transparent for natural look