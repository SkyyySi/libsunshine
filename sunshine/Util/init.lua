local _module_0 = { }
local MissingArgumentException
do
	local _obj_0 = require("sunshine.Exception")
	MissingArgumentException = _obj_0.MissingArgumentException
end
local parse_function_args
parse_function_args = function(args)
	if args.create_properties == nil then
		args.create_properties = false
	end
	return args
end
_module_0["parse_function_args"] = parse_function_args
local format
format = function(str, data)
	for k, v in pairs(data) do
		str = str:gsub("%%" .. tostring(k:gsub("%%", "%%")), v)
	end
	return str
end
_module_0["format"] = format
return _module_0
