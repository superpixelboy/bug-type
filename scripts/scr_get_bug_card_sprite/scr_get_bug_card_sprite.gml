// ===========================================
// Bug to Card Sprite Mapping Function
// Add this to a new script: scr_get_bug_card_sprite
// ===========================================

function scr_get_bug_card_sprite(bug_sprite) {
    // Map bug sprites to their corresponding card sprites
    // Only include sprites that actually exist in your project
    switch(bug_sprite) {
        case s_bug_a_cup_of_star_bugs: return s_card_a_cup_of_star_bugs;
        case s_bug_apple_cider_spider: return s_card_apple_cider_spider;
        case s_bug_apple_pie_moth: return s_card_apple_pie_moth;
        case s_bug_candy_apple_bat: return s_card_candy_apple_bat;
        case s_bug_candy_corn_beetle: return s_card_candy_corn_beetle;
        case s_bug_caramel_apple_gecko: return s_card_caramel_apple_gecko;
        case s_bug_cauldron_toad: return s_card_cauldron_toad;
        case s_bug_cinnamon_roll_snake: return s_card_cinnamon_roll_snake;
        case s_bug_crystal_ball_scarab_beetle: return s_card_crystal_ball_scarab_beetle;
        case s_bug_daddy_monster_long_legs: return s_card_daddy_monster_long_legs;
        case s_bug_dead_guys_finger_caterpillar: return s_card_dead_guys_finger_caterpillar;
        case s_bug_dead_mans_toe_toadstool: return s_card_dead_mans_toe_toadstool;
        case s_bug_death_potion_ladybug: return s_card_death_potion_ladybug;
        case s_bug_dust_imp: return s_card_dust_imp;
        case s_bug_face_eating_ghost_spider: return s_card_face_eating_ghost_spider;
        case s_bug_fancy_pumpkin_snail: return s_card_fancy_pumpkin_snail;
        case s_bug_floating_candle_moth: return s_card_floating_candle_moth;
        case s_bug_floating_red_balloon_caterpillar: return s_card_floating_red_balloon_caterpillar;
        case s_bug_frankensteins_monster_mash: return s_card_frankensteins_monster_mash;
        case s_bug_ghost_face_tic: return s_card_ghost_face_tic;
        case s_bug_ghost_lady_moth: return s_card_ghost_lady_moth;
        case s_bug_hairy_monster_long_legs: return s_card_hairy_monster_long_legs;
        case s_bug_jack_o_lantern_snail: return s_card_jack_o_lantern_snail;
        case s_bug_lantern_beetle: return s_card_lantern_beetle;
        case s_bug_lollipop_walking_stick: return s_card_lollipop_walking_stick;
        case s_bug_love_potion_frog: return s_card_love_potion_frog;
        case s_bug_maple_leaf_bug: return s_card_maple_leaf_bug;
        case s_bug_mushroom_toad: return s_card_mushroom_toad;
        case s_bug_phantom_moon_moth: return s_card_phantom_moon_moth;
        case s_bug_possessed_doll_spider: return s_card_possessed_doll_spider;
        case s_bug_pumpkin_ant: return s_card_pumpkin_ant;
        case s_bug_pumpkin_pie_butterfly: return s_card_pumpkin_pie_butterfly;
        case s_bug_pumpkin_snail: return s_card_pumpkin_snail;
        case s_bug_pumpkin_spice_centipede: return s_card_pumpkin_spice_centipede;
        case s_bug_razor_blade_candy_apple_beetle: return s_card_razor_blade_candy_apple_beetle;
        case s_bug_red_gummy_silverfish: return s_card_red_gummy_silverfish;
        case s_bug_scented_candle_spider: return s_card_scented_candle_spider;
        case s_bug_skeleton_termite: return s_card_skeleton_termite;
        case s_bug_skull_faced_scorpion: return s_card_skull_faced_scorpion;
        case s_bug_spiced_hot_cocoa_scorpion: return s_card_spiced_hot_cocoa_scorpion;
        case s_bug_sugar_stick_bugs: return s_card_sugar_stick_bugs;
        case s_bug_vampire_mosquito: return s_card_vampire_mosquito;
        case s_bug_whipped_cream_stink_bug: return s_card_whipped_cream_stink_bug;
        case s_bug_witches_hat_slug: return s_card_witches_hat_slug;
        
        // Add more mappings as you confirm the sprites exist
        // Uncomment these as you verify they exist in your project:
        // case s_bug_black_flame_moth_candle: return s_card_black_flame_moth_candle;
        // case s_bug_broom_walking_stick: return s_card_broom_walking_stick;
        // case s_bug_button_eye_spider: return s_card_button_eye_spider;
        // case s_bug_chocolate_bark_weevil: return s_card_chocolate_bark_weevil;
        // case s_bug_cobwebbed_dragonfly: return s_card_cobwebbed_dragonfly;
        // case s_bug_cozy_flannel_earwig: return s_card_cozy_flannel_earwig;
        // case s_bug_cozy_worm: return s_card_cozy_worm;
        // case s_bug_dark_night_moth: return s_card_dark_night_moth;
        // case s_bug_decay_moth: return s_card_decay_moth;
        // case s_bug_diamond_pumpkin_snail: return s_card_diamond_pumpkin_snail;
        // case s_bug_dracula_tick: return s_card_dracula_tick;
        // case s_bug_eyeball_pill: return s_card_eyeball_pill;
        // case s_bug_golden_pumpkin_snail: return s_card_golden_pumpkin_snail;
        // case s_bug_grim_reeper_millapede: return s_card_grim_reeper_millapede;
        // case s_bug_marshmallow_maggots: return s_card_marshmallow_maggots;
        // case s_bug_pharohs_mummy_scarab: return s_card_pharohs_mummy_scarab;
        // case s_bug_repaid_red_rum_gnat: return s_card_repaid_red_rum_gnat;
        // case s_bug_rotten_egg_pillbug: return s_card_rotten_egg_pillbug;
        // case s_bug_scarecrow_walking_stick: return s_card_scarecrow_walking_stick;
        // case s_bug_sugar_cookie_spider: return s_card_sugar_cookie_spider;
        // case s_bug_wandering_gravestone_toad: return s_card_wandering_gravestone_toad;
        // case s_bug_werewolf_spider: return s_card_werewolf_spider;
        // case s_bug_zombie_hand_thing: return s_card_zombie_hand_thing;
        
        // Fallback to default frame if no card sprite exists
        default: return s_bug_frame;
    }
}