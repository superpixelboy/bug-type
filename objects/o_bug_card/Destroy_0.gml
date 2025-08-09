/// @description Insert description here
// You can write your code in this editor
// Clean up high-res viewport when card is destroyed
if (variable_instance_exists(id, "high_res_viewport")) {
    view_visible[high_res_viewport] = false;
}