var defaultBlocks = 20;
var blocksIZoom = (defaultBlocks / global.zoom_factor);
var blockSize = room_height / blocksIZoom;

for (var c_x = 0; c_x < (room_width / blockSize) + 2; c_x++)
{
	for (var c_y = 0; c_y < (room_height / blockSize) + 2; c_y++)
	{
		var use_x = floor(global.player_x + c_x - ((room_width / 2) / blockSize));
		var use_y = floor(global.player_y + c_y - ((room_height / 2) / blockSize));
		var sprite_idx = 0;
		
		if (use_x > 0 && use_y > 0 && use_x < global.active_world_width && use_y < global.active_world_height)
		{
			sprite_idx = global.active_world_blocks[((use_y * global.active_world_width) + use_x) * 2];
		}
		
		draw_sprite_stretched(sprite_index, sprite_idx, c_x * blockSize + (floor(global.player_x * -32) % blockSize) - blocksIZoom, c_y * blockSize + ((global.player_y * 32) % blockSize) - blockSize, blockSize, blockSize);
	}
}

draw_sprite_stretched(global.current_player, 0, (room_width / 2) - 16, (room_height / 2) - 32, blockSize, blockSize * 2);