
if (keyboard_check_pressed(vk_tab) && global.in_world && !global.game_paused)
{
	global.inventory_open = !global.inventory_open;
}

//
//	NO CHAT AFTER THIS
//

//kill chat
if (global.chat_open)
	return;

if (keyboard_check_pressed(vk_escape) && global.in_world && !global.game_paused)
{
	global.game_paused = true;
	
	var buttonBack = scr_ui_register_render_button(room_width * 0.6, (room_width * 0.6) / 15, 0.0, 0.1, 0.4, "Back to Game", 1.5, scr_button_pm_back);
	
	with (buttonBack)
	{
		x = (room_width / 2) - ((room_width * 0.6) / 2);
		y = (room_height / 2) - (((room_height * 0.6) / 15));
	}
	
	var buttonBloomText;
	
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
}
else if (keyboard_check_pressed(vk_escape) && global.in_world && global.game_paused)
{
	scr_button_pm_back();
}