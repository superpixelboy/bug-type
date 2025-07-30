// obj_shadow_parent - Destroy Event
// Clean up shadow when parent object is destroyed
if (instance_exists(shadow_instance)) {
    instance_destroy(shadow_instance);
}