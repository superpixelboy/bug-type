// In o_shop_oak_wand Step Event
// Check if player is beneath and pressing space
if (distance_to_object(o_player) < 20 && o_player.y > y) {
    if (keyboard_check_pressed(vk_space) && !global.has_oak_wand && global.essence >= item_price) {
        global.essence -= item_price;
        global.has_oak_wand = true;
        image_index = 1;
        audio_play_sound(sn_bug_catch1, 1, false);
    }
}