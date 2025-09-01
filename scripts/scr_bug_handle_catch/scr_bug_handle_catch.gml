// scr_bug_handle_catch - Fixed version without bonus_essence assignment error
// scr_bug_handle_catch - FIXED: Add missing essence particles
function scr_bug_handle_catch() {
    if (state != "ready_to_catch") return;

    state = "capturing";

    // === DEBUG: What does this bug instance have?
    show_debug_message("=== BUG CATCH DEBUG ===");
    show_debug_message("bug_type exists: " + string(variable_instance_exists(id, "bug_type")));
    show_debug_message("bug_name exists: " + string(variable_instance_exists(id, "bug_name")));
    show_debug_message("flavor_text exists: " + string(variable_instance_exists(id, "flavor_text")));

   // NEW: Track catch count and calculate multiplier bonus
    var old_count = 0;
    var new_count = 1;
    var milestone_bonus = 0;  // One-time bonus for reaching new tier
    var essence_multiplier = 1.0;  // Ongoing multiplier for this catch
    
    if (variable_instance_exists(id, "bug_type")) {
        old_count = get_bug_catch_count(bug_type);
        new_count = increment_bug_catch_count(bug_type);
        
        // Get multiplier based on NEW count (after this catch)
        essence_multiplier = get_essence_multiplier_from_count(new_count);
        
        // Check if we advanced a coin tier for milestone bonus
        if (check_coin_tier_advancement(old_count, new_count)) {
            var new_tier = get_coin_tier_from_count(new_count);
            milestone_bonus = get_tier_advancement_bonus(new_tier);
            
            show_debug_message("COIN TIER ADVANCEMENT! " + bug_type + " reached tier " + string(new_tier) + " (count: " + string(new_count) + ")");
            show_debug_message("Milestone bonus: " + string(milestone_bonus));
            show_debug_message("New multiplier: " + string(essence_multiplier) + "x");
        }
    }

    // Calculate final essence: (base * multiplier) + milestone bonus
    var base_essence = essence_value;
    var multiplied_essence = base_essence * essence_multiplier;
    var total_essence = multiplied_essence + milestone_bonus;
    
    show_debug_message("Essence calculation: " + string(base_essence) + " * " + string(essence_multiplier) + " + " + string(milestone_bonus) + " = " + string(total_essence));
    
    // Give essence
    global.essence += total_essence;

    // Register bug discovery safely
    if (variable_instance_exists(id, "bug_type")) {
        ds_map_set(global.discovered_bugs, bug_type, true);
    }

    // Play sound & start capture timer
    audio_play_sound(sn_bug_catch1, 1, false);
    capture_timer = 0;

    // SPAWN PARTICLES - FIXED: Add the missing essence particles!
    scr_spawn_catch_particles(x, y);  // Existing catch particles
    
    // MISSING: Spawn the white essence particles that fly to the essence counter
    scr_spawn_essence_particles(x, y, total_essence);

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
        
        // Update coin display with real catch count
        update_coin_display();
        show_debug_message("Card created for bug: " + bug_name + " | rarity tier: " + string(bug_rarity_tier));
    }
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