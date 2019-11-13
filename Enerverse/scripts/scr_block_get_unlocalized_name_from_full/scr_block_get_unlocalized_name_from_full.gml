/// @param {string} unlocalizedName

var block = argument[0];
var blockMod = "";

for (var i = 1; i <= string_length(block); i++)
{	
	if (string_char_at(block, i) == "/")
	{
		i++;
		
		while (i <= string_length(block))
		{
			blockMod += string_char_at(block, i);
			i++;
		}
		
		return blockMod;
	}
}

return "";