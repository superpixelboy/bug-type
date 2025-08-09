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

function scr_create_bug_card() {
    show_debug_message("Creating template-based bug card..."); // DEBUG
		// When creating the card:
	if (!global.showing_card) {
	    global.showing_card = true;
	    var card = instance_create_layer(room_width/2, room_height + 100, "GUI", o_bug_card);
	    // ... set card properties
	}

	// In o_bug_card's destroy event:
	global.showing_card = false;
    
    var card = instance_create_layer(room_width/2, room_height + 100, "Instances", o_bug_card);
    
    // Pass bug data to card
    card.bug_type = bug_type;        
    card.bug_name = bug_name;        
    card.bug_sprite = sprite_index;  
    card.flavor_text = flavor_text;  
    card.essence_value = essence_value; 
    
    // ALWAYS use template now
    card.card_sprite = s_card_template;
    
    // NOW calculate gem rarity (after bug_type is set) - FIXED FUNCTION NAME
    card.bug_rarity_tier = scr_gem_rarity(card.bug_type);
    card.gem_sprite = get_gem_sprite(card.bug_rarity_tier);
    card.gem_float_timer = 0;
    card.gem_glow_timer = 0;
    
    show_debug_message("Card created with bug: " + bug_name + " using template card"); // DEBUG
    show_debug_message("Bug rarity tier: " + string(card.bug_rarity_tier)); // DEBUG
    
    // Start the flip animation
    card.card_state = "flipping_in";
    card.animation_timer = 0;
    
    return card;
}