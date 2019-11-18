global.active_world_blocks = array_create(global.active_world_width * global.active_world_height * 2, 0);

for (var i = 0; i < global.active_world_width * global.active_world_height; i++)
	scr_block_set(i % global.active_world_width, floor(i / global.active_world_width), "EnerverseVin/block_air", "");

//create elevation noise map
var elevationMap0 = array_create(global.active_world_width);
for (var i = 0; i < global.active_world_width; i++)
{
	elevationMap0[i] = random(global.active_world_height - 10) + 5;
}

var elevationMap1;
//smooth world
{
	elevationMap1 = scr_smooth_blocks(elevationMap0, 3);
	
	elevationMap1 = scr_smooth_blocks(elevationMap1, 10);
	elevationMap1 = scr_smooth_blocks(elevationMap1, 4);
}

//floor5

var elevationMap2 = array_create(global.active_world_width);
for (var i = 0; i < global.active_world_width; i++)
{
	elevationMap2[i] = floor(elevationMap1[i]);
}

//use elevation noise map
var lanternCooldown = 0;
var lanternNodeActive = 0;
for (var i = 0; i < global.active_world_width; i++)
{
	var elevation = elevationMap2[i];
	
	for (var a = 0; a < elevation; a++)
		scr_block_set(i, a, "EnerverseVin/block_dirt", "0,");
	
	scr_block_set(i, elevation, "EnerverseVin/block_grass", "0,");
	
	if (lanternNodeActive > 0)
	{
		lanternNodeActive--;
		
		if (floor(random(2)) == 0)
			scr_block_set(i, elevation + 1, "EnerverseDecor/block_lantern", "0,");
		
		if (lanternNodeActive == 0)
			lanternCooldown = 6;
	}
	else
	{
		if (lanternCooldown == 0)
		{
			if (floor(random(10)) == 0)
			{
				lanternNodeActive = 6;
			}
		}
		else
			lanternCooldown--;
	}
}