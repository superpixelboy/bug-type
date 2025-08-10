// Updated scr_bug_handle_catch function - SIMPLIFIED
// SUPER SIMPLE scr_bug_handle_catch - Just the basics
// Enhanced scr_bug_handle_catch - With correct bug data and gems
// Protected scr_bug_handle_catch with debugging
// ===========================================
// 1. ADD TO o_UI_Manager Create Event (after existing globals)
// ===========================================

// Add this line after your existing global initializations:
if (!variable_global_exists("bug_catch_counts")) {
    global.bug_catch_counts = ds_map_create();
}

// ===========================================
// 2. UPDATE scr_bug_handle_catch function - REPLACE ENTIRE FUNCTION
// ===========================================

function scr_bug_handle_catch() {
    if (state == "ready_to_catch") {
        state = "capturing";
        
        // DEBUG: Check what variables exist
        show_debug_message("=== BUG CATCH DEBUG ===");
        show_debug_message("bug_type: " + string(bug_type));
        
        // Get current catch count for this bug type
        var current_count = 0;
        if (ds_map_exists(global.bug_catch_counts, bug_type)) {
            current_count = ds_map_find_value(global.bug_catch_counts, bug_type);
        }
        
        // Increment catch count
        current_count++;
        ds_map_set(global.bug_catch_counts, bug_type, current_count);
        
        show_debug_message("Catch count for " + string(bug_type) + ": " + string(current_count));
        
        // Calculate bonus essence for milestones
        var bonus_essence = 0;
        var milestone_reached = "";
        
        switch(current_count) {
            case 5:
                bonus_essence = essence_value * 2; // Double essence bonus
                milestone_reached = "5th Catch Bonus!";
                break;
            case 10:
                bonus_essence = essence_value * 3; // Triple essence bonus
                milestone_reached = "10th Catch Bonus!";
                break;
            case 20:
                bonus_essence = essence_value * 5; // 5x essence bonus
                milestone_reached = "20th Catch Master!";
                break;
        }
        
        // Give base + bonus essence
        global.essence += essence_value + bonus_essence;
        
        show_debug_message("Base essence: " + string(essence_value) + ", Bonus: " + string(bonus_essence));
        
        // Register bug discovery
        if (variable_instance_exists(id, "bug_type")) {
            ds_map_set(global.discovered_bugs, bug_type, true);
        }
        
        // Play sound
        audio_play_sound(sn_bug_catch1, 1, false);
        
        // Start capture animation
        capture_timer = 0;
        
        // Create card with count information
        var card = instance_create_layer(room_width/2, room_height + 100, "Instances", o_bug_card);
        
        // Set all the existing card data
        card.bug_type = bug_type;
        card.bug_name = bug_name;
        card.bug_sprite = sprite_index;
        card.essence_value = essence_value;
        card.flavor_text = flavor_text;
        
        // NEW: Set count and bonus info
        card.catch_count = current_count;
        card.bonus_essence = bonus_essence;
        card.milestone_text = milestone_reached;
        
        // Show coin if this isn't the first catch
        if (current_count > 1) {
            card.show_coin = true;
        }
        
        show_debug_message("Card created with count: " + string(card.catch_count));
        
        // Calculate and set gem rarity
        card.bug_rarity_tier = scr_gem_rarity(card.bug_type);
        card.gem_sprite = get_gem_sprite(card.bug_rarity_tier);
        
        // Start the animation
        card.card_state = "flipping_in";
        card.animation_timer = 0;
        
        show_debug_message("Card setup complete!");
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