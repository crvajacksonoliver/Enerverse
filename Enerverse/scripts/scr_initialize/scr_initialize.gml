var blocks = instance_create_depth(0, 0, 10, obj_blocks);
with (blocks)
{
	var block = sprite_add("workingset/dirt.png", 1, false, false, 0, 0);
	block = script_execute(scr_merge_sprite, block, "workingset/grass.png");
	
	sprite_assign(sprite_index, block);
	
	//image_xscale = 2;
	//image_yscale = 2;
	//image_index = 2;
}