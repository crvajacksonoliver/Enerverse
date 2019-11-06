if (!global.settings[0])
	return;

draw_set_font(36);
draw_set_color(c_white);

for (var i = 0; i < array_length_1d(global.debug_menu); i++)
{
	draw_text(5, 5 + (i * 20), string(global.debug_menu[i]));	
}
