// Spawn the correct large rock based on the type that was clicked
var spawn_x = room_width / 2;
var spawn_y = room_height / 2;

switch(global.current_rock_type) {
    case "normal":
        instance_create_layer(spawn_x, spawn_y, "Instances", o_rock_large);
        break;
        
    case "mossy":
        instance_create_layer(spawn_x, spawn_y, "Instances", o_rock_large_mossy);
        break;
        
    case "cracked":
        instance_create_layer(spawn_x, spawn_y, "Instances", o_rock_large_cracked);
        break;
        
    default:
        // Fallback to normal rock
        instance_create_layer(spawn_x, spawn_y, "Instances", o_rock_large);
        break;
}

// Destroy the spawner - we only need it for one frame
instance_destroy();