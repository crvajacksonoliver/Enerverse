if (global.UI_active_anti_mouse_left && !mouse_check_button(mb_left))
{
	global.UI_active_anti_mouse_left = false;
	global.UI_active = false;
}

if (global.button_down_anti_mouse_left && !mouse_check_button(mb_left))
{
	global.button_down = false;
	global.button_down_anti_mouse_left = false;
}