/// o_bug_card Draw GUI Event - FIXED VERSION

// 1) Early exits
if (card_state == "hidden" || card_state == "waiting") exit;

// 2) World -> GUI
var cam = view_camera[0];
var vx  = camera_get_view_x(cam);
var vy  = camera_get_view_y(cam);

// GUI is 2× the view
var gui_x = (x - vx) * 2;
var gui_y = (y - vy) * 2;

// 3) Card dimensions in GUI space
var frame_w_gui = sprite_get_width(s_card_template)  * card_scale_x * 2;
var frame_h_gui = sprite_get_height(s_card_template) * card_scale_y * 2;

// 4) Pixel-perfect basis (top-left + derived center)
var tl_x  = round(gui_x - frame_w_gui * 0.5);
var tl_y  = round(gui_y - frame_h_gui * 0.5);
var cx_gui = tl_x + frame_w_gui * 0.5;
var cy_gui = tl_y + frame_h_gui * 0.5;

// 5) Flip state (which side + x-scale squash)
var card_frame = 0;           // 0 = back, 1 = front
var show_front_content = false;

if (card_state == "flipping_in") {
    if (flip_progress < 0.5) { card_frame = 0; show_front_content = false; }
    else                      { card_frame = 1; show_front_content = true;  }
} else if (card_state == "showing") {
    card_frame = 1; show_front_content = true;
} else if (card_state == "flipping_out") {
    if (flip_progress < 0.5) { card_frame = 1; show_front_content = true;  }
    else                      { card_frame = 0; show_front_content = false; }
}

var flip_t = clamp(flip_progress, 0, 1);
var flip_scale = (card_state == "flipping_in" || card_state == "flipping_out")
    ? abs(dcos(flip_t * 180)) : 1;

// template is 1x art drawn into 2x GUI
var scale_x_template = (card_scale_x * 2) * flip_scale;
var scale_y_template = (card_scale_y * 2);

// surface is already 2x, so no extra *2
var scale_x_surface = (card_scale_x) * flip_scale;
var scale_y_surface = (card_scale_y);

// ----------------- DROP SHADOW -----------------
var shadow_offset_x = 8;  // Pixels to the right
var shadow_offset_y = 8;  // Pixels down
var shadow_alpha = 0.4;   // Semi-transparent

draw_sprite_ext(
    s_card_template, card_frame,
    cx_gui + shadow_offset_x, cy_gui + shadow_offset_y,  // Offset position
    scale_x_template, scale_y_template,
    card_rotation,
    c_black, shadow_alpha * image_alpha  // Black color, reduced alpha
);

// ----------------- CARD BACKGROUND -----------------
draw_sprite_ext(
    s_card_template, card_frame,
    cx_gui, cy_gui,
    scale_x_template, scale_y_template,
    card_rotation,
    c_white, image_alpha
);

