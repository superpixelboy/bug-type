// Create Event
item_name = "Lucky Clover";
item_price = 500;
item_description = "Unlocks rare gem bugs";

// Set initial frame based on ownership
image_speed = 0;
if (global.has_lucky_clover) {
    image_index = 1; // "SOLD" frame
} else {
    image_index = 0; // Available frame
}