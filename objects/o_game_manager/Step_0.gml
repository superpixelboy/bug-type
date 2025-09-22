// o_game_manager - Step Event

// CRITICAL: Update music system every frame
scr_music_update();

// UPDATE INPUT MANAGER EVERY FRAME
scr_update_input_manager();

// ===== COLLECTION TOGGLE - WORKS IN ALL ROOMS =====
// This needs to be in a persistent/global object so it works everywhere

var collection_input = keyboard_check_pressed(vk_tab) || 
                      keyboard_check_pressed(ord("C"));

// Add controller X if available
if (variable_global_exists("input_manager") && global.input_manager.controller_connected) {
    var gp = global.input_manager.controller_slot;
    collection_input = collection_input || gamepad_button_check_pressed(gp, gp_face3);
}

if (collection_input) {
    var collection_ui = instance_find(o_bug_collection_ui, 0);
    if (collection_ui != noone) {
        if (collection_ui.is_open && collection_ui.detail_view_open) {
            collection_ui.detail_view_open = false;
            collection_ui.detail_bug_key = "";
            collection_ui.detail_bug_data = {};
            collection_ui.hovered_card = -1;
            collection_ui.hover_timer = 0;
        } else {
            collection_ui.is_open = !collection_ui.is_open;
            if (collection_ui.is_open) {
                collection_ui.page = 0;
            }
            collection_ui.detail_view_open = false;
            collection_ui.detail_bug_key = "";
            collection_ui.detail_bug_data = {};
            collection_ui.hovered_card = -1;
            collection_ui.hover_timer = 0;
        }
        audio_play_sound(sn_bugtap1, 1, false);
    }
}

// ===== GLOBAL PAUSE MENU HANDLING =====

var pause_input = keyboard_check_pressed(vk_escape);

// Add Start button support
for (var i = 0; i < 12; i++) {
    if (gamepad_is_connected(i)) {
        if (gamepad_button_check_pressed(i, gp_start)) {
            pause_input = true;
            break;
        }
    }
}

if (pause_input) {
    var can_pause = true;
    
    // Don't pause if collection is open
    if (instance_exists(o_bug_collection_ui) && o_bug_collection_ui.is_open) {
        can_pause = false;
    }
    
    // Don't pause during dialogue
    with (o_npc_parent) {
        if (dialogue_active) {
            can_pause = false;
            break;
        }
    }
    
    // Don't pause if player movement is disabled
    if (instance_exists(o_player) && o_player.movement_mode == "disabled") {
        can_pause = false;
    }
    
    // Don't pause if debug console is active
    if (instance_exists(o_bug_selector) && o_bug_selector.menu_active) {
        can_pause = false;
    }
    
    if (can_pause) {
        if (!instance_exists(o_pause_menu)) {
            instance_create_layer(0, 0, "Instances", o_pause_menu);
            if (variable_global_exists("game_paused")) {
                global.game_paused = true;
            }
        } else {
            with (o_pause_menu) {
                instance_destroy();
            }
            if (variable_global_exists("game_paused")) {
                global.game_paused = false;
            }
        }
    }
}