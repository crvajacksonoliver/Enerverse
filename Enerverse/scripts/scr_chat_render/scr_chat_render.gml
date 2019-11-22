for (var i = 0; i < ds_list_size(global.chat); i++)
{
	if (i == 10)
		break;
	
	var fi = ds_list_size(global.chat) - i - 1;
	draw_text_color(10, room_height - ((global.gui_scale * 32) + 10 + 32 + 32) - (i * 20), ds_list_find_value(global.chat, fi), c_white, c_white, c_white, c_white, 1.0);
}

if (global.chat_open)
{
	var chatTextY = room_height - ((global.gui_scale * 32) + 10 + 32);
	
	draw_set_color(make_color_rgb(40, 40, 40));
	draw_rectangle(0, chatTextY, room_width, chatTextY + 20, false);
	
	draw_set_color(c_white);
	draw_text(10, chatTextY, global.chat_text);

	var atText = "";
	for (var i = 0; i < string_length(global.chat_text); i++)
	{
		if (i == global.chat_marker)
			break;
	
		atText += string_char_at(global.chat_text, i);
	}
	
	draw_set_color(make_color_rgb(159, 222, 151));
	draw_rectangle(10 + string_width(atText) - 1, chatTextY, 10 + string_width(atText) + 1, chatTextY + 20, false);
	
	draw_text(100, 100, string(global.chat_marker));
}