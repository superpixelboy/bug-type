// scr_bug_handle_catch - Updated with catch count tracking
function scr_bug_handle_catch() {
    if (state != "ready_to_catch") return;

    state = "capturing";

    // === DEBUG: What does this bug instance have?
    show_debug_message("=== BUG CATCH DEBUG ===");
    show_debug_message("bug_type exists: " + string(variable_instance_exists(id, "bug_type")));
    show_debug_message("bug_name exists: " + string(variable_instance_exists(id, "bug_name")));
    show_debug_message("flavor_text exists: " + string(variable_instance_exists(id, "flavor_text")));

    // NEW: Track catch count and check for tier advancement
    var old_count = 0;
    var new_count = 1;
    var bonus_essence = 0;
    
    if (variable_instance_exists(id, "bug_type")) {
        old_count = get_bug_catch_count(bug_type);
        new_count = increment_bug_catch_count(bug_type);
        
        // Check if we advanced a coin tier and award bonus essence
        if (check_coin_tier_advancement(old_count, new_count)) {
            var new_tier = get_coin_tier_from_count(new_count);
            bonus_essence = get_tier_advancement_bonus(new_tier);
            
            show_debug_message("COIN TIER ADVANCEMENT! " + bug_type + " reached tier " + string(new_tier) + " (count: " + string(new_count) + ")");
            show_debug_message("Bonus essence awarded: " + string(bonus_essence));
        }
    }

    // Give essence (base + bonus)
    global.essence += essence_value + bonus_essence;

    // Register bug discovery safely
    if (variable_instance_exists(id, "bug_type")) {
        ds_map_set(global.discovered_bugs, bug_type, true);
    }

    // Play sound & start capture timer
    audio_play_sound(sn_bug_catch1, 1, false);
    capture_timer = 0;

    // SPAWN PARTICLES! 
    scr_spawn_catch_particles(x, y);  // Existing catch particles
    
    // TODO: Add essence particle function if it exists
    // scr_spawn_essence_particles(x, y, essence_value + bonus_essence);

    // === Ensure exactly one card exists ===
    // Kill any existing card FIRST (prevents "create then destroy the new one" race)
    var existing = instance_find(o_bug_card, 0);
    if (instance_exists(existing)) {
        with (existing) instance_destroy();
    }
    global.showing_card = false;

    // Create the card
    var card = instance_create_layer(room_width / 2, room_height + 100, "Instances", o_bug_card);

    // Sanity check creation
    if (!instance_exists(card)) {
        show_debug_message("ERROR: Failed to create o_bug_card instance.");
        return;
    }

    // Assign fields inside the instance context (avoids read-only/lvalue edge cases)
    with (card) {
        // Pull values from the catching bug (other = the bug that called the script)
        // type_id
        if (variable_instance_exists(other.id, "bug_type")) {
            type_id = other.bug_type;
        } else {
            type_id = "unknown";
            show_debug_message("WARNING: bug_type not found, using 'unknown'");
        }

        // bug_name
        if (variable_instance_exists(other.id, "bug_name")) {
            bug_name = other.bug_name;
        } else {
            bug_name = "Mystery Bug";
            show_debug_message("WARNING: bug_name not found, using 'Mystery Bug'");
        }

        // flavor_text
        if (variable_instance_exists(other.id, "flavor_text")) {
            flavor_text = other.flavor_text;
        } else {
            flavor_text = "A mysterious creature";
            show_debug_message("WARNING: flavor_text not found, using default");
        }

        // sprite & values copied directly
        bug_sprite     = other.sprite_index;
        essence_value  = other.essence_value;

        // NEW: Store the bonus essence for display
        if (variable_instance_exists(id, "bonus_essence")) {
            bonus_essence = other.bonus_essence;
        } else {
            // Create the variable if it doesn't exist
            bonus_essence = other.bonus_essence;
        }

        // Visuals
        card_sprite    = s_card_template;

        // Rarity calc (uses type_id now, not bug_type)
        if (type_id != "unknown") {
            bug_rarity_tier = scr_gem_rarity(type_id);
            gem_sprite      = get_gem_sprite(bug_rarity_tier);
        } else {
            bug_rarity_tier = 5;                // default very common
            gem_sprite      = s_gem_very_common;
        }

        gem_float_timer = 0;
        gem_glow_timer  = 0;

        // Start animation
        card_state      = "flipping_in";
        animation_timer = 0;

        show_debug_message("Card created for bug: " + bug_name + " | rarity tier: " + string(bug_rarity_tier));
  
		 update_coin_display();
        
        show_debug_message("Catch card coin updated: " + bug_name + " (catch count: " + string(coin_value) + ")");
	
  }

    global.showing_card = true;
}
/*
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
    
    // Pass bug data to card
    // Pass bug data to card - NOW we can access the bug's variables directly
    card.bug_type = bug_type;        
    card.bug_name = bug_name;        
    card.bug_sprite = sprite_index;  
}
function scr_create_bug_card() {
    // ALWAYS use template now
    card.card_sprite = s_card_template;
    
    // NOW calculate gem rarity (after bug_type is set) - FIXED FUNCTION NAME
    // Calculate gem rarity
    card.bug_rarity_tier = scr_gem_rarity(card.type_id);
    card.gem_sprite = get_gem_sprite(card.bug_rarity_tier);
    card.gem_float_timer = 0;
    card.gem_glow_timer = 0;
    
    show_debug_message("Card created with bug: " + bug_name + " using template card"); // DEBUG
    show_debug_message("Bug rarity tier: " + string(card.bug_rarity_tier)); // DEBUG
    show_debug_message("Card created successfully with bug: " + bug_name);
    
    // Start the flip animation
    card.card_state = "flipping_in";
}
*/