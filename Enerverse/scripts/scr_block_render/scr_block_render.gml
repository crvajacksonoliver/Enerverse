var blockSize = room_height / (20 / global.zoom_factor);

for (var c_x = 0; c_x < (room_width / blockSize) + 2; c_x++)
{
	for (var c_y = 0; c_y < (room_height / blockSize) + 2; c_y++)
	{
		var use_x = floor(((room_width / blockSize)) - c_x - ((room_width / blockSize) / 2) + 1) - floor(global.player_x) + global.active_world_width;
		var use_y = floor(((room_height / blockSize)) - c_y - ((room_height / blockSize) / 2) + 2) + floor(global.player_y);
		var sprite_idx = 0;
		
		global.debug = use_x;
		
		if (use_x >= 0 && use_y >= 0 && use_x < global.active_world_width && use_y < global.active_world_height)
		{
			sprite_idx = global.active_world_blocks[((use_y * global.active_world_width) + use_x) * 2];
		}
		
		draw_sprite_stretched(sprite_index, sprite_idx,
			c_x * blockSize + (floor((2 * global.player_x * -32 * global.zoom_factor) / ((room_width / room_height) - floor(room_width / room_height) + 1)) % blockSize) - (blockSize * 1.5) + ((room_width * 0.5) % blockSize),// + ((1 - ((room_width / room_height) - floor(room_width / room_height))) * blockSize),
			c_y * blockSize + ((global.player_y * 32 * global.zoom_factor) % blockSize) - (blockSize * 2) + ((room_height * 0.5) % blockSize),
			blockSize, blockSize);
	}
}

draw_sprite_stretched(global.current_player, 0, (room_width / 2) - (blockSize / 2), (room_height / 2) - blockSize, blockSize, blockSize * 2);
