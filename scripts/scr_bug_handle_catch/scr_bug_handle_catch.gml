// Updated scr_bug_handle_catch function
function scr_bug_handle_catch() {
    if (state == "ready_to_catch") {
        state = "capturing";
        
        // Give essence
        global.essence += essence_value;
        
        // ESSENCE PARTICLES (keep these for immediate feedback)
        scr_spawn_essence_particles(x, y, essence_value);
        
        // Register bug discovery
        var bug_type_name = object_get_name(object_index);
        ds_map_set(global.discovered_bugs, bug_type, true);
        
        audio_play_sound(sn_bug_catch1, 1, false);
        
        // Start capture animation (shortened since card will take over)
        capture_timer = 0;
        
        // CREATE CARD AFTER SHORT DELAY
        call_later(30, time_source_units_frames, function() {
            scr_create_bug_card();
        });
    }
}

// Updated scr_create_bug_card function
function scr_create_bug_card() {
    show_debug_message("Creating bug card..."); // DEBUG
    
    var card = instance_create_layer(room_width/2, room_height + 100, "Instances", o_bug_card);
    
    // Pass bug data to card - USE INSTANCE VARIABLES
    card.bug_name = bug_name;        // This comes from the bug instance
    card.bug_sprite = sprite_index;  // This comes from the bug instance - IMPORTANT!
    card.flavor_text = flavor_text;  // This comes from the bug instance
    card.essence_value = essence_value; // This comes from the bug instance
    
    // IMPORTANT: Set the card sprite based on the bug sprite
    card.card_sprite = scr_get_bug_card_sprite(sprite_index);
    
    show_debug_message("Card created with bug: " + bug_name + " using card sprite: " + sprite_get_name(card.card_sprite)); // DEBUG
    
    // Start the flip animation
    card.card_state = "flipping_in";
    card.animation_timer = 0;
    
    return card;
}