// Create Event
item_name = "Oak Wand";
item_price = 100;
item_description = "Double damage per click";

// Set initial frame based on ownership
image_speed = 0;
if (global.has_oak_wand) {
    image_index = 1; // "SOLD" frame
} else {
    image_index = 0; // Available frame
}