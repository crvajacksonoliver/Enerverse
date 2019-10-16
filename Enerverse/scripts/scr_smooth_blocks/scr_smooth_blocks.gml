//toned adverage of 3
var smoothFactor = argument[1];
var map0 = argument[0];
var map0Length = array_length_1d(map0);
var map1 = array_create(array_length_1d(map0));

for (var i = floor(smoothFactor / 2); i < map0Length - floor(smoothFactor / 2); i++)
{
	var solution = 0;
	for (var a = 0; a < smoothFactor; a++)
		solution += map0[i - floor(smoothFactor / 2) + a];
	
	map1[i] = solution / smoothFactor;
}

//first edge
for (var i = 0; i < floor(smoothFactor / 2); i++)
{
	var solution = 0;
	for (var a = 0; a < smoothFactor; a++)
		solution += map0[a];
	
	map1[i] = solution / smoothFactor;
}

//last edge
for (var i = 0; i < floor(smoothFactor / 2); i++)
{
	var solution = 0;
	for (var a = 0; a < smoothFactor; a++)
		solution += map0[map0Length - a - 1];
	
	map1[map0Length - i - 1] = solution / smoothFactor;
}

return map1;