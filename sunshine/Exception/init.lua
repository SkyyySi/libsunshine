local _module_0 = { }
local traceback
xpcall(function()
	traceback = require("yue").traceback
end, function(err)
	traceback = debug.traceback
end)
local Util = require("sunshine.Util")
local Exception
do
	local _class_0
	local _base_0 = {
		message_format = "An error occurred",
		raise = function(self)
			error()
			return print(traceback(self, 2):gsub("\r\n", "\n"))
		end,
		assert = function(self, cond)
			if not cond then
				return self:raise()
			end
		end,
		__tostring = function(self)
			return "\027[1;31m" .. tostring(self.__class.__name) .. "\027[0m\027[31m" .. Util.format(self.message_format, {
				e = self.__class.__name,
				m = self.message
			}) .. "\027[0m"
		end
	}
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	_class_0 = setmetatable({
		__init = function(self, args)
			if args == nil then
				args = { }
			end
			do
				local _exp_0 = args.message
				if _exp_0 ~= nil then
					self.message = _exp_0
				else
					self.message = self.__class.default_message
				end
			end
		end,
		__base = _base_0,
		__name = "Exception"
	}, {
		__index = _base_0,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	Exception = _class_0
end
_module_0["Exception"] = Exception
local FrozenObjectMutationException
do
	local _class_0
	local _parent_0 = Exception
	local _base_0 = {
		message_format = "Attempted to modify a frozen object"
	}
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "FrozenObjectMutationException",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	FrozenObjectMutationException = _class_0
end
_module_0["FrozenObjectMutationException"] = FrozenObjectMutationException
local MissingArgumentException
do
	local _class_0
	local _parent_0 = MissingParameterException
	local _base_0 = {
		message_format = "Missing required table argument",
		assert = function(self, argument)
			if argument == nil then
				return self:raise()
			end
		end
	}
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "MissingArgumentException",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	MissingArgumentException = _class_0
end
_module_0["MissingArgumentException"] = MissingArgumentException
return _module_0
