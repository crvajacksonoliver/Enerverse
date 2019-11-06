if (global.settings[0])
{
	global.debug_menu[0] = "PX: " + string_format(global.player_x, 1, 6);
	global.debug_menu[1] = "PY: " + string_format(global.player_y, 1, 6);
	global.debug_menu[2] = "DT: " + string_format(delta_time / 1000.0, 1, 2);
	global.debug_menu[3] = "";
}