
event_inherited(); 
image_speed = 1;
// Override collision settings for oak trees
collision_height = 5;  // Shorter collision
trunk_width = 5;       // Wider trunk

depth = -trunk_y+5;
// Update collision object with new settings
if (instance_exists(collision_obj)) {
    collision_obj.image_xscale = trunk_width / sprite_get_width(s_tree_collision_mask);
    collision_obj.image_yscale = collision_height / sprite_get_height(s_tree_collision_mask);
}

// Configure shadows for trees
shadow_offset_x = 4;      // Slight offset to the right
shadow_offset_y = 3;      // Below the tree base
shadow_scale_x = 1;     // Narrower than tree
shadow_scale_y = 0.4;     // Very flat
shadow_alpha = 0.3;       // More transparent for natural look