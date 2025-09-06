/// o_intro_manager : Create

// --- CONFIG ---
target_room          = rm_spooky_forest;
margin               = 24;
line_spacing         = 50;
text_color           = c_white;
shadow_color         = c_orange;
shadow_ofs           = 1;
use_sound_advance    = true;

// Screen fade
fade_alpha           = 1;      // start fully black
fade_speed           =  5;
global_fade          = "in";   // "in" -> "show" -> "out"

// Input/UI
input_cooldown       = 6;
next_blink_interval  = 30;
blink_timer          = 0;
continue_hint        = "";
skip_held            = false;

// Fonts
ui_font = font_exists(fnt_intro_text) ? fnt_intro_text : -1;

// --- STORY PAGES --- (define before using)
pages = [
    "Night fell on the Spooky Forest.\nA young witch took a job from Baba Yaga.",
    "Fetch rare reagents, she said.\nStir the right potion, she promised.",
    "Lift every rock.\nListen for skitters.\nEssence is payment, courage is tax."
];

// --- PAGE STATE --- (define index BEFORE reading pages[index])
page_index      = 0;
page_alpha      = 0;           // paragraph fade
page_fade_speed = .005;
page_state      = "fade_in";   // "fade_in" -> "hold"

// Cache current page (safe now that page_index exists)
current_text = pages[page_index];

// Safe tap helper (no crash if sound missing)
function _tap() {
    if (!use_sound_advance) return;
    var snd = asset_get_index("sn_bugtap1"); // lookup by name
    if (snd != -1) audio_play_sound(snd, 1, false);
}
