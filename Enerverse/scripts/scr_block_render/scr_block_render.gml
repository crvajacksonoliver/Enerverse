for (var c_x = 0; c_x < room_width / 32 + 1; c_x++)
{
	for (var c_y = 0; c_y < room_height / 32 + 1; c_y++)
	{
		draw_sprite(sprite_index, 0, c_x * 32 - 16 - global.player_x, c_y * 32 - 16 - global.player_y);
	}
}