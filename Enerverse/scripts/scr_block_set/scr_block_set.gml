// x y name meta
global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2] = scr_get_block_id(argument[2]);
global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2 + 1] = scr_get_block_id(argument[3]);