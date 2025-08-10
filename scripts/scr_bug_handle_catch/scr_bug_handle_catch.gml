// Debug version of scr_bug_handle_catch
function scr_bug_handle_catch() {
    // Make sure we're being called from a bug instance
    if (!variable_instance_exists(id, "bug_species")) {
        show_debug_message("ERROR: scr_bug_handle_catch called from non-bug object!");
        return;
    }
    
    if (state == "ready_to_catch") {
        state = "capturing";
        
        show_debug_message("=== CATCHING BUG ===");
        show_debug_message("Bug species: " + string(bug_species));
        show_debug_message("Bug name: " + string(bug_name));
        
        // Get current catch count for this bug type
        var current_count = 0;
        if (ds_map_exists(global.bug_catch_counts, bug_species)) {
            current_count = ds_map_find_value(global.bug_catch_counts, bug_species);
        }
        
        // Increment catch count
        current_count++;
        ds_map_set(global.bug_catch_counts, bug_species, current_count);
        
        show_debug_message("Catch count for " + string(bug_species) + ": " + string(current_count));
        
        // Calculate bonus essence for milestones
        var bonus_essence = 0;
        var milestone_reached = "";
        
        switch(current_count) {
            case 5:
                bonus_essence = essence_value * 2;
                milestone_reached = "5th Catch Bonus!";
                break;
            case 10:
                bonus_essence = essence_value * 3;
                milestone_reached = "10th Catch Bonus!";
                break;
            case 20:
                bonus_essence = essence_value * 5;
                milestone_reached = "20th Catch Master!";
                break;
        }
        
        // Give base + bonus essence
        global.essence += essence_value + bonus_essence;
        
        // Register bug discovery
        ds_map_set(global.discovered_bugs, bug_species, true);
        
        // Play sound
        audio_play_sound(sn_bug_catch1, 1, false);
        
        // Start capture animation
        capture_timer = 0;
        
        // DEBUG: Check actual card instances
        show_debug_message("Current card instances: " + string(instance_number(o_bug_card)));
        show_debug_message("global.showing_card: " + string(global.showing_card));
        
        // Fix inconsistent state
        if (instance_number(o_bug_card) == 0) {
            show_debug_message("No card exists, resetting flag...");
            global.showing_card = false;
        }
        
        // Check for existing cards before creating
        if (global.showing_card || instance_number(o_bug_card) > 0) {
            show_debug_message("BLOCKED: Card already showing!");
            show_debug_message("Flag: " + string(global.showing_card) + ", Instances: " + string(instance_number(o_bug_card)));
            return;
        }
        
        // Create card with count information
        show_debug_message("Creating new card...");
        global.showing_card = true;
        
        var card = instance_create_layer(room_width/2, room_height + 100, "Instances", o_bug_card);
        
        // Make sure card was created successfully
        if (!instance_exists(card)) {
            show_debug_message("ERROR: Failed to create card!");
            global.showing_card = false;
            return;
        }
        
        show_debug_message("Card created successfully! ID: " + string(card));
        
        // Set all the card data using WITH to ensure proper scope
        with (card) {
            // Initialize card variables first
            bug_species = other.bug_species;
            bug_name = other.bug_name;
            bug_sprite = other.sprite_index;
            essence_value = other.essence_value;
            flavor_text = other.flavor_text;
            
            // Set count and bonus info
            catch_count = current_count;
            bonus_essence = bonus_essence;
            milestone_text = milestone_reached;
            
            // Always show coin
            show_coin = true;
            
            // Calculate and set gem rarity
            bug_rarity_tier = scr_gem_rarity(bug_species);
            gem_sprite = get_gem_sprite(bug_rarity_tier);
            
            // Start the animation
            card_state = "flipping_in";
            animation_timer = 0;
            
            show_debug_message("Card data set: " + bug_name);
        }
        
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
    card.bug_species = bug_species;        
    card.bug_name = bug_name;        
    card.bug_sprite = sprite_index;  
    card.flavor_text = flavor_text;  
    card.essence_value = essence_value; 
    
    // ALWAYS use template now
    card.card_sprite = s_card_template;
    
    // Calculate gem rarity
    card.bug_rarity_tier = scr_gem_rarity(card.bug_species);
    card.gem_sprite = get_gem_sprite(card.bug_rarity_tier);
    card.gem_float_timer = 0;
    card.gem_glow_timer = 0;
    
    show_debug_message("Card created successfully with bug: " + bug_name);
    
    // Start the flip animation
    card.card_state = "flipping_in";
    card.animation_timer = 0;
    
    return card;
}