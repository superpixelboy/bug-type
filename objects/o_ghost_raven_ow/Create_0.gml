// Dialogue system
dialogue_state = "greeting";
dialogue_index = 0;
dialogue_active = false;
dialogue_cooldown = 0;

// Dialogue arrays for different states
dialogue_greeting = [
    "What are you waiting for? You've got to get to Baba Yaga's hut now! Just follow the trail to the East. You can't miss it.",
 
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