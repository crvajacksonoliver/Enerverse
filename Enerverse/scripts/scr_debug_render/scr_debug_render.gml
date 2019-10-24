if (!global.settings[0])
	return;

draw_set_font(36);
draw_set_color(c_white);

draw_text(10, 10, string(global.debug_menu[0]));
for (var i = 0; i < array_length_1d(global.debug); i++)
{
	draw_text(10, 100 + (i * 20), string(global.debug[i]));
}