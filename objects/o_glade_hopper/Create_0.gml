// Call the parent's create event first
event_inherited();

// Override the stats for Shadow Beetle
bug_hp = 40;
bug_max_hp = 40;
essence_value = 20;
stun_duration = 5;
can_regenerate = false;
is_fleeting = false;

// FIX: Reset current_hp after overriding bug_hp
current_hp = bug_hp;  // This line fixes it! Patient - stays ready forever