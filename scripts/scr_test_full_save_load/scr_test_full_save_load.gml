/// @description scr_test_full_save_load - Test the complete save/load cycle
function scr_test_full_save_load() {
    show_debug_message("=== FULL SAVE/LOAD TEST ===");
    
    // Show current state
    show_debug_message("BEFORE SAVE:");
    show_debug_message("  global.essence: " + string(global.essence));
    show_debug_message("  global.bugs_caught: " + string(global.bugs_caught));
    
    // Save current values to compare later
    var original_essence = global.essence;
    var original_bugs = global.bugs_caught;
    
    // Save the game
    show_debug_message("Calling scr_save_game()...");
    var save_result = scr_save_game();
    show_debug_message("Save result: " + string(save_result));
    
    // Modify values to test loading
    show_debug_message("Modifying values for test...");
    global.essence = 999999;
    global.bugs_caught = 888;
    
    show_debug_message("AFTER MODIFICATION:");
    show_debug_message("  global.essence: " + string(global.essence));
    show_debug_message("  global.bugs_caught: " + string(global.bugs_caught));
    
    // Load the game
    show_debug_message("Calling scr_load_game()...");
    var load_result = scr_load_game();
    show_debug_message("Load result: " + string(load_result));
    
    show_debug_message("AFTER LOAD:");
    show_debug_message("  global.essence: " + string(global.essence));
    show_debug_message("  global.bugs_caught: " + string(global.bugs_caught));
    
    // Check if values were restored correctly
    var essence_restored = (global.essence == original_essence);
    var bugs_restored = (global.bugs_caught == original_bugs);
    
    show_debug_message("RESTORATION CHECK:");
    show_debug_message("  Essence restored correctly: " + string(essence_restored));
    show_debug_message("  Bugs restored correctly: " + string(bugs_restored));
    
    if (essence_restored && bugs_restored) {
        show_debug_message("✅ SAVE/LOAD TEST PASSED!");
    } else {
        show_debug_message("❌ SAVE/LOAD TEST FAILED!");
        show_debug_message("Expected essence: " + string(original_essence) + ", got: " + string(global.essence));
        show_debug_message("Expected bugs: " + string(original_bugs) + ", got: " + string(global.bugs_caught));
    }
    
    show_debug_message("=== FULL SAVE/LOAD TEST COMPLETE ===");
}