for (var i = 0; i < ds_list_size(global.chat); i++)
{
	draw_text_color(10, room_height - ((global.gui_scale * 32) + 10) - (i * 20), ds_list_find_value(global.chat, i), c_white, c_white, c_white, c_white, 1.0);
}