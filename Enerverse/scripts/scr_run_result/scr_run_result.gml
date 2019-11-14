/// @param {string} unparsed

var unparsed = argument[0];
var parsed = "";

var system = ds_list_create();

var i = 1;
var type = "";

while (string_char_at(unparsed, i) != ";")
{
	type += string_char_at(unparsed, i);
	i++;
}

while (i < string_length(unparsed) + 1)
{
	if (string_char_at(unparsed, i) == "\\" && string_char_at(unparsed, i + 1) == "\\")
	{
		parsed += "\\";
		i++;
	}
	else if (string_char_at(unparsed, i) == "\\" && string_char_at(unparsed, i + 1) == ",")
	{
		parsed += ",";
		i++;
	}
	else if (string_char_at(unparsed, i) == "\\" && string_char_at(unparsed, i + 1) == ";")
	{
		parsed += ";";
		i++;
	}
	else if (string_char_at(unparsed, i) == ";")
	{
		if (i > 1)
			ds_list_add(system, parsed);
		
		parsed = "";
	}
	else
		parsed += string_char_at(unparsed, i);
	
	i++;
}

if (type == "0")
{
	if (ds_list_find_value(system, ds_list_size(system) - 1) == "2")
	{
		var reee = 0;
	}
	
	if (ds_list_size(system) == 1)
		return ds_list_find_value(system, 0);
	
	for (var a = 0; a < ds_list_size(system) - 1; a++)
	{
		//run commands
	}
	
	return ds_list_find_value(system, ds_list_size(system) - 1);
}
else if (type == "1")
{
	for (var a = 0; a < ds_list_size(system); a++)
	{
		//run commands
	}
}
