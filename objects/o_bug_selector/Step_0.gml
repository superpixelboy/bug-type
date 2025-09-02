// o_bug_selector - Enhanced Step Event with Multi-Mode Support
if (menu_active) {
    
    // Input blink timer for cursor
    input_blink_timer = (input_blink_timer + 1) % 60;
    
    // MODE SWITCHING (Q/E keys)
    if (keyboard_check_pressed(ord("Q"))) {
        input_active = false;  // Exit any input mode
        if (console_mode == "bugs") console_mode = "auto_unlock";
        else if (console_mode == "essence") console_mode = "bugs";
        else if (console_mode == "auto_unlock") console_mode = "essence";
        audio_play_sound(sn_bugtap1, 1, false);
    }
    
    if (keyboard_check_pressed(ord("E"))) {
        input_active = false;  // Exit any input mode
        if (console_mode == "bugs") console_mode = "essence";
        else if (console_mode == "essence") console_mode = "auto_unlock";
        else if (console_mode == "auto_unlock") console_mode = "bugs";
        audio_play_sound(sn_bugtap1, 1, false);
    }
    
    // ===== HANDLE INPUT FIELDS =====
    if (input_active) {
        var current_input = "";
        var max_length = 10;
        
        if (console_mode == "essence") {
            current_input = essence_input_value;
        } else if (console_mode == "auto_unlock") {
            current_input = unlock_count_input;
            max_length = 3;
        }
        
        // Handle text input
        var key_string = keyboard_string;
        if (string_length(key_string) > 0) {
            var new_char = string_char_at(key_string, string_length(key_string));
            
            // Only allow numbers for these inputs
            if (string_digits(new_char) != "" && string_length(current_input) < max_length) {
                current_input += new_char;
                
                if (console_mode == "essence") essence_input_value = current_input;
                else if (console_mode == "auto_unlock") unlock_count_input = current_input;
            }
            keyboard_string = "";
        }
        
        // Backspace
        if (keyboard_check_pressed(vk_backspace) && string_length(current_input) > 0) {
            current_input = string_delete(current_input, string_length(current_input), 1);
            
            if (console_mode == "essence") essence_input_value = current_input;
            else if (console_mode == "auto_unlock") unlock_count_input = current_input;
        }
        
        // Confirm input
        if (keyboard_check_pressed(vk_enter)) {
            if (console_mode == "essence" && essence_input_value != "") {
                global.essence = real(essence_input_value);
                show_debug_message("Set essence to: " + string(global.essence));
                audio_play_sound(sn_bug_catch1, 1, false);
            }
            input_active = false;
        }
        
        // Cancel input
        if (keyboard_check_pressed(vk_escape)) {
            input_active = false;
        }
        
        return; // Skip other controls while inputting
    }
    
    // ===== REGULAR NAVIGATION =====
    
    // Navigation based on current mode
    if (console_mode == "bugs" || console_mode == "auto_unlock") {
        var list_size = array_length(bug_list);
        if (list_size > 0) {
            if (keyboard_check_pressed(vk_up)) {
                if (console_mode == "bugs") {
                    selected_index = (selected_index - 1 + list_size) % list_size;
                } else {
                    selected_bug_for_unlock = (selected_bug_for_unlock - 1 + list_size) % list_size;
                }
                audio_play_sound(sn_bugtap1, 1, false);
            }
            if (keyboard_check_pressed(vk_down)) {
                if (console_mode == "bugs") {
                    selected_index = (selected_index + 1) % list_size;
                } else {
                    selected_bug_for_unlock = (selected_bug_for_unlock + 1) % list_size;
                }
                audio_play_sound(sn_bugtap1, 1, false);
            }
        }
    }
    
    // ===== MODE-SPECIFIC ACTIONS =====
    
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        if (console_mode == "bugs") {
            // Original functionality - set next forced bug
            if (array_length(bug_list) > 0) {
                global.next_forced_bug = bug_list[selected_index].id;
                audio_play_sound(sn_bug_catch1, 1, false);
                show_debug_message("Selected bug: " + bug_list[selected_index].name);
            }
            
        } else if (console_mode == "essence") {
            // Start essence input
            input_active = true;
            essence_input_value = string(global.essence);
            
        } else if (console_mode == "auto_unlock") {
            // Auto-unlock bugs directly to collection
            if (unlock_count_input != "" && array_length(bug_list) > 0) {
                var unlock_amount = min(real(unlock_count_input), 99); // Cap at 99
                var selected_bug = bug_list[selected_bug_for_unlock];
                
                // Initialize the bug catch counts system if needed
                if (!variable_global_exists("bug_catch_counts")) {
                    global.bug_catch_counts = ds_map_create();
                }
                
                // Initialize discovered bugs map if needed
                if (!variable_global_exists("discovered_bugs")) {
                    global.discovered_bugs = ds_map_create();
                }
                
                // Mark as discovered
                ds_map_set(global.discovered_bugs, selected_bug.id, true);
                
                // Set or add to catch count
                var current_count = get_bug_catch_count(selected_bug.id);
                var new_count = current_count + unlock_amount;
                ds_map_set(global.bug_catch_counts, selected_bug.id, new_count);
                
                // Give essence based on bug value and count
                var essence_per_bug = selected_bug.essence;
                var total_essence = essence_per_bug * unlock_amount;
                global.essence += total_essence;
                
                show_debug_message("Auto-unlocked " + string(unlock_amount) + "x " + selected_bug.name);
                show_debug_message("Total catches: " + string(new_count));
                show_debug_message("Essence gained: " + string(total_essence));
                
                audio_play_sound(sn_bug_catch1, 1, false);
            }
        }
    }
    
    // Quick essence shortcuts (number keys)
    if (keyboard_check_pressed(ord("1"))) global.essence = 100;
    if (keyboard_check_pressed(ord("2"))) global.essence = 500; 
    if (keyboard_check_pressed(ord("3"))) global.essence = 1000;
    if (keyboard_check_pressed(ord("4"))) global.essence = 5000;
    if (keyboard_check_pressed(ord("5"))) global.essence = 10000;
    
    if (keyboard_check_pressed(ord("1")) || keyboard_check_pressed(ord("2")) || 
        keyboard_check_pressed(ord("3")) || keyboard_check_pressed(ord("4")) || 
        keyboard_check_pressed(ord("5"))) {
        show_debug_message("Quick set essence to: " + string(global.essence));
        audio_play_sound(sn_bug_catch1, 1, false);
    }
    
    // Close menu
    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_f1)) {
        menu_active = false;
    }
}