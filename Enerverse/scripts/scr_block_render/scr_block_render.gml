
if (!global.settings[1])
	shader_set(sdr_block_final);

var blockSize = room_height / (20 / global.zoom_factor);

for (var c_x = 0; c_x < (room_width / blockSize) + 2; c_x++)
{
	for (var c_y = 0; c_y < (room_height / blockSize) + 2; c_y++)
	{
		var use_x = floor(((room_width / blockSize)) - (((room_width / blockSize) + 2) - c_x) - ((room_width / blockSize) / 2) + 1) + floor(global.player_x);// + global.active_world_width;
		var use_y = floor(((room_height / blockSize)) - c_y - ((room_height / blockSize) / 2) + 1) + floor(global.player_y);
		var sprite_idx = 0;
		
		if (use_x >= 0 && use_y >= 0 && use_x < global.active_world_width && use_y < global.active_world_height)
		{
			sprite_idx = global.active_world_blocks[((use_y * global.active_world_width) + use_x) * 2];
		}
		
		var sx = c_x * blockSize + (floor((2 * global.player_x * -32 * global.zoom_factor) / ((room_width / room_height) - floor(room_width / room_height) + 1)) % blockSize) - (blockSize * 1.5) + ((room_width * 0.5) % blockSize);
		var sy = c_y * blockSize + (((2 * global.player_y * 32 * global.zoom_factor) / ((room_width / room_height) - floor(room_width / room_height) + 1)) % blockSize) - (blockSize * 2) + ((room_height * 0.5) % blockSize);
		
		if (use_x < 0 || use_x >= global.active_world_width || use_y < 0 || use_y >= global.active_world_height)
		{
			shader_set_uniform_i(shader_get_uniform(sdr_block_final, "u_Box"), 0);
		}
		else
		{
			var over = mouse_x >= sx && mouse_x < sx + blockSize && mouse_y >= sy && mouse_y < sy + blockSize;
			if (over)
			{
				shader_set_uniform_i(shader_get_uniform(sdr_block_final, "u_Box"), 1);
				if (mouse_check_button_pressed(mb_left))
				{
					global.active_world_blocks[((use_y * global.active_world_width) + use_x) * 2] = scr_get_block_id("EnerverseVin/block_sod");
				}
			}
			else
				shader_set_uniform_i(shader_get_uniform(sdr_block_final, "u_Box"), 0);
		}
		
		if (global.settings[1])
		{
			var ps = processedSurface;
			with (bloomTextures)
			{
				surface_set_target(ps);
				draw_sprite_stretched(sprite_index, sprite_idx, sx, sy, blockSize, blockSize);
				surface_reset_target();
			}
			
			surface_set_target(processedSurface);
			gpu_set_blendmode_ext(bm_zero, bm_src_color);
			//draw_sprite_stretched(sprite_index, sprite_idx, sx, sy, blockSize, blockSize);
			gpu_set_blendmode(bm_normal);
			surface_reset_target();
			
			//surface_reset_target();
			//surface_set_target(finalSurface);
			//
			//draw_sprite_stretched(sprite_index, sprite_idx, sx, sy, blockSize, blockSize);
			//surface_reset_target();
		}
		else
			draw_sprite_stretched(sprite_index, sprite_idx, sx, sy, blockSize, blockSize);
	}
}

if (global.settings[1])
{
	shader_set(sdr_block_blur);
	shader_set_uniform_i(shader_get_uniform(sdr_block_blur, "u_Horizontal"), 0);
	shader_set_uniform_f(shader_get_uniform(sdr_block_blur, "u_TextureSizeX"), 20 / room_width);
	shader_set_uniform_f(shader_get_uniform(sdr_block_blur, "u_TextureSizeY"), 20 / room_height);
	
	//blur top and move to bottom
	
	surface_set_target(jointSurface);
	draw_surface(processedSurface, 0, 0);
	
	shader_reset();
	//surface_reset_target();
	//surface_set_target(finalSurface);
	
	//add bottom to middle
	gpu_set_blendmode(bm_add);
	//draw_surface(jointSurface, 0, 0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	
	//render middle to bottom with final 
	//draw_set_color(c_white);
	//draw_rectangle(0, 0, room_width, room_height, false);
	shader_set(sdr_block_final);
	//draw_surface(finalSurface, 0, 0);
	shader_reset();
	//surface_reset_target();
}

if (!global.settings[1])
	shader_reset();

draw_sprite_stretched(global.current_player, 0, (room_width / 2) - (blockSize / 2), (room_height / 2) - blockSize, blockSize, blockSize * 2);
