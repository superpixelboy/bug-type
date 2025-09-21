global.current_location = "Apple_Grove";  
//randomize();
// rm_spooky_forest Room Creation Code
// Add fade-in effect when entering this room

// Only create fade if one doesn't already exist
if (!instance_exists(o_fade_controller)) {
    var fade = instance_create_layer(0, 0, "Instances", o_fade_controller);
    fade.fade_alpha = 1; // Start black
    fade.fade_state = "fade_in"; // Use the existing fade_in state
    fade.fade_speed = 0.04; // Adjust speed as needed
}