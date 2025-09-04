/// @description scr_has_save_data - Check if save file exists
function scr_has_save_data() {
    return file_exists("witchbug_save.dat");
}