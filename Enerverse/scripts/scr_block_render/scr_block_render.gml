
if (!global.settings[1])
	shader_set(sdr_block_final);
else
{
	draw_clear(c_black);
	surface_set_target(s0);
	draw_clear(c_black);
	surface_reset_target();
	surface_set_target(s1);
	draw_clear(c_blue);
	surface_reset_target();
	surface_set_target(s2);
	draw_clear(c_black);
	surface_reset_target();
}

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
		
		//SX IS WRONG
		var sx = c_x * blockSize + (floor((2 * global.player_x * -32 * global.zoom_factor) / ((room_width / room_height) - floor(room_width / room_height) + 1)) % blockSize) - (blockSize * 1.5) + ((room_width * 0.5) % blockSize);
		var sy = c_y * blockSize + (((2 * global.player_y * 32 * global.zoom_factor) / ((room_width / room_height) - floor(room_width / room_height) + 1)) % blockSize) - (blockSize * 2) + ((room_height * 0.5) % blockSize);
		
		if (c_x == 0)
			global.debug = sx;
		
		var over = false;
		
		if (use_x < 0 || use_x >= global.active_world_width || use_y < 0 || use_y >= global.active_world_height)
		{
			shader_set_uniform_i(shader_get_uniform(sdr_block_final, "u_Box"), 0);
		}
		else
		{
			over = mouse_x >= sx && mouse_x < sx + blockSize && mouse_y >= sy && mouse_y < sy + blockSize;
			
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
			surface_set_target(s2);
			
			with (bloomTextures)
				draw_sprite_stretched(sprite_index, sprite_idx, sx, sy, blockSize, blockSize);
				
			surface_reset_target();
			
			surface_set_target(s2);
			gpu_set_blendmode_ext(bm_zero, bm_src_color);
			shader_set(sdr_block_mul);
			shader_set_uniform_f(shader_get_uniform(sdr_block_mul, "u_Mul"), global.settings[3]);
			draw_sprite_stretched(sprite_index, sprite_idx, sx, sy, blockSize, blockSize);
			shader_reset();
			gpu_set_blendmode(bm_normal);
			surface_reset_target();
			
			surface_set_target(s1);
			shader_set(sdr_block_final);
			
			if (over)
				shader_set_uniform_i(shader_get_uniform(sdr_block_final, "u_Box"), 1);
			else
				shader_set_uniform_i(shader_get_uniform(sdr_block_final, "u_Box"), 0);
			
			draw_sprite_stretched(sprite_index, sprite_idx, sx, sy, blockSize, blockSize);
			shader_reset();
			surface_reset_target();
		}
		else
		{
			if (over)
				shader_set_uniform_i(shader_get_uniform(sdr_block_final, "u_Box"), 1);
			else
				shader_set_uniform_i(shader_get_uniform(sdr_block_final, "u_Box"), 0);
				
			draw_sprite_stretched(sprite_index, sprite_idx, sx, sy, blockSize, blockSize);
		}
	}
}

if (global.settings[1])
{
	shader_set(sdr_block_blur);
	shader_set_uniform_f(shader_get_uniform(sdr_block_blur, "u_Mul"), global.settings[3]);
	shader_set_uniform_i(shader_get_uniform(sdr_block_blur, "u_Horizontal"), 0);
	shader_set_uniform_f(shader_get_uniform(sdr_block_blur, "u_TextureSizeX"), global.settings[2] / room_width);
	shader_set_uniform_f(shader_get_uniform(sdr_block_blur, "u_TextureSizeY"), global.settings[2] / room_height);
	
	//blur top and move to bottom
	
	surface_set_target(s0);
	draw_surface(s2, 0, 0);
	surface_reset_target();
	
	shader_reset();
	
	//add bottom to middle
	surface_set_target(s0);
	gpu_set_blendmode(bm_add);
	draw_surface(s1, 0, 0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	
	//render middle to bottom with final
	draw_surface(s0, 0, 0);
}

if (!global.settings[1])
	shader_reset();

draw_sprite_stretched(global.current_player, 0, (room_width / 2) - (blockSize / 2), (room_height / 2) - blockSize, blockSize, blockSize * 2);
