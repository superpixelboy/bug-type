// Updated scr_bug_handle_catch function - SIMPLIFIED
// SUPER SIMPLE scr_bug_handle_catch - Just the basics
// Enhanced scr_bug_handle_catch - With correct bug data and gems
// Protected scr_bug_handle_catch with debugging
function scr_bug_handle_catch() {
    if (state == "ready_to_catch") {
        state = "capturing";
        
        // DEBUG: Check what variables exist
        show_debug_message("=== BUG CATCH DEBUG ===");
        show_debug_message("bug_type exists: " + string(variable_instance_exists(id, "bug_type")));
        show_debug_message("bug_name exists: " + string(variable_instance_exists(id, "bug_name")));
        
        // Give essence
        global.essence += essence_value;
        
        // Register bug discovery - use safe method
        if (variable_instance_exists(id, "bug_type")) {
            ds_map_set(global.discovered_bugs, bug_type, true);
        }
        
        // Play sound
        audio_play_sound(sn_bug_catch1, 1, false);
        
        // Start capture animation
        capture_timer = 0;
        
        // Create card immediately
        var card = instance_create_layer(room_width/2, room_height + 100, "Instances", o_bug_card);
        
        // Set card data SAFELY - check if variables exist first
        if (variable_instance_exists(id, "bug_type")) {
            card.bug_type = bug_type;
        } else {
            card.bug_type = "unknown";
            show_debug_message("WARNING: bug_type not found, using 'unknown'");
        }
        
        if (variable_instance_exists(id, "bug_name")) {
            card.bug_name = bug_name;
        } else {
            card.bug_name = "Mystery Bug";
            show_debug_message("WARNING: bug_name not found, using 'Mystery Bug'");
        }
        
        card.bug_sprite = sprite_index;
        card.essence_value = essence_value;
        
        if (variable_instance_exists(id, "flavor_text")) {
            card.flavor_text = flavor_text;
        } else {
            card.flavor_text = "A mysterious creature";
            show_debug_message("WARNING: flavor_text not found, using default");
        }
        
        // Calculate and set gem rarity - with protection
        if (variable_instance_exists(id, "bug_type") && bug_type != "unknown") {
            card.bug_rarity_tier = scr_gem_rarity(card.bug_type);
            card.gem_sprite = get_gem_sprite(card.bug_rarity_tier);
        } else {
            card.bug_rarity_tier = 5;  // Default to very common
            card.gem_sprite = s_gem_very_common;
        }
        
        // Start the animation
        card.card_state = "flipping_in";
        card.animation_timer = 0;
        
        show_debug_message("Card created successfully!");
    }
}

function scr_create_bug_card_immediate() {
    show_debug_message("=== CREATE BUG CARD CALLED ===");
    show_debug_message("Current showing_card flag: " + string(global.showing_card));
    show_debug_message("Existing card count: " + string(instance_number(o_bug_card)));
    
    // Prevent multiple cards
    if (global.showing_card) {
        show_debug_message("BLOCKED: Card already showing!");
        return noone;
    }
    
    if (instance_number(o_bug_card) > 0) {
        show_debug_message("BLOCKED: Card instance already exists!");
        return noone;
    }
    
    show_debug_message("Creating new card...");
    global.showing_card = true;
    
    // Create card on "Instances" layer
    var card = instance_create_layer(room_width/2, room_height + 100, "Instances", o_bug_card);
    
    // Pass bug data to card - NOW we can access the bug's variables directly
    card.bug_type = bug_type;        
    card.bug_name = bug_name;        
    card.bug_sprite = sprite_index;  
    card.flavor_text = flavor_text;  
    card.essence_value = essence_value; 
    
    // ALWAYS use template now
    card.card_sprite = s_card_template;
    
    // Calculate gem rarity
    card.bug_rarity_tier = scr_gem_rarity(card.bug_type);
    card.gem_sprite = get_gem_sprite(card.bug_rarity_tier);
    card.gem_float_timer = 0;
    card.gem_glow_timer = 0;
    
    show_debug_message("Card created successfully with bug: " + bug_name);
    
    // Start the flip animation
    card.card_state = "flipping_in";
    card.animation_timer = 0;
    
    return card;
}