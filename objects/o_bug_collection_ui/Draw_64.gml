// Only draw when open
if (!is_open) exit;

// Draw sketchbook background
draw_set_color(make_color_rgb(240, 230, 210));  // Aged paper color
draw_rectangle(ui_x, ui_y, ui_x + ui_width, ui_y + ui_height, false);

// Draw border
draw_set_color(c_black);
draw_rectangle(ui_x, ui_y, ui_x + ui_width, ui_y + ui_height, true);

// Title
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(101, 67, 33));  // Dark brown ink
draw_text(ui_x + ui_width/2, ui_y + 10, "Spooky Woods Collection");

// Draw bug grid - 2x2 layout with lots of space
var start_bug = page * bugs_per_page;
var grid_cols = 2;  // 2 across
var grid_rows = 2;  // 2 down  
var cell_width = 180;  // Much bigger cells
var cell_height = 80;

for (var i = 0; i < bugs_per_page; i++) {
    var bug_index = start_bug + i;
    if (bug_index >= total_bugs) break;
    
    var grid_x = i % grid_cols;
    var grid_y = floor(i / grid_cols);
    
    var cell_x = ui_x + 20 + (grid_x * cell_width);
    var cell_y = ui_y + 50 + (grid_y * cell_height);
    
    // Check if discovered using proper object name
    var bug_name = bug_names[bug_index];
    var is_discovered = ds_map_exists(global.discovered_bugs, "o_" + string_lower(string_replace_all(bug_name, " ", "_")));
    
    // Draw larger cell background
    draw_set_color(c_white);
    draw_rectangle(cell_x, cell_y, cell_x + 170, cell_y + 70, false);
    draw_set_color(c_black);
    draw_rectangle(cell_x, cell_y, cell_x + 170, cell_y + 70, true);
    
    // Draw bug number
    draw_set_halign(fa_left);
    draw_set_color(c_black);
    draw_text(cell_x + 5, cell_y + 5, string(bug_index + 1));
    
    if (is_discovered) {
        // Draw actual bug sprite (scaled down from battle size)
        var bug_sprite = bug_sprites[bug_index];
        
        // Draw sprite at smaller scale (since they're 64x64+ for battles)
        draw_sprite_ext(bug_sprite, 0, cell_x + 85, cell_y + 30, 0.6, 0.6, 0, c_white, 1);
        
        // Bug name
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(101, 67, 33));
        draw_text(cell_x + 85, cell_y + 55, bug_names[bug_index]);
        
        // Magical property hint (small text)
        draw_set_color(make_color_rgb(139, 69, 19));
        var properties = [
            "Protection Spells",    // Shadow Beetle
            "Growth Magic",         // Moss Grub
            "Camouflage Potions",   // Bark Crawler
            "Silence Charms",       // Whisper Weevil
            "Agility Brews",        // Glade Hopper
            "Darkness Potions",     // Gloom Mite
            "Night Vision",         // Moonlight Moth
            "Fire Resistance",      // Ember Wasp
            "Flexibility Magic",    // Centipede
            "Ultimate Protection"   // Ancient Shell-Back
        ];
        draw_text(cell_x + 85, cell_y + 65, properties[bug_index]);
        
    } else {
        // Draw silhouette using the same sprite
        var bug_sprite = bug_sprites[bug_index];
        
        // Draw as dark silhouette
        draw_sprite_ext(bug_sprite, 0, cell_x + 85, cell_y + 30, 0.6, 0.6, 0, c_black, 0.3);
        
        draw_set_halign(fa_center);
        draw_set_color(c_black);
        draw_text(cell_x + 85, cell_y + 55, "???");
        draw_text(cell_x + 85, cell_y + 65, "Unknown Reagent");
    }
}

// Page navigation
if (total_pages > 1) {
    draw_set_halign(fa_center);
    draw_set_color(c_black);
    draw_text(ui_x + ui_width/2, ui_y + ui_height - 20, 
              "Page " + string(page + 1) + "/" + string(total_pages) + " (Use Arrow Keys)");
}

// Instructions
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(101, 67, 33));
draw_text(ui_x + ui_width/2, ui_y + ui_height - 5, "Press TAB to close");

// Reset draw settings
draw_set_halign(fa_left);
draw_set_color(c_white);
