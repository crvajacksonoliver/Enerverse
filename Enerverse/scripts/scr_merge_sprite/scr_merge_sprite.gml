/// merges 2 sprites

// take arguments
var path = argument[1];
var startSprite = argument[0];

// create and merge
var createdSprite = sprite_add(path, 1, false, false, 0, 0);

if (createdSprite == -1)
	return startSprite;

sprite_merge(startSprite, createdSprite);
return startSprite;