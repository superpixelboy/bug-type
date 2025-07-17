// ===========================================
// scr_play_combo_sound(combo_level) - Script
// ===========================================

function scr_play_combo_sound(combo_level) {
    switch(combo_level) {
        case 1:
            audio_play_sound(sn_combo1, 1, false);
            break;
        case 2:
            audio_play_sound(sn_combo2, 1, false);
            break;
        case 3:
            audio_play_sound(sn_combo3, 1, false);
            break;
        case 4:
            audio_play_sound(sn_combo4, 1, false);
            break;
        case 5:
            audio_play_sound(sn_combo5, 1, false);
            screen_shake(3);
            break;
    }
}