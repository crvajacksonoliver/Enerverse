/// @param {string} command

var command = argument[0];
var baseCommand = "";
var i = 0;

while (true)
{
	if (i >= string_length(command))
		return false;
	
	if (string_char_at(command, i + 1) == " ")
		break;
	
	baseCommand += string_char_at(command, i + 1);
	i++;
}

i++;

if (baseCommand == "setblock")
{
	var bx = "";
	var by = "";
	var unlocalizedName = "";
	var parameters = "";
	
	while (string_char_at(command, i + 1) != " ")
	{
		if (i >= string_char_at(command, i + 1))
			return false;
		
		unlocalizedName += string_char_at(command, i + 1);
		i++;
	}
	
	bx += "";
}