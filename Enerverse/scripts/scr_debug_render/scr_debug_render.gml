if (!global.settings[0])
	return;

draw_set_font(36);
draw_set_color(c_white);

draw_text(10, 10, string(global.debug_menu[0]));
//draw_text(10, 100, string(global.debug));