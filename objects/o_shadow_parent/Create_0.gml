// obj_shadow_parent - Step Event
// Safety check - initialize if variables don't exist
if (!variable_instance_exists(id, "shadow_enabled")) {
    shadow_enabled = true;
    shadow_offset_x = 0;
    shadow_offset_y = 8;
    shadow_instance = noone;
    
    // Create the shadow instance now
    if (shadow_enabled) {
        shadow_instance = instance_create_layer(x + shadow_offset_x, y + shadow_offset_y, "Instances", o_shadow);
        shadow_instance.owner = id;
    }
}

// Update shadow position to follow this object
if (shadow_enabled && instance_exists(shadow_instance)) {
    shadow_instance.x = x + shadow_offset_x;
    shadow_instance.y = y + shadow_offset_y;
}