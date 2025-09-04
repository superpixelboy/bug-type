/// @description scr_debug_essence_save - Debug version to track essence saving
function scr_debug_essence_save() {
    show_debug_message("=== DEBUG ESSENCE SAVE TEST ===");
    
    // Show current essence
    show_debug_message("Current global.essence: " + string(global.essence));
    show_debug_message("Type of global.essence: " + typeof(global.essence));
    
    // Create a simple test save with just essence
    var test_data = ds_map_create();
    ds_map_add(test_data, "essence", global.essence);
    ds_map_add(test_data, "test_value", 12345);
    
    show_debug_message("Added to test_data:");
    show_debug_message("  essence: " + string(ds_map_find_value(test_data, "essence")));
    show_debug_message("  test_value: " + string(ds_map_find_value(test_data, "test_value")));
    
    // Convert to string and save
    var test_string = ds_map_write(test_data);
    show_debug_message("Save string length: " + string(string_length(test_string)));
    show_debug_message("Save string preview: " + string_copy(test_string, 1, 100) + "...");
    
    // Write to file
    var file = file_text_open_write("essence_debug.dat");
    if (file != -1) {
        file_text_write_string(file, test_string);
        file_text_close(file);
        show_debug_message("Debug save file written successfully");
    } else {
        show_debug_message("ERROR: Could not create debug save file");
    }
    
    // Test loading immediately
    if (file_exists("essence_debug.dat")) {
        var load_file = file_text_open_read("essence_debug.dat");
        if (load_file != -1) {
            var loaded_string = file_text_read_string(load_file);
            file_text_close(load_file);
            
            var loaded_data = ds_map_create();
            ds_map_read(loaded_data, loaded_string);
            
            var loaded_essence = ds_map_find_value(loaded_data, "essence");
            var loaded_test = ds_map_find_value(loaded_data, "test_value");
            
            show_debug_message("=== LOADED BACK ===");
            show_debug_message("Loaded essence: " + string(loaded_essence));
            show_debug_message("Loaded test_value: " + string(loaded_test));
            show_debug_message("Type of loaded essence: " + typeof(loaded_essence));
            show_debug_message("Essence match: " + string(loaded_essence == global.essence));
            
            ds_map_destroy(loaded_data);
        }
    }
    
    // Clean up
    ds_map_destroy(test_data);
    
    show_debug_message("=== DEBUG ESSENCE SAVE COMPLETE ===");
}