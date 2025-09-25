/// @description Debug function to grant/remove items for testing
/// Call this in a Step event with keyboard shortcuts

function scr_debug_items() {
    // Press SHIFT + 1 to toggle Lucky Clover
    if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("1"))) {
        if (!variable_global_exists("has_lucky_clover")) {
            global.has_lucky_clover = false;
        }
        global.has_lucky_clover = !global.has_lucky_clover;
        
        var status = global.has_lucky_clover ? "GIVEN" : "REMOVED";
        show_debug_message("DEBUG: Lucky Clover " + status);
        audio_play_sound(sn_bug_catch1, 1, false);
    }
    
    // Press SHIFT + 2 to toggle Oak Wand
    if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("2"))) {
        if (!variable_global_exists("has_oak_wand")) {
            global.has_oak_wand = false;
        }
        global.has_oak_wand = !global.has_oak_wand;
        
        var status = global.has_oak_wand ? "GIVEN" : "REMOVED";
        show_debug_message("DEBUG: Oak Wand " + status);
        audio_play_sound(sn_bug_catch1, 1, false);
    }
    
    // Press SHIFT + 3 to complete Find Baba Yaga quest
    if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("3"))) {
        var quest = scr_get_quest("find_baba_yaga");
        if (quest != undefined && quest.status == "active") {
            if (quest.on_complete != undefined) {
                quest.on_complete();
            }
            show_debug_message("DEBUG: Completed Find Baba Yaga quest");
            audio_play_sound(sn_bug_catch1, 1, false);
        }
    }
    
    // Press SHIFT + 4 to complete Summoning Spell quest (if active)
    if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("4"))) {
        var quest = scr_get_quest("summoning_spell");
        if (quest != undefined && quest.status == "active") {
            if (quest.on_complete != undefined) {
                quest.on_complete();
            }
            show_debug_message("DEBUG: Completed Summoning Spell quest");
            audio_play_sound(sn_bug_catch1, 1, false);
        }
    }
    
    // Press SHIFT + 0 to give ALL items
    if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("0"))) {
        global.has_lucky_clover = true;
        global.has_oak_wand = true;
        
        show_debug_message("DEBUG: ALL ITEMS GIVEN");
        audio_play_sound(sn_bug_catch1, 1, false);
    }
    
    // Press SHIFT + 9 to remove ALL items
    if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("9"))) {
        global.has_lucky_clover = false;
        global.has_oak_wand = false;
        
        show_debug_message("DEBUG: ALL ITEMS REMOVED");
        audio_play_sound(sn_rock_click, 1, false);
    }
}