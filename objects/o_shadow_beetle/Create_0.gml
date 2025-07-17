// Call the parent's create event first
event_inherited();

// Override the stats for Shadow Beetle
bug_hp = 50;
bug_max_hp = 50;
stun_duration = 12;
recovery_window = 20;
can_regenerate = false;
is_fleeting = false;

// FIX: Reset current_hp after overriding bug_hp
current_hp = bug_hp;  // This line fixes it! Patient - stays ready forever