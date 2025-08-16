// o_wake_up_prompt - Destroy Event

// Make sure hole's sleep functionality is re-enabled when this prompt is destroyed
var hole_obj = instance_find(o_hole, 0);
if (instance_exists(hole_obj)) {
    hole_obj.intro_active = false;  // Re-enable sleep functionality
}