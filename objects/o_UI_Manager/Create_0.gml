// o_UI_Manager Create Event - FIXED: No hardcoded essence reset

// === CORE GAME STATE INITIALIZATION ===
// Only initialize if not already set (prevents overwriting loaded data)
if (!variable_global_exists("essence")) {
    global.essence = 0;
    show_debug_message("Initialized global.essence to 0");
} else {
    show_debug_message("global.essence already exists: " + string(global.essence));
}

if (!variable_global_exists("bugs_caught")) {
    global.bugs_caught = 0;
    show_debug_message("Initialized global.bugs_caught to 0");
} else {
    show_debug_message("global.bugs_caught already exists: " + string(global.bugs_caught));
}

if (!variable_global_exists("flipped_rocks")) {
    global.flipped_rocks = ds_list_create();
    show_debug_message("Created global.flipped_rocks list");
} else {
    show_debug_message("global.flipped_rocks already exists with " + string(ds_list_size(global.flipped_rocks)) + " entries");
}

if (!variable_global_exists("showing_card")) {
    global.showing_card = false;
}

// NEW: Bug catch tracking system
if (!variable_global_exists("bug_catch_counts")) {
    global.bug_catch_counts = ds_map_create();
}

// Add this new map for tracking spawned rocks
if (!variable_global_exists("spawned_rocks")) {
    global.spawned_rocks = ds_map_create();
}

// Initialize discovered bugs map for save system
if (!variable_global_exists("discovered_bugs")) {
    global.discovered_bugs = ds_map_create();
}

// Position memory
global.return_x = 626;
global.return_y = 525;

//Door Stuff
global.door_cooldown = 0;

// Create particle systems for different hit types
global.dirt_particle_system = part_system_create();
global.gold_particle_system = part_system_create();
global.magic_particle_system = part_system_create();

// FIXED: Set much more negative depths so particles show above everything
part_system_depth(global.dirt_particle_system, -20000);    // Above UI elements
part_system_depth(global.gold_particle_system, -20000);    // Above UI elements
part_system_depth(global.magic_particle_system, -20000);   // Above UI elements

// ===========================================
// DIRT PARTICLES (Combo 0-1)  
// ===========================================

// Create dirt particle type
global.dirt_particle = part_type_create();

// SUPER chunky pixels!
part_type_shape(global.dirt_particle, pt_shape_pixel);
part_type_size(global.dirt_particle, 8, 8, 0, 0);

// Brown/tan colors for dirt
part_type_color3(global.dirt_particle, 
    make_color_rgb(139, 89, 42),    // Dark brown
    make_color_rgb(205, 133, 63),   // Light brown  
    make_color_rgb(101, 67, 33));   // Darker brown

// Movement - small burst upward
part_type_direction(global.dirt_particle, 0, 180, 0, 5);
part_type_speed(global.dirt_particle, 1, 3, -0.1, 0);
part_type_gravity(global.dirt_particle, 0.1, 270);

// Fade out quickly
part_type_alpha3(global.dirt_particle, 0.8, 0.6, 0);
part_type_life(global.dirt_particle, 20, 40);

// ===========================================
// GOLD PARTICLES (Combo 2-3)
// ===========================================

global.gold_particle = part_type_create();

// Super chunky pixels for gold!
part_type_shape(global.gold_particle, pt_shape_pixel);
part_type_size(global.gold_particle, 8, 8, 0, 0);

// Golden colors
part_type_color3(global.gold_particle,
    make_color_rgb(255, 215, 0),    // Gold
    make_color_rgb(255, 255, 0),    // Yellow
    make_color_rgb(218, 165, 32));  // Dark gold

// More energetic movement
part_type_direction(global.gold_particle, 0, 360, 0, 5);
part_type_speed(global.gold_particle, 2, 4, -0.05, 0);
part_type_gravity(global.gold_particle, 0.05, 270);

// Twinkle effect
part_type_alpha3(global.gold_particle, 0, 1, 0);
part_type_life(global.gold_particle, 30, 50);

// ===========================================
// MAGIC PARTICLES (Combo 4-5)
// ===========================================

global.magic_particle = part_type_create();

// MEGA chunky magical pixels!
part_type_shape(global.magic_particle, pt_shape_pixel);
part_type_size(global.magic_particle, 8, 8, 0, 0);

// Magical rainbow colors
part_type_color3(global.magic_particle,
    make_color_rgb(147, 0, 211),    // Purple
    make_color_rgb(0, 191, 255),    // Blue
    make_color_rgb(255, 20, 147));  // Pink

// Magical swirling motion
part_type_direction(global.magic_particle, 0, 360, 0, 10);
part_type_speed(global.magic_particle, 2, 4, -0.08, 0);
part_type_gravity(global.magic_particle, -0.02, 90);

// Sparkle and fade
part_type_alpha3(global.magic_particle, 0, 1, 0);
part_type_life(global.magic_particle, 40, 60);

// Screen flash variables (add to existing Create Event)
flash_alpha = 0;
flash_duration = 0;
flash_timer = 0;

// Items
global.has_oak_wand = false;
global.has_lucky_clover = false;
global.has_rabbit_foot=false;
global.has_horseshoe=false;

scr_initialize_bug_data()

//For the Bug Selector object
global.next_forced_bug = -1;
display_set_gui_size(960, 540);     // 2× the 480×270 world
gpu_set_texfilter(false);           // nearest-neighbor for crisp downscales/rotations

// Add to existing Create Event - Essence Orb Fill Variables

// Essence fill effect variables
essence_fill_percentage = 0;  // 0.0 to 1.0 (0% to 100%)
essence_max_capacity = 100;   // Maximum essence for full orb
essence_fill_color = c_purple; // Color of the fill
essence_fill_surface = -1;    // Surface for masking effect

// Optional: Animation variables for smooth filling
target_fill_percentage = 0;
fill_lerp_speed = 0.05;       // How fast the fill animates (0.01 = slow, 0.1 = fast)

// Burst detection
last_essence_amount = 0;      // Track previous essence to detect milestone crossings

// ADD THIS TO YOUR GAME INITIALIZATION (probably in a Game Start event or init script)
// Global essence multipliers based on catch count
global.essence_multiplier_tier1 = 1.0;   // 1-4 catches: normal value
global.essence_multiplier_tier2 = 1.5;   // 5-9 catches: 1.5x bonus  
global.essence_multiplier_tier3 = 2.0;   // 10+ catches: 2x bonus

function get_essence_with_multiplier(base_essence, catch_count) {
    var multiplier = 1.0; // Default 1.0x
    
    if (catch_count >= 10) {
        multiplier = 2.0; // 2.0x for 10+ catches
    } else if (catch_count >= 5) {
        multiplier = 1.5; // 1.5x for 5-9 catches
    }
    
    return ceil(base_essence * multiplier); // Round up to avoid decimals
}

// Function for card display text
function get_essence_display_text(base_essence, catch_count) {
    var final_essence = get_essence_with_multiplier(base_essence, catch_count);
    var multiplier_text = "";
    
    // Show multiplier info for bonuses
    if (catch_count >= 10) {
        multiplier_text = " (x2.0)";
    } else if (catch_count >= 5) {
        multiplier_text = " (x1.5)";
    }
    
    return "Essence: +" + string(final_essence) + multiplier_text;
}

// ESC key cooldown protection
esc_cooldown = 0;  // Frames remaining before ESC can be used again
global.input_cooldown = 0;