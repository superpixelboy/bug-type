// Call the parent's create event first
event_inherited();

// Override the stats for Shadow Beetle
bug_hp = 20;
bug_max_hp = 20;
essence_value =12;
stun_duration = 20;
can_regenerate = false;
is_fleeting = false;

// FIX: Reset current_hp after overriding bug_hp
current_hp = bug_hp;  // This line fixes it! Patient - stays ready forever