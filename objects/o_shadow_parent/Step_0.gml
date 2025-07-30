// obj_shadow_parent - Step Event
// Update shadow position to follow this object
if (shadow_enabled && instance_exists(shadow_instance)) {
    shadow_instance.x = x + shadow_offset_x;
    shadow_instance.y = y + shadow_offset_y;
}