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

i++;

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
	{
		var meta = ds_list_find_value(system, 0);
		ds_list_destroy(system);
		return meta;
	}
	
	var a = 0;
	while (true)
	{
		if (ds_list_find_value(system, a) == "0")
		{// set block
			scr_block_set(real(ds_list_find_value(system, a + 1)), real(ds_list_find_value(system, a + 2)), ds_list_find_value(system, a + 3), ds_list_find_value(system, a + 4));
			a += 4;
		}
		
		a++;
		
		if (a == ds_list_size(system) - 1)
			break;
	}
	
	var meta = ds_list_find_value(system, ds_list_size(system) - 1);
	ds_list_destroy(system);
	return meta;
}
else if (type == "1")
{
	for (var a = 0; a < ds_list_size(system); a++)
	{
		//run commands
	}
}
