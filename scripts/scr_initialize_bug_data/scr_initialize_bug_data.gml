// scr_initialize_bug_data() - Updated to match Google Doc
function scr_initialize_bug_data() {
    global.bug_data = {};
    
    // Helper function to calculate average rarity across all locations
    function calculate_avg_rarity(locations) {
        var total = 0;
        var count = 0;
        var location_names = variable_struct_get_names(locations);
        for (var i = 0; i < array_length(location_names); i++) {
            var rarity = locations[$ location_names[i]];
            if (rarity != "x") {
                total += rarity;
                count++;
            }
        }
        return count > 0 ? total / count : 5; // Default to 5 if no valid locations
    }
    
    // Helper function to convert rarity to HP (higher rarity = more HP)
    function rarity_to_hp(avg_rarity) {
        return floor(5 + (avg_rarity * 3)); // Range: 8-35 HP based on rarity
    }
    
    // Helper function to convert rarity to essence (higher rarity = more essence)
    function rarity_to_essence(avg_rarity) {
        return floor(avg_rarity * 5); // Range: 5-50 essence based on rarity
    }
    
    // ===========================================
    // PUMPKIN FAMILY
    // ===========================================
    
    global.bug_data[$ "pumpkin_snail"] = {
        name: "Pumpkin Snail",
        flavor_text: "It's just orange. That's it.",
        sprite: s_bug_pumpkin_snail,
        locations: { Apple_Grove: 4, Dead_Woods: 5, Haunted_Town: 3, Pumpkin_Patch: 1 },
        hp: 15,
        essence: 12
    };
    
    global.bug_data[$ "fancy_pumpkin_snail"] = {
        name: "Fancy Pumpkin Snail",
        flavor_text: "It might not have legs, but it's still a fancy pants",
        sprite: s_bug_fancy_pumpkin_snail,
        locations: { Apple_Grove: 5, Dead_Woods: 5, Haunted_Town: 4, Pumpkin_Patch: 1 },
        hp: 18,
        essence: 15
    };
    
    global.bug_data[$ "jack_o_lantern_snail"] = {
        name: "Jack-o-Lantern Snail",
        flavor_text: "Glows when scared... so always.",
        sprite: s_bug_jack_o_lantern_snail,
        locations: { Graveyard: 8, Haunted_Town: 6, Pumpkin_Patch: 5, Cauldron_Springs: 8 },
        hp: 30,
        essence: 35
    };
    
    global.bug_data[$ "pumpkin_pie_butterfly"] = {
        name: "Pumpkin Pie Butterfly",
        flavor_text: "It looks almost as good as it smells",
        sprite: s_bug_pumpkin_pie_butterfly,
        locations: { Apple_Grove: 5, Haunted_Town: 4, Pumpkin_Patch: 2, Sugar_Lake: 8 },
        hp: 22,
        essence: 25
    };
    
    global.bug_data[$ "pumpkin_ant"] = {
        name: "Pumpkin Ant",
        flavor_text: "A perfect sprinkle topping for your pumpkin latte!",
        sprite: s_bug_pumpkin_ant,
        locations: { Apple_Grove: 8, Graveyard: 8, Haunted_Town: 6, Pumpkin_Patch: 2 },
        hp: 28,
        essence: 30
    };
    
    global.bug_data[$ "pumpkin_spice_centipede"] = {
        name: "Pumpkin Spice Centipede",
        flavor_text: "Does it taste like that because it's spiced or because it's toxic?",
        sprite: s_bug_pumpkin_spice_centipede,
        locations: { Apple_Grove: 9, Graveyard: 9, Haunted_Town: 5, Pumpkin_Patch: 4 },
        hp: 32,
        essence: 35
    };
    
    // ===========================================
    // SWEET TREATS FAMILY
    // ===========================================
    
    global.bug_data[$ "whipped_cream_stink_bug"] = {
        name: "Whipped Cream Stink Bug",
        flavor_text: "Creamy and delicious... until it isn't.",
        sprite: s_bug_whipped_cream_stink_bug,
        locations: { Haunted_Town: 5, Pumpkin_Patch: 3, Sugar_Lake: 7 },
        hp: 20,
        essence: 25
    };
    
    global.bug_data[$ "candy_corn_beetle"] = {
        name: "Candy Corn Beetle",
        flavor_text: "Forget John, this is the most controversial beetle out there!",
        sprite: s_bug_candy_corn_beetle,
        locations: { Sugar_Lake: 1 },
        hp: 8,
        essence: 45  // Very high essence for being so rare and exclusive
    };
    
    global.bug_data[$ "sugar_stick_bugs"] = {
        name: "Sugar Stick Bugs",
        flavor_text: "It's a stick full of sugar... who thought this was a good idea?",
        sprite: s_bug_sugar_stick_bugs,
        locations: { Sugar_Lake: 2 },
        hp: 12,
        essence: 40
    };
    
    global.bug_data[$ "red_gummy_silverfish"] = {
        name: "Red Gummy Silverfish",
        flavor_text: "It's not Swedish... it's 'sweet-ish.",
        sprite: s_bug_red_gummy_silverfish,
        locations: { Sugar_Lake: 4 },
        hp: 17,
        essence: 30
    };
    
    global.bug_data[$ "lollipop_walking_stick"] = {
        name: "Lollipop Walking Stick",
        flavor_text: "The preferred walking stick of munchkins everywhere.",
        sprite: s_bug_lollipop_walking_stick,
        locations: { Sugar_Lake: 3 },
        hp: 14,
        essence: 35
    };
    
    global.bug_data[$ "cinnamon_roll_snake"] = {
        name: "Cinnamon Roll Snake",
        flavor_text: "Smells like heaven... huh, maybe that's a warning?",
        sprite: s_bug_cinnamon_roll_snake,
        locations: { Apple_Grove: 9, Dead_Woods: 9, Graveyard: 9, Tomb: 9, Haunted_Town: 9, Pumpkin_Patch: 9, Sugar_Lake: 5 },
        hp: 45,  // Ultra rare, high HP
        essence: 75
    };
    
    global.bug_data[$ "spiced_hot_chocolate_scorpion"] = {
        name: "Spiced Hot Chocolate Scorpion",
        flavor_text: "He's the hottest of the hot!",
        sprite: s_bug_spiced_hot_cocoa_scorpion,
        locations: { Dead_Woods: 7, Graveyard: 7, Sugar_Lake: 6 },
        hp: 28,
        essence: 35
    };
    
    // ===========================================
    // AUTUMN/NATURE FAMILY
    // ===========================================
    
    global.bug_data[$ "maple_leaf_bug"] = {
        name: "Maple Leaf Bug",
        flavor_text: "It crunches just like a maple leaf under foot... except for the gooey part.",
        sprite: s_bug_maple_leaf_bug,
        locations: { Apple_Grove: 2, Dead_Woods: 4, Graveyard: 6, Haunted_Town: 6, Pumpkin_Patch: 6 },
        hp: 20,
        essence: 18
    };
    
    global.bug_data[$ "apple_pie_moth"] = {
        name: "Apple Pie Moth",
        flavor_text: "Buttery and sweet... but the wings are a little dry.",
        sprite: s_bug_apple_pie_moth,
        locations: { Apple_Grove: 2, Dead_Woods: 3, Pumpkin_Patch: 7, Sugar_Lake: 7 },
        hp: 22,
        essence: 25
    };
    
    global.bug_data[$ "apple_cider_spider"] = {
        name: "Apple Cider Spider",
        flavor_text: "There may be a rhyme to this little guy, but there ain't no reason.",
        sprite: s_bug_apple_cider_spider,
        locations: { Apple_Grove: 1, Dead_Woods: 3, Graveyard: 6, Haunted_Town: 6, Pumpkin_Patch: 7, Sugar_Lake: 8 },
        hp: 25,
        essence: 20
    };
    
    global.bug_data[$ "candy_apple_bat"] = {
        name: "Candy Apple Bat",
        flavor_text: "It vants to suck your blood... red food dye.",
        sprite: s_bug_candy_apple_bat,
        locations: { Apple_Grove: 6, Sugar_Lake: 9 },
        hp: 35,
        essence: 40
    };
    
    global.bug_data[$ "caramel_apple_lizard"] = {
        name: "Caramel Apple Lizard",
        flavor_text: "It's so cute, but it sticks to everything!",
        sprite: s_bug_caramel_apple_gecko,
        locations: { Apple_Grove: 5, Dead_Woods: 8, Graveyard: 9, Haunted_Town: 9, Sugar_Lake: 9 },
        hp: 40,
        essence: 45
    };
    
    global.bug_data[$ "razor_blade_candy_apple_beetle"] = {
        name: "Razor Blade Candy Apple Beetle",
        flavor_text: "The red on your chin isn't just from the candy!",
        sprite: s_bug_razor_blade_candy_apple_beetle,
        locations: { Apple_Grove: 9, Sugar_Lake: 9 },
        hp: 50,
        essence: 65
    };
    
    // ===========================================
    // SPOOKY/HORROR FAMILY
    // ===========================================
    
    global.bug_data[$ "scented_candle_spider"] = {
        name: "Scented Candle Spider",
        flavor_text: "Smells like grandma's kitchen... looks like your nightmares",
        sprite: s_bug_scented_candle_spider,
        locations: { Apple_Grove: 6, Dead_Woods: 6, Graveyard: 6, Tomb: 6, Haunted_Town: 6, Pumpkin_Patch: 6, Cauldron_Springs: 6 },
        hp: 26,
        essence: 25
    };
    
    global.bug_data[$ "corpse_moth"] = {
        name: "Corpse Moth",
        flavor_text: "Don't worry, it's not dead, it just hatches in the mouth of dead people.",
        sprite: s_bug_decay_moth,  // Using decay moth sprite as placeholder
        locations: { Apple_Grove: 6, Dead_Woods: 2, Graveyard: 4, Haunted_Town: 4 },
        hp: 18,
        essence: 22
    };
    
    global.bug_data[$ "ghost_lady_moth"] = {
        name: "Ghost Lady Moth",
        flavor_text: "They say she's drawn to the flickering light of T.V.'s",
        sprite: s_bug_ghost_lady_moth,
        locations: { Graveyard: 7, Haunted_Town: 2, Pumpkin_Patch: 6 },
        hp: 25,
        essence: 35
    };
    
    global.bug_data[$ "death_potion_ladybug"] = {
        name: "Death Potion Ladybug",
        flavor_text: "To quote Shakespeare: Though she be but little, she is... ack, I'm dead.",
        sprite: s_bug_death_potion_ladybug,
        locations: { Graveyard: 9, Haunted_Town: 4, Pumpkin_Patch: 5 },
        hp: 30,
        essence: 40
    };
    
    global.bug_data[$ "face_eating_ghost_spider"] = {
        name: "Face-eating Ghost Spider",
        flavor_text: "Birthed from the phobias of children everywhere!",
        sprite: s_bug_face_eating_ghost_spider,
        locations: { Graveyard: 7, Haunted_Town: 3, Pumpkin_Patch: 7 },
        hp: 28,
        essence: 35
    };
    
    global.bug_data[$ "dust_imp"] = {
        name: "Dust Imp",
        flavor_text: "It's blue... so stop it, copyright police.",
        sprite: s_bug_dust_imp,
        locations: { Graveyard: 3, Haunted_Town: 1, Pumpkin_Patch: 5 },
        hp: 15,
        essence: 20
    };
    
    global.bug_data[$ "possessed_doll_spider"] = {
        name: "Possessed Doll Spider",
        flavor_text: "It's waiting for you beneath your bed.",
        sprite: s_bug_possessed_doll_spider,
        locations: { Haunted_Town: 6, Pumpkin_Patch: 7 },
        hp: 32,
        essence: 35
    };
    
    global.bug_data[$ "phantom_moon_moth"] = {
        name: "Phantom Moon Moth",
        flavor_text: "Don't follow the light... unless you're a werewolf.",
        sprite: s_bug_phantom_moon_moth,
        locations: { Graveyard: 5, Haunted_Town: 5, Pumpkin_Patch: 5 },
        hp: 22,
        essence: 30
    };
    
    global.bug_data[$ "floating_red_balloon_spider"] = {
        name: "Floating Red Balloon Spider",
        flavor_text: "Just run.",
        sprite: s_bug_floating_red_balloon_caterpillar,
        locations: { Graveyard: 9, Tomb: 4, Haunted_Town: 9 },
        hp: 35,
        essence: 50
    };
    
    global.bug_data[$ "vampire_mosquito"] = {
        name: "Vampire Mosquito",
        flavor_text: "Pretty much just a normal mosquito, but its skin sparkles in the sunlight.",
        sprite: s_bug_vampire_mosquito,
        locations: { Apple_Grove: 9, Dead_Woods: 9, Graveyard: 3, Haunted_Town: 9, Pumpkin_Patch: 9, Cauldron_Springs: 9 },
        hp: 15,
        essence: 45
    };
    
    global.bug_data[$ "ghost_face_tic"] = {
        name: "Ghost Face Tic",
        flavor_text: "It's based off of Scream... The Scream... you know, the painting.",
        sprite: s_bug_ghost_face_tic,
        locations: { Graveyard: 9, Haunted_Town: 4 },
        hp: 28,
        essence: 45
    };
    
    // ===========================================
    // GRAVEYARD/TOMB FAMILY
    // ===========================================
    
    global.bug_data[$ "mushroom_toad"] = {
        name: "Mushroom Toad",
        flavor_text: "She's the O.G. toadstool!",
        sprite: s_bug_mushroom_toad,
        locations: { Apple_Grove: 6, Dead_Woods: 3, Graveyard: 8, Tomb: 9, Cauldron_Springs: 9 },
        hp: 35,
        essence: 40
    };
    
    global.bug_data[$ "lantern_beetle"] = {
        name: "Lantern Beetle",
        flavor_text: "It guides you... to your doom.",
        sprite: s_bug_lantern_beetle,
        locations: { Graveyard: 7, Tomb: 4 },
        hp: 26,
        essence: 35
    };
    
    global.bug_data[$ "dead_guys_finger_caterpillar"] = {
        name: "Dead Guy's Finger Caterpillar",
        flavor_text: "It's giving you a come-hither squirm from beyond the grave.",
        sprite: s_bug_dead_guys_finger_caterpillar,
        locations: { Graveyard: 4, Tomb: 5 },
        hp: 20,
        essence: 25
    };
    
    global.bug_data[$ "skull_faced_scorpion"] = {
        name: "Skull Faced Scorpion",
        flavor_text: "The skull means it's funny! Knock-knock? Who's there? Not you because you're dead now.",
        sprite: s_bug_skull_faced_scorpion,
        locations: { Graveyard: 3 },
        hp: 14,
        essence: 35
    };
    
    global.bug_data[$ "dead_mans_toe_fungi"] = {
        name: "Dead Man's Toe Fungi",
        flavor_text: "Brings a whole new meaning to toenail fungus.",
        sprite: s_bug_dead_mans_toe_toadstool,
        locations: { Graveyard: 2 },
        hp: 12,
        essence: 30
    };
    
    global.bug_data[$ "skeleton_termite"] = {
        name: "Skeleton Termite",
        flavor_text: "Hear that rattling? Yep, you've definitely got a case of skeleton termites.",
        sprite: s_bug_skeleton_termite,
        locations: { Dead_Woods: 9, Graveyard: 2 },
        hp: 25,
        essence: 40
    };
    
    global.bug_data[$ "frankensteins_monster_mash"] = {
        name: "Frankenstein's Monster Mash",
        flavor_text: "It's where body parts mash together! ...no, not in that way, you weirdo.",
        sprite: s_bug_frankensteins_monster_mash,
        locations: { Dead_Woods: 9, Graveyard: 4, Tomb: 4 },
        hp: 40,
        essence: 50
    };
    
    // ===========================================
    // MAGICAL/WITCH FAMILY
    // ===========================================
    
    global.bug_data[$ "love_potion_frog"] = {
        name: "Love Potion Frog",
        flavor_text: "One kiss and he becomes a prince... or you become a frog. Whatever, true love knows no bounds.",
        sprite: s_bug_love_potion_frog,
        locations: { Cauldron_Springs: 5 },
        hp: 22,
        essence: 35
    };
    
    global.bug_data[$ "cauldron_toad"] = {
        name: "Cauldron Toad",
        flavor_text: "He bubbles, he toils, he... croaks?",
        sprite: s_bug_cauldron_toad,
        locations: { Sugar_Lake: 5, Cauldron_Springs: 4 },
        hp: 20,
        essence: 30
    };
    
    global.bug_data[$ "witches_hat_slug"] = {
        name: "Witches Hat Slug",
        flavor_text: "Water is fine, just don't use salt.",
        sprite: s_bug_witches_hat_slug,
        locations: { Graveyard: 9, Cauldron_Springs: 3 },
        hp: 25,
        essence: 40
    };
    
    global.bug_data[$ "broom_widow_walking_stick"] = {
        name: "Broom Widow Walking Stick",
        flavor_text: "She sweeps you off your feet... and over a cliff.",
        sprite: s_bug_broom_walking_stick,
        locations: { Cauldron_Springs: 2 },
        hp: 12,
        essence: 35
    };
    
    global.bug_data[$ "crystal_ball_scarab_beetle"] = {
        name: "Crystal Ball Scarab Beetle",
        flavor_text: "It reminds you of the scarab. What scarab? The scarab with the power.",
        sprite: s_bug_crystal_ball_scarab_beetle,
        locations: { Cauldron_Springs: 6 },
        hp: 26,
        essence: 35
    };
    
    // ===========================================
    // ULTRA RARE/SPECIAL FAMILY
    // ===========================================
    
    global.bug_data[$ "floating_candle_moth"] = {
        name: "Floating Candle Moth",
        flavor_text: "Like a moth to a flame... wait.",
        sprite: s_bug_floating_candle_moth,
        locations: { Apple_Grove: 9, Dead_Woods: 9, Graveyard: 4, Tomb: 9, Haunted_Town: 9, Pumpkin_Patch: 9, Sugar_Lake: 9, Cauldron_Springs: 4 },
        hp: 38,
        essence: 55
    };
    
    global.bug_data[$ "hairy_monster_long_legs"] = {
        name: "Hairy Monster Long Legs",
        flavor_text: "This is before his episode on Queer Eye.",
        sprite: s_bug_hairy_monster_long_legs,
        locations: { Dead_Woods: 9, Graveyard: 9, Haunted_Town: 3 },
        hp: 35,
        essence: 50
    };
    
    global.bug_data[$ "daddy_monster_long_legs"] = {
        name: "Daddy Monster Long Legs",
        flavor_text: "This is after his episode on Queer Eye.",
        sprite: s_bug_daddy_monster_long_legs,
        locations: { Haunted_Town: 5 },
        hp: 22,
        essence: 45
    };
    
    global.bug_data[$ "a_cup_of_star_bugs"] = {
        name: "A Cup of Star Bugs",
        flavor_text: "It smells of magic and freshly ground coffee... and nine dollars burning in your bank account.",
        sprite: s_bug_a_cup_of_star_bugs,
        locations: { Apple_Grove: 9, Dead_Woods: 9, Graveyard: 9, Tomb: 9, Haunted_Town: 9, Pumpkin_Patch: 9, Sugar_Lake: 9, Cauldron_Springs: 9 },
        hp: 60,  // Legendary difficulty
        essence: 100
    };
    
    // Set current location for spawning system
    global.current_location = "Apple_Grove";  // Default starting location
}
