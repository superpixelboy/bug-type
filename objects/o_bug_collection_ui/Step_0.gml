
if (!is_open) exit;

// Page navigation
if (keyboard_check_pressed(vk_left) && page > 0) {
    page--;
}
if (keyboard_check_pressed(vk_right) && page < total_pages - 1) {
    page++;
}
