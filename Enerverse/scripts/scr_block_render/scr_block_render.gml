for (var c_x = 0; c_x < (room_width / 32) + 2; c_x++)
{
	for (var c_y = 0; c_y < (room_height / 32) + 2; c_y++)
	{
		var use_x = floor((global.player_x) / -32) + c_x;
		var use_y = floor(global.player_y / -32) + c_y;
		var sprite_idx = 0;
		
		if (use_x < global.active_world_width && use_y < global.active_world_height && use_x >= 0 && use_y >= 0)
		{
			sprite_idx = global.active_world_blocks[((use_y * global.active_world_width) + use_x) * 2];
		}
		
		draw_sprite(sprite_index, sprite_idx, c_x * 32 + (global.player_x % 32) - 32, c_y * 32 + (global.player_y % 32) - 32 - (((room_height / 32) - floor(room_height / 32)) * 32));
	}
}

draw_sprite(global.current_player, 0, (room_width / 2) - 16, (room_height / 2) - 32);