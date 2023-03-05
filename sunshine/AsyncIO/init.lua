local _module_0 = { }
local coroutine = coroutine
local Task = require("sunshine.AsyncIO.Task")
_module_0["Task"] = Task
local async
async = function(fn)
	return coroutine.create(fn)
end
_module_0["async"] = async
local await
await = function(...)
	return coroutine.yield(...)
end
_module_0["await"] = await
return _module_0
