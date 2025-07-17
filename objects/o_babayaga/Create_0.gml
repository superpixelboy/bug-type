// Dialogue system
dialogue_state = "greeting";
dialogue_index = 0;
dialogue_active = false;
dialogue_cooldown = 0;

// Dialogue arrays for different states
dialogue_greeting = [
    "Ah, my young apprentice awakens!",
    "I need you to collect magical bugs for my potions.",
    "Different creatures hold different powers...",
    "Start with the forest - look under every rock!"
];

dialogue_progress = [
    "Let me see what you've gathered...",
    "You have " + string(global.bugs_caught) + " reagents so far.",
    "Keep searching - I need many more for my spells!"
];

dialogue_encouragement = [
    "The mossy rocks often hide the swiftest creatures.",
    "Cracked stones conceal the most mysterious bugs.",
    "Don't forget to rest when you need new rocks to appear!"
];