// ----------------- FRONT CONTENT (only when front is showing AND content is ready) -----------------
if (show_front_content && content_ready) {

    // ---- CATCH COUNT COIN (in upper left corner) ----
    if (show_coin && content_ready) {
        var coin_x = cx_gui - (frame_w_gui * 0.32);  // Upper left corner
        var coin_y = cy_gui - (frame_h_gui * 0.38);
        
        // Handle coin animation
        if (coin_pop_timer < 15) {
            coin_pop_timer++;
            var coin_progress = coin_pop_timer / 15;
            if (coin_progress < 0.5) {
                coin_pop_scale = lerp(0, 1.4, coin_progress / 0.5);
            } else {
                var snap_progress = (coin_progress - 0.5) / 0.5;
                coin_pop_scale = lerp(1.4, 1.0, snap_progress * snap_progress);
            }
        } else {
            coin_pop_scale = 1.0;
        }
        
        // Choose coin color based on catch count
        var coin_sprite = s_coin_bronze; // Default
        if (catch_count >= 20) coin_sprite = s_coin_gold;
        else if (catch_count >= 10) coin_sprite = s_coin_silver;
        else coin_sprite = s_coin_bronze;
        
        // Draw coin with pop animation
        draw_sprite_ext(coin_sprite, 0, coin_x, coin_y, 
                       2.0 * coin_pop_scale, 2.0 * coin_pop_scale, 0, c_white, image_alpha * content_fade_alpha);
        
        // Draw count number on top of coin
        draw_set_font(fnt_card_title_2x);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        // Black outline for number
        draw_set_color(c_black);
        for (var dx = -2; dx <= 2; dx += 2) {
            for (var dy = -2; dy <= 2; dy += 2) {
                if (dx != 0 || dy != 0) {
                    draw_text(coin_x + dx, coin_y + dy, string(catch_count));
                }
            }
        }
        
        // White number
        draw_set_color(c_white);
        draw_text(coin_x, coin_y, string(catch_count));
    }

    // ---- MILESTONE BONUS TEXT (if applicable) ----
    if (milestone_text != "" && content_ready) {
        var milestone_y = cy_gui + (frame_h_gui * 0.45); // Below essence text
        
        draw_set_font(fnt_flavor_text_2x);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        // Glowing effect for milestone text
        var glow_alpha = 0.8 + sin(animation_timer * 0.2) * 0.2;
        
        // Gold glow
        draw_set_color(make_color_rgb(255, 215, 0));
        draw_set_alpha(glow_alpha * content_fade_alpha);
        draw_text(cx_gui, milestone_y - 2, milestone_text);
        draw_text(cx_gui, milestone_y + 2, milestone_text);
        draw_text(cx_gui - 2, milestone_y, milestone_text);
        draw_text(cx_gui + 2, milestone_y, milestone_text);
        
        // Main text
        draw_set_color(c_yellow);
        draw_set_alpha(content_fade_alpha);
        draw_text(cx_gui, milestone_y, milestone_text);
        
        draw_set_alpha(1);
    }

    // ---- BONUS ESSENCE TEXT (if applicable) ----
    if (bonus_essence > 0 && content_ready) {
        var bonus_y = cy_gui + (frame_h_gui * 0.52); // Below milestone text
        var bonus_text = "Bonus: +" + string(bonus_essence) + " Essence!";
        
        draw_set_font(fnt_flavor_text);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        // Green for bonus essence
        draw_set_color(c_black);
        draw_text(cx_gui + 1, bonus_y + 1, bonus_text);
        draw_text(cx_gui - 1, bonus_y - 1, bonus_text);
        
        draw_set_color(c_lime);
        draw_text(cx_gui, bonus_y, bonus_text);
    }

    // ---- RARITY GEM WITH POP ANIMATION AND FADE ----
    if (gem_pop_scale > 0) {  // Only draw if gem has started animating
        var gem_x = cx_gui + (frame_w_gui * 0.32);  
        var gem_y = cy_gui - (frame_h_gui * 0.38);  

        // Draw glow effect for rare gems
        if (bug_rarity_tier <= 2) {
            gem_glow_timer += 0.15;
            var glow_alpha = 0.3 + (sin(gem_glow_timer) * 0.2);
            var glow_color = (bug_rarity_tier == 1) ? make_color_rgb(255, 100, 255) : make_color_rgb(255, 100, 100);

            draw_set_alpha(glow_alpha * content_fade_alpha);  // Apply fade
            draw_sprite_ext(gem_sprite, 0, gem_x, gem_y, 2.4 * gem_pop_scale, 2.4 * gem_pop_scale, 0, glow_color, 1);
            draw_set_alpha(1);
        }

        // Draw the actual gem with pop scale AND fade
        draw_sprite_ext(gem_sprite, 0, gem_x, gem_y, 2.0 * gem_pop_scale, 2.0 * gem_pop_scale, 0, c_white, image_alpha * content_fade_alpha);
    }

    // ---- Build 2× text surface (only if bug has popped in) ----
    if (bug_pop_scale > 0) {
        var surf_w = max(1, sprite_get_width(s_card_template) * 2);
        var surf_h = max(1, sprite_get_height(s_card_template) * 2);
        var text_surf = surface_create(surf_w, surf_h);

        if (surface_exists(text_surf)) {
            surface_set_target(text_surf);
            draw_clear_alpha(c_black, 0);

            var cx = surf_w * 0.5;
            var cy = surf_h * 0.5;
            
            // Shadow offset for all content
            var content_shadow_x = 3;
            var content_shadow_y = 3;

            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);

            // ---- BUG SPRITE WITH POP ANIMATION AND SHADOW ----
            var tgt_bug_h_px = (sprite_get_height(s_card_template) * 0.35) * 2;
            var spr_w = sprite_get_width(bug_sprite);
            var spr_h = sprite_get_height(bug_sprite);
            var bug_scale = min(tgt_bug_h_px / spr_w, tgt_bug_h_px / spr_h) * bug_pop_scale;
            var bug_y_off = -sprite_get_height(s_card_template) * 0.20 * 2;
            
            // Draw bug shadow
            draw_sprite_ext(bug_sprite, 0, cx + content_shadow_x, cy + bug_y_off + content_shadow_y, 
                           bug_scale, bug_scale, 0, c_black, 0.6 * image_alpha * content_fade_alpha);
            // Draw bug
            draw_sprite_ext(bug_sprite, 0, cx, cy + bug_y_off, 
                           bug_scale, bug_scale, 0, c_white, image_alpha * content_fade_alpha);

            // ---- BUG NAME WITH OUTLINE AND SEMI-TRANSPARENT SHADOW ----
            draw_set_font(fnt_card_title_2x);
            var cream = make_color_rgb(245,235,215);
            var dark_purple = make_color_rgb(45, 25, 60);  // Dark purple outline
            var name_y = sprite_get_height(s_card_template) * 0.08 * 2;
            var name_w = (sprite_get_width(s_card_template) - 45) * 2;
            var name_sep = 14 * 2;
            
            var shadow_offset = 4;

            // Draw SEMI-TRANSPARENT name shadow first (behind everything)
            draw_set_alpha(0.5 * content_fade_alpha);  // Make shadow 50% transparent
            draw_set_color(c_black);
            draw_text_ext(cx + shadow_offset, cy + name_y + shadow_offset, bug_name, name_sep, name_w);
            draw_set_alpha(1);  // Reset alpha to full opacity
            
            // Draw dark purple outline (8-direction)
            draw_set_color(dark_purple);
            draw_text_ext(cx + 2, cy + name_y + 2, bug_name, name_sep, name_w);
            draw_text_ext(cx - 2, cy + name_y - 2, bug_name, name_sep, name_w);
            draw_text_ext(cx + 2, cy + name_y - 2, bug_name, name_sep, name_w);
            draw_text_ext(cx - 2, cy + name_y + 2, bug_name, name_sep, name_w);
            draw_text_ext(cx + 2, cy + name_y, bug_name, name_sep, name_w);
            draw_text_ext(cx - 2, cy + name_y, bug_name, name_sep, name_w);
            draw_text_ext(cx, cy + name_y + 2, bug_name, name_sep, name_w);
            draw_text_ext(cx, cy + name_y - 2, bug_name, name_sep, name_w);
            
            // Draw cream text on top
            draw_set_color(cream);
            draw_text_ext(cx, cy + name_y, bug_name, name_sep, name_w);

            // ---- FLAVOR TEXT WITH OUTLINE ONLY ----
            draw_set_font(fnt_flavor_text_2x);
            var light_gold = make_color_rgb(255,223,128);
            var flavor_y = sprite_get_height(s_card_template) * 0.28 * 2;
            var txt_w = (sprite_get_width(s_card_template) - 60) * 2;
            var flavor_sep = 12 * 2;

            // Draw black outline (8-direction)
            draw_set_color(c_black);
            draw_text_ext(cx + 2, cy + flavor_y + 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx - 2, cy + flavor_y - 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx + 2, cy + flavor_y - 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx - 2, cy + flavor_y + 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx + 2, cy + flavor_y, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx - 2, cy + flavor_y, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx, cy + flavor_y + 2, flavor_text, flavor_sep, txt_w);
            draw_text_ext(cx, cy + flavor_y - 2, flavor_text, flavor_sep, txt_w);
            
            // Draw gold text on top
            draw_set_color(light_gold);
            draw_text_ext(cx, cy + flavor_y, flavor_text, flavor_sep, txt_w);

            // ---- ESSENCE TEXT WITH OUTLINE ONLY ----
            draw_set_font(fnt_flavor_text);
            var essence_y = sprite_get_height(s_card_template) * 0.40 * 2;
            var essence_text = "Essence: +" + string(essence_value);

            // Draw black outline (8-direction)
            draw_set_color(c_black);
            draw_text(cx + 1, cy + essence_y + 1, essence_text);
            draw_text(cx - 1, cy + essence_y - 1, essence_text);
            draw_text(cx + 1, cy + essence_y - 1, essence_text);
            draw_text(cx - 1, cy + essence_y + 1, essence_text);
            draw_text(cx + 1, cy + essence_y, essence_text);
            draw_text(cx - 1, cy + essence_y, essence_text);
            draw_text(cx, cy + essence_y + 1, essence_text);
            draw_text(cx, cy + essence_y - 1, essence_text);
            
            // Draw gold text on top
            draw_set_color(make_color_rgb(255,215,0));
            draw_text(cx, cy + essence_y, essence_text);

            surface_reset_target();

            // Draw the surface
            draw_surface_ext(
                text_surf,
                tl_x, tl_y,
                scale_x_surface, scale_y_surface,
                card_rotation,
                c_white, image_alpha * content_fade_alpha  // Apply fade to entire text surface
            );
            surface_free(text_surf);
        }
    }
}