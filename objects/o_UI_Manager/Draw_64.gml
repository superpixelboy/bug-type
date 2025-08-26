// ESSENCE COUNTER WITH FILL EFFECT

// Position and scale
var base_x = 80;
var base_y = 75;
var sprite_scale = 2.0;

// Calculate fill percentage using your math: subtract current 100's from total
// Example: 250 essence = (250 - 200) = 50, so 50% full
var hundreds = floor(global.essence / 100) * 100;  // 200 for 250 essence
var remainder = global.essence - hundreds;          // 250 - 200 = 50
target_fill_percentage = remainder / 100.0;         // 50/100 = 0.5 (50%)

// Smooth animation towards target (optional - remove if you want instant fill)
essence_fill_percentage = lerp(essence_fill_percentage, target_fill_percentage, fill_lerp_speed);

// Get sprite dimensions for masking
var sprite_w = sprite_get_width(s_essence_icon) * sprite_scale;
var sprite_h = sprite_get_height(s_essence_icon) * sprite_scale;

// Step 1: Draw the base orb sprite FIRST (background layer)
draw_sprite_ext(s_essence_icon, 0, base_x, base_y, sprite_scale, sprite_scale, 0, c_white, 1);

// Step 2: Create fill effect using surface masking
if (essence_fill_percentage > 0) {
    
    // Create surface if it doesn't exist
    if (!surface_exists(essence_fill_surface)) {
        essence_fill_surface = surface_create(sprite_w, sprite_h);
    }
    
    // Set surface as target
    surface_set_target(essence_fill_surface);
    
    // Clear surface
    draw_clear_alpha(c_black, 0);
    
    // Draw the fill rectangle (bottom to top based on percentage) - darker shade
    draw_set_color(make_color_rgb(100, 10, 100)); 
    var fill_height = sprite_h * essence_fill_percentage;
    var fill_y = sprite_h - fill_height; // Start from bottom
    draw_rectangle(0, fill_y, sprite_w, sprite_h, false);
    
    // Apply the mask using blend mode
    gpu_set_blendmode(bm_subtract);
    draw_sprite_ext(s_essence_counter_mask, 0, sprite_w/2, sprite_h/2, sprite_scale, sprite_scale, 0, c_white, 1);
    gpu_set_blendmode(bm_normal);
    
    // Stop targeting surface
    surface_reset_target();
    
    // Draw the masked fill over the base orb (middle layer)
    draw_surface(essence_fill_surface, base_x - sprite_w/2, base_y - sprite_h/2);
}

// Step 3: Draw the orb sprite AGAIN on top to show glass details
draw_sprite_ext(s_essence_icon, 0, base_x, base_y, sprite_scale, sprite_scale, 0, c_white, 1);

// Step 4: Draw the essence number on top of everything
draw_set_font(fnt_card_title_2x);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var essence_text = string(global.essence);

// Black outline
draw_set_color(c_black);
draw_text(base_x + 2, base_y + 2, essence_text);
draw_text(base_x - 2, base_y - 2, essence_text);
draw_text(base_x + 2, base_y - 2, essence_text);
draw_text(base_x - 2, base_y + 2, essence_text);

// White text
draw_set_color(c_white);
draw_text(base_x, base_y, essence_text);

// Reset settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);

// Screen flash effect (keep existing)
if (flash_alpha > 0) {
    draw_set_alpha(flash_alpha);
    draw_set_color(c_white);
    draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}