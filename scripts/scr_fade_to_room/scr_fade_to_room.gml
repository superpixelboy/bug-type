// scr_fade_to_room(target_room, [fade_type], [speed])
// Easy function to fade out and go to a room
function scr_fade_to_room(target_room, fade_type = "normal", speed = 0.03) {
    if (!instance_exists(o_fade_controller)) {
        var fade = instance_create_layer(0, 0, "Instances", o_fade_controller);
        fade.fade_state = "fade_out";
        fade.target_room = target_room;
        fade.action_to_perform = "room_transition";
        fade.fade_speed = speed;
        fade.room_transition_type = fade_type;
        return fade;
    }
    return noone;
}

// scr_fade_in_room([speed])
// Easy function to fade in when entering a room
function scr_fade_in_room(speed = 0.04) {
    if (!instance_exists(o_fade_controller)) {
        var fade = instance_create_layer(0, 0, "Instances", o_fade_controller);
        fade.fade_alpha = 1; // Start black
        fade.fade_state = "room_entry";
        fade.fade_speed = speed;
        return fade;
    }
    return noone;
}

// scr_fade_for_intro(target_room)
// Special fade for intro sequences
function scr_fade_for_intro(target_room) {
    if (!instance_exists(o_fade_controller)) {
        var fade = instance_create_layer(0, 0, "Instances", o_fade_controller);
        fade.fade_state = "fade_out";
        fade.target_room = target_room;
        fade.action_to_perform = "intro_transition";
        fade.fade_speed = 0.02; // Slower for dramatic effect
        return fade;
    }
    return noone;
}

// scr_quick_fade(target_room)
// Fast fade for gameplay transitions
function scr_quick_fade(target_room) {
    if (!instance_exists(o_fade_controller)) {
        var fade = instance_create_layer(0, 0, "Instances", o_fade_controller);
        fade.fade_state = "quick_out";
        fade.target_room = target_room;
        fade.fade_speed = 0.05; // Faster
        return fade;
    }
    return noone;
}