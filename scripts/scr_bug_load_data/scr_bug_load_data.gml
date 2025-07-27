// scr_bug_load_data() - Call this AFTER setting bug_type
function scr_bug_load_data() {
    if (variable_struct_exists(global.bug_data, bug_type)) {
        var data = global.bug_data[$ bug_type];
        bug_name = data.name;
        flavor_text = data.flavor_text;
        sprite_index = data.sprite;
        bug_hp = data.hp;
        bug_max_hp = data.hp;
        current_hp = bug_hp;
        essence_value = data.essence;
    }
}