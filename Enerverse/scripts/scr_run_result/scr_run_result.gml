/// @param {string} unparsed

var unparsed = argument[0];
var parsed = "";

var system = ds_list_create();

for (var i = 1; i < string_length(unparsed); i++)
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
		ds_list_add(system, parsed);
		parsed = "";
	}
}