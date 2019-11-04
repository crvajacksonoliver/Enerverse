scr_ui_deregister_render_button(global.bloom_toggle_button);

global.settings[1] = !global.settings[1];

if (global.settings[1])
	buttonBloomText = "Bloom - Enabled";
else
	buttonBloomText = "Bloom - Disabled";

var buttonToggleBloom = scr_ui_register_render_button(room_width * 0.6, (room_width * 0.6) / 15, 0.0, 0.1, 0.4, buttonBloomText, 1.5, scr_button_pm_bloom_toggle);

with (buttonToggleBloom)
{
	x = (room_width / 2) - ((room_width * 0.6) / 2);
	y = (room_height / 2) + (((room_height * 0.6) / 15));
}

global.bloom_toggle_button = buttonToggleBloom;