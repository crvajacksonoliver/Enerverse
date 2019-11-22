/// @param {string} command

var command = argument[0];
var baseCommand = "";
var i = 1;// for the '>' infront

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
		if (i >= string_length(command))
			return false;
		
		unlocalizedName += string_char_at(command, i + 1);
		i++;
	}
	
	i++;
	
	while (string_char_at(command, i + 1) != " ")
	{
		if (i >= string_length(command))
			return false;
		
		bx += string_char_at(command, i + 1);
		i++;
	}
	
	i++;
	
	while (string_char_at(command, i + 1) != " ")
	{
		if (i >= string_length(command))
			return false;
		
		by += string_char_at(command, i + 1);
		i++;
	}
	
	i++;
	
	while (i < string_length(command))
	{
		parameters += string_char_at(command, i + 1);
		i++;
	}
	
	scr_block_set(real(bx), real(by), unlocalizedName, parameters);
}

return true;