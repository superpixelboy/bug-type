event_inherited();  // Call parent create

// Override collision settings for oak trees
collision_height = 5;  // Shorter collision
trunk_width = 5;       // Wider trunk

depth = -trunk_y+5;
// Update collision object with new settings
if (instance_exists(collision_obj)) {
    collision_obj.image_xscale = trunk_width / sprite_get_width(s_tree_collision_mask);
    collision_obj.image_yscale = collision_height / sprite_get_height(s_tree_collision_mask);
}