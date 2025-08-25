// SAFETY: Preserving all original functionality, just changing visual appearance

// Button positioning - keeping original values to preserve placement
btn_width = 120;
btn_height = 40;
btn_margin = 20;

// NEW: Sprite-based button properties
// FIXED: Don't assign sprite_index to prevent auto-drawing in world
image_speed = 0; // No animation by default
image_index = 0; // Start with first frame

// NEW: Hover and animation states
is_hovered = false;
hover_scale = 1.0; // For gentle scaling effect
base_scale = 2.0; // Make it bigger - was 1.0, now 2.0 for better visibility

// NEW: Calculate sprite dimensions for positioning
// We'll use these to center the sprite properly
btn_sprite_width = sprite_get_width(s_collection_button);
btn_sprite_height = sprite_get_height(s_collection_button);

// BETTER FIX: Keep visible = true, but ensure no sprite is assigned to the object
// The Draw_64 event will handle all the drawing manually