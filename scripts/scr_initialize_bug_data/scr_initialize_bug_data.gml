// scr_initialize_bug_data() - Complete bug database
function scr_initialize_bug_data() {
    global.bug_data = {};
    
    // Pumpkin snail
    global.bug_data[$ "pumpkin_snail"] = {
        name: "Pumpkin Snail",
        flavor_text: "It's just orange. That's it.",
        sprite: s_bug_pumpkin_snail,
        locations: { Apple_Grove: 4, Dead_Woods: 5, Haunted_Town: 3, Pumpkin_Patch: 1 },
	   
        hp: 15,
        essence: 8
    };
    
    // Fancy Pumpkin Snail
    global.bug_data[$ "fancy_pumpkin_snail"] = {
        name: "Fancy Pumpkin Snail",
        flavor_text: "It might not have legs, but it's still a fancy pants",
        sprite: s_bug_fancy_pumpkin_snail,
       locations: { Apple_Grove: 5, Dead_Woods: 5, Haunted_Town: 4, Pumpkin_Patch: 1 },
	
        hp: 18,
        essence: 12
    };
    
    // Jack-o-Lantern Snail
    global.bug_data[$ "jack_o_lantern_snail"] = {
        name: "Jack-o-Lantern Snail",
        flavor_text: "Glows when scared... so always.",
        sprite: s_bug_jack_o_lantern_snail,
      locations: { Graveyard: 8, Haunted_Town: 6, Pumpkin_Patch: 5, Cauldron_Springs: 8 },
        hp: 25,
        essence: 35
    };
    
    // Pumpkin Pie Butterfly
    global.bug_data[$ "pumpkin_pie_butterfly"] = {
        name: "Pumpkin Pie Butterfly",
        flavor_text: "It looks almost as good as it smells",
        sprite: s_bug_pumpkin_pie_butterfly,
        locations: { Apple_Grove: 5, Haunted_Town: 4, Pumpkin_Patch: 2, Sugar_Lake: 8 },
        hp: 12,
        essence: 15
    };
    
    // Pumpkin Ant
    global.bug_data[$ "pumpkin_ant"] = {
        name: "Pumpkin Ant",
        flavor_text: "A perfect sprinkle topping for your pumpkin latte!",
        sprite: s_bug_pumpkin_ant,
        locations: { Apple_Grove: 8, Graveyard: 8, Haunted_Town: 6, Pumpkin_Patch: 2 },
        hp: 10,
        essence: 20
    };
    
    // Whipped Cream Stink Bug
    global.bug_data[$ "whipped_cream_stink_bug"] = {
        name: "Whipped Cream Stink Bug",
        flavor_text: "Creamy and delicious... until it isn't.",
        sprite: s_bug_whipped_cream_stink_bug,
        locations: { Haunted_Town: 5, Pumpkin_Patch: 3, Sugar_Lake: 7 },
        hp: 22,
        essence: 25
    };
    
    // Maple Leaf Bug
    global.bug_data[$ "maple_leaf_bug"] = {
        name: "Maple Leaf Bug",
        flavor_text: "It crunches just like a maple leaf under foot... except for the gooey part.",
        sprite: s_bug_maple_leaf_bug,
        locations: { Apple_Grove: 2, Dead_Woods: 4, Graveyard: 6, Haunted_Town: 6, Pumpkin_Patch: 6 },
        hp: 14,
        essence: 18
    };
    
    // Scented Candle Spider
    global.bug_data[$ "scented_candle_spider"] = {
        name: "Scented Candle Spider",
        flavor_text: "Smells like grandma's kitchen... looks like your nightmares",
        sprite: s_bug_scented_candle_spider,
        locations: { Apple_Grove: 6, Dead_Woods: 6, Graveyard: 6, Tomb: 6, Haunted_Town: 6, Pumpkin_Patch: 6, Cauldron_Springs: 6 },
        hp: 35,
        essence: 22
    };
    
    // Apple Pie Moth
    global.bug_data[$ "apple_pie_moth"] = {
        name: "Apple Pie Moth",
        flavor_text: "Buttery and sweet... but the wings are a little dry.",
        sprite: s_bug_apple_pie_moth,
        locations: { Apple_Grove: 2, Dead_Woods: 3, Pumpkin_Patch: 7, Sugar_Lake: 7 },
        hp: 16,
        essence: 12
    };
    
    // Apple Cider Spider
    global.bug_data[$ "apple_cider_spider"] = {
        name: "Apple Cider Spider",
        flavor_text: "There may be a rhyme to this little guy, but there ain't no reason.",
        sprite: s_bug_apple_cider_spider,
        locations: { Apple_Grove: 1, Dead_Woods: 3, Graveyard: 6, Haunted_Town: 6, Pumpkin_Patch: 7, Sugar_Lake: 8 },
        hp: 28,
        essence: 15
    };
    
    // Candy Apple Beetle
    global.bug_data[$ "candy_apple_beetle"] = {
        name: "Candy Apple Beetle",
        flavor_text: "It's sickly sweet... seriously, don't eat it.",
        sprite: s_bug_candy_apple_bat,
        locations: { Apple_Grove: 6, Sugar_Lake: 9 },
        hp: 40,
        essence: 55
    };
    
    // Caramel Apple Spider
    global.bug_data[$ "caramel_apple_spider"] = {
        name: "Caramel Apple Spider",
        flavor_text: "It's the most venomous spider in the world... but luckily it's too slow to catch anything.",
        sprite: s_bug_caramel_apple_gecko,
        locations: { Apple_Grove: 5, Dead_Woods: 8, Graveyard: 9, Haunted_Town: 9, Sugar_Lake: 9 },
        hp: 65,
        essence: 70
    };
    
    // Mushroom toad
    global.bug_data[$ "mushroom_toad"] = {
        name: "Mushroom Toad",
        flavor_text: "She's the O.G. toadstool!",
        sprite: s_bug_mushroom_toad,
        locations: { Apple_Grove: 6, Dead_Woods: 3, Graveyard: 8, Tomb: 9, Cauldron_Springs: 9 },
        hp: 45,
        essence: 40
    };
    
    // Pumpkin Spice Centipede
    global.bug_data[$ "pumpkin_spice_centipede"] = {
        name: "Pumpkin Spice Centipede",
        flavor_text: "Does it taste like that because it's spiced or because it's toxic?",
        sprite: s_bug_pumpkin_spice_centipede,
        locations: { Apple_Grove: 9, Graveyard: 9, Haunted_Town: 5, Pumpkin_Patch: 4 },
        hp: 55,
        essence: 65
    };
    
    // Decay Moth
    global.bug_data[$ "decay_moth"] = {
        name: "Decay Moth",
        flavor_text: "Falls apart delicately.",
        sprite: s_bug_decay_moth,
        locations: { Apple_Grove: 6, Dead_Woods: 2, Graveyard: 4, Haunted_Town: 4 },
        hp: 8,
        essence: 25
    };
    
    // Candy Corn Beetle
    global.bug_data[$ "candy_corn_beetle"] = {
        name: "Candy Corn Beetle",
        flavor_text: "Forget John, this is the most controversial beetle out there!",
        sprite: s_bug_candy_corn_beetle,
        locations: { Sugar_Lake: 1 },
        hp: 30,
        essence: 45
    };
    
    // Sugar Stick Bugs
    global.bug_data[$ "sugar_stick_bugs"] = {
        name: "Sugar Stick Bugs",
        flavor_text: "It's a stick full of sugar, literally, that's it.",
        sprite: s_bug_sugar_stick_bugs,
        locations: { Sugar_Lake: 2 },
        hp: 12,
        essence: 35
    };
    
    // Red Gummy Silverfish
    global.bug_data[$ "red_gummy_silverfish"] = {
        name: "Red Gummy Silverfish",
        flavor_text: "It's not Swedish... it's 'sweet-ish.",
        sprite: s_bug_red_gummy_silverfish,
        locations: { Sugar_Lake: 4 },
        hp: 18,
        essence: 25
    };
    
    // Cinnamon Roll Snake
    global.bug_data[$ "cinnamon_roll_snake"] = {
        name: "Cinnamon Roll Snake",
        flavor_text: "Smells like heaven... huh, maybe that's a warning?",
        sprite: s_bug_cinnamon_roll_snake,
        locations: { Apple_Grove: 9, Dead_Woods: 9, Graveyard: 9, Tomb: 9, Haunted_Town: 9, Pumpkin_Patch: 9, Sugar_Lake: 5 },
        hp: 85,
        essence: 90
    };
    
    // Spiced Hot Cocoa Scorpion
    global.bug_data[$ "spiced_hot_cocoa_scorpion"] = {
        name: "Spiced Hot Cocoa Scorpion",
        flavor_text: "It thrives in hot environments and packs a punch.",
        sprite: s_bug_spiced_hot_cocoa_scorpion,
        locations: { Dead_Woods: 7, Graveyard: 7, Sugar_Lake: 6 },
        hp: 75,
        essence: 60
    };
    
    // Lollipop Walking Stick
    global.bug_data[$ "lollipop_walking_stick"] = {
        name: "Lollipop Walking Stick",
        flavor_text: "The preferred walking stick of munchkins everywhere.",
        sprite: s_bug_lollipop_walking_stick,
        locations: { Sugar_Lake: 3 },
        hp: 20,
        essence: 30
    };
    
    // Love Potion Frog
    global.bug_data[$ "love_potion_frog"] = {
        name: "Love Potion Frog",
        flavor_text: "One kiss and he becomes a prince... or you become a frog. Whatever, true love knows no bounds.",
        sprite: s_bug_love_potion_frog,
        locations: { Cauldron_Springs: 5 },
        hp: 35,
        essence: 40
    };
    
    // Cauldron Toad
    global.bug_data[$ "cauldron_toad"] = {
        name: "Cauldron Toad",
        flavor_text: "He bubbles, he toils, he... croaks?",
        sprite: s_bug_cauldron_toad,
        locations: { Sugar_Lake: 5, Cauldron_Springs: 4 },
        hp: 42,
        essence: 35
    };
    
    // Witches Hat Slug
    global.bug_data[$ "witches_hat_slug"] = {
        name: "Witches Hat Slug",
        flavor_text: "Water is fine, just don't use salt.",
        sprite: s_bug_witches_hat_slug,
        locations: { Graveyard: 9, Cauldron_Springs: 3 },
        hp: 15,
        essence: 55
    };
    
    // Broom Walking Stick
    global.bug_data[$ "broom_walking_stick"] = {
        name: "Broom Walking Stick",
        flavor_text: "She sweeps you off your feet and over a cliff.",
        sprite: s_bug_broom_walking_stick,
        locations: { Cauldron_Springs: 2 },
        hp: 25,
        essence: 45
    };
    
    // Ghost Lady Moth
    global.bug_data[$ "ghost_lady_moth"] = {
        name: "Ghost Lady Moth",
        flavor_text: "They say she's drawn to the flickering light of T.V.'s",
        sprite: s_bug_ghost_lady_moth,
        locations: { Graveyard: 7, Haunted_Town: 2, Pumpkin_Patch: 6 },
        hp: 30,
        essence: 50
    };
    
    // Death Potion Ladybug
    global.bug_data[$ "death_potion_ladybug"] = {
        name: "Death Potion Ladybug",
        flavor_text: "Though she be but little, she is... ack, I'm dead.",
        sprite: s_bug_death_potion_ladybug,
        locations: { Graveyard: 9, Haunted_Town: 4, Pumpkin_Patch: 5 },
        hp: 12,
        essence: 65
    };
    
    // Face-eating Ghost Spider
    global.bug_data[$ "face_eating_ghost_spider"] = {
        name: "Face-eating Ghost Spider",
        flavor_text: "Birthed from the phobias of children everywhere!",
        sprite: s_bug_face_eating_ghost_spider,
        locations: { Graveyard: 7, Haunted_Town: 3, Pumpkin_Patch: 7 },
        hp: 60,
        essence: 55
    };
    
    // Dust Imp
    global.bug_data[$ "dust_imp"] = {
        name: "Dust Imp",
        flavor_text: "It's blue... so stop it, copyright police.",
        sprite: s_bug_dust_imp,
        locations: { Graveyard: 3, Haunted_Town: 1, Pumpkin_Patch: 5 },
        hp: 25,
        essence: 20
    };
    
    // Possessed Doll Spider
    global.bug_data[$ "possessed_doll_spider"] = {
        name: "Possessed Doll Spider",
        flavor_text: "It's waiting for you beneath your bed.",
        sprite: s_bug_possessed_doll_spider,
        locations: { Haunted_Town: 6, Pumpkin_Patch: 7 },
        hp: 45,
        essence: 40
    };
    
    // Lantern beetle
    global.bug_data[$ "lantern_beetle"] = {
        name: "Lantern Beetle",
        flavor_text: "It guides you... to your doom.",
        sprite: s_bug_lantern_beetle,
        locations: { Graveyard: 7, Tomb: 4 },
        hp: 38,
        essence: 50
    };
    
    // Phantom Moon Moth
    global.bug_data[$ "phantom_moon_moth"] = {
        name: "Phantom Moon Moth",
        flavor_text: "Don't follow the light.",
        sprite: s_bug_phantom_moon_moth,
        locations: { Graveyard: 5, Haunted_Town: 5, Pumpkin_Patch: 5 },
        hp: 32,
        essence: 40
    };
    
    // Floating Red Balloon Caterpillar
    global.bug_data[$ "floating_red_balloon_caterpillar"] = {
        name: "Floating Red Balloon Caterpillar",
        flavor_text: "Just run.",
        sprite: s_bug_floating_red_balloon_caterpillar,
        locations: { Graveyard: 9, Tomb: 4, Haunted_Town: 9 },
        hp: 15,
        essence: 85
    };
    
    // Razor Blade Candy Apple Beetle
    global.bug_data[$ "razor_blade_candy_apple_beetle"] = {
        name: "Razor Blade Candy Apple Beetle",
        flavor_text: "The red on your chin isn't from the candy!",
        sprite: s_bug_razor_blade_candy_apple_beetle,
        locations: { Apple_Grove: 9, Sugar_Lake: 9 },
        hp: 95,
        essence: 110
    };
    
    // Frankenstein's Monster Mash
    global.bug_data[$ "frankensteins_monster_mash"] = {
        name: "Frankenstein's Monster Mash",
        flavor_text: "It's where bodyparts mash together! ...no, not in that way, you weirdo.",
        sprite: s_bug_frankensteins_monster_mash,
        locations: { Dead_Woods: 9, Graveyard: 4, Tomb: 4 },
        hp: 120,
        essence: 80
    };
    
    // Vampire Mosquito
    global.bug_data[$ "vampire_mosquito"] = {
        name: "Vampire Mosquito",
        flavor_text: "Pretty much just a normal mosquito, but its skin sparkles in the sunlight.",
        sprite: s_bug_vampire_mosquito,
        locations: { Apple_Grove: 9, Dead_Woods: 9, Graveyard: 3, Haunted_Town: 9, Pumpkin_Patch: 9, Cauldron_Springs: 9 },
        hp: 10,
        essence: 75
    };
    
    // Ghost Face Tic
    global.bug_data[$ "ghost_face_tic"] = {
        name: "Ghost Face Tic",
        flavor_text: "It's based off of Scream... The Scream... you know, the painting.",
        sprite: s_bug_ghost_face_tic,
        locations: { Graveyard: 9, Haunted_Town: 4 },
        hp: 8,
        essence: 70
    };
    
    // Dead Guy's Finger Caterpillar
    global.bug_data[$ "dead_guys_finger_caterpillar"] = {
        name: "Dead Guy's Finger Caterpillar",
        flavor_text: "It's giving you a come-hither squirm from beyond the grave.",
        sprite: s_bug_dead_guys_finger_caterpillar,
        locations: { Graveyard: 4, Tomb: 5 },
        hp: 22,
        essence: 35
    };
    
    // Skull Faced Scorpion
    global.bug_data[$ "skull_faced_scorpion"] = {
        name: "Skull Faced Scorpion",
        flavor_text: "Knock-knock? Who's there? Not you because you're dead now.",
        sprite: s_bug_skull_faced_scorpion,
        locations: { Graveyard: 3 },
        hp: 65,
        essence: 55
    };
    
    // Dead Man's Toe Toadstool
    global.bug_data[$ "dead_mans_toe_toadstool"] = {
        name: "Dead Man's Toe Toadstool",
        flavor_text: "Brings a whole new meaning to toenail fungus.",
        sprite: s_bug_dead_mans_toe_toadstool,
        locations: { Graveyard: 2 },
        hp: 18,
        essence: 45
    };
    
    // Crystal Ball Scarab Beetle
    global.bug_data[$ "crystal_ball_scarab_beetle"] = {
        name: "Crystal Ball Scarab Beetle",
        flavor_text: "It reminds you of the scarab. What scarab? The scarab with the power.",
        sprite: s_bug_crystal_ball_scarab_beetle,
        locations: { Cauldron_Springs: 6 },
        hp: 55,
        essence: 50
    };
    
    // Floating Candle Moth
    global.bug_data[$ "floating_candle_moth"] = {
        name: "Floating Candle Moth",
        flavor_text: "Like a moth to a flame... wait.",
        sprite: s_bug_floating_candle_moth,
        locations: { Apple_Grove: 9, Dead_Woods: 9, Graveyard: 4, Tomb: 9, Haunted_Town: 9, Pumpkin_Patch: 9, Sugar_Lake: 9, Cauldron_Springs: 4 },
        hp: 28,
        essence: 85
    };
    
    // Skeleton Termite
    global.bug_data[$ "skeleton_termite"] = {
        name: "Skeleton Termite",
        flavor_text: "Hear that rattling? Yep, you've definitely got a case of skeleton termites.",
        sprite: s_bug_skeleton_termite,
        locations: { Dead_Woods: 9, Graveyard: 2 },
        hp: 12,
        essence: 60
    };
    
    // Hairy Monster Long Legs
    global.bug_data[$ "hairy_monster_long_legs"] = {
        name: "Hairy Monster Long Legs",
        flavor_text: "This is before his episode on Queer Eye.",
        sprite: s_bug_hairy_monster_long_legs,
        locations: { Dead_Woods: 9, Graveyard: 9, Haunted_Town: 3 },
        hp: 75,
        essence: 70
    };
    
    // Daddy Monster Long Legs
    global.bug_data[$ "daddy_monster_long_legs"] = {
        name: "Daddy Monster Long Legs",
        flavor_text: "This is after his episode on Queer Eye.",
        sprite: s_bug_daddy_monster_long_legs,
        locations: { Haunted_Town: 5 },
        hp: 85,
        essence: 60
    };
    
    // A cup of Star Bugs
    global.bug_data[$ "a_cup_of_star_bugs"] = {
        name: "A Cup of Star Bugs",
        flavor_text: "It smells of magic and freshly ground coffee... and nine dollars burning in your bank account.",
        sprite: s_bug_a_cup_of_star_bugs,
        locations: { Apple_Grove: 9, Dead_Woods: 9, Graveyard: 9, Tomb: 9, Haunted_Town: 9, Pumpkin_Patch: 9, Sugar_Lake: 9, Cauldron_Springs: 9 },
        hp: 200,
        essence: 150
    };
    
    // Dark Night Moth
    global.bug_data[$ "dark_night_moth"] = {
        name: "Dark Night Moth",
        flavor_text: "It is the night. It is... Bat-bug.",
        sprite: s_bug_dark_night_moth,
        locations: { Dead_Woods: 5, Graveyard: 5 },
        hp: 40,
        essence: 45
    };
    
    // The Joker-faced Scarab
    global.bug_data[$ "the_joker_faced_scarab"] = {
        name: "The Joker-faced Scarab",
        flavor_text: "Why so scarab, bat-bug?",
        sprite: s_bug_the_joker_faced_scarab,
        locations: { Dead_Woods: 5, Graveyard: 5 },
        hp: 50,
        essence: 45
    };
}