local FrozenObjectMutationException
do
	local _obj_0 = require("sunshine.Exception")
	FrozenObjectMutationException = _obj_0.FrozenObjectMutationException
end
local Object
do
	local _class_0
	local _base_0 = {
		__tostring = function(self)
			return "<'" .. tostring(self.__class.__name) .. "' instance>"
		end,
		repr = function(self)
			return "<'\027[1m" .. tostring(self.__class.__name) .. "\027[0m' \027[3minstance\027[0m>"
		end,
		__index = function(self, key)
			if key == "__private" then
				return rawget(self, key)
			end
			local p = rawget(self, "__private")
			do
				local getter = self["get_" .. key]
				if getter then
					return getter(self)
				end
			end
			do
				local getter = p.get
				if getter then
					return getter(self, key)
				end
			end
			do
				local item = rawget(self.__class, key)
				if item then
					return item
				end
			end
			if p.auto_properties then
				local _obj_0 = self
				local _update_0 = "get_" .. key
				if _obj_0[_update_0] == nil then
					_obj_0[_update_0] = function(self)
						return p[key]
					end
				end
				return self["get_" .. key]()
			end
			return getmetatable(self)[key]
		end,
		__newindex = function(self, key, value)
			if p.frozen then
				FrozenObjectMutationException():raise()
				return
			end
			if key == "__private" then
				rawset(self, key, value)
				return
			end
			local p = rawget(self, "__private")
			do
				local setter = self["set_" .. key]
				if setter then
					setter(self, value)
					return
				end
			end
			do
				local setter = p.set
				if setter then
					setter(self, key, value)
					return
				end
			end
			if p.auto_properties then
				self["set_" .. key] = function(self, value)
					p[key] = value
				end
				self["set_" .. key](value)
				return
			end
			return rawset(self, key, value)
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
			rawset(self, "__private", {
				initialized = false,
				frozen = false,
				properties = { },
				auto_properties = false
			})
			if self.init then
				self:init(args)
			end
			self.__private.initialized = true
		end,
		__base = _base_0,
		__name = "Object"
	}, {
		__index = _base_0,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	Object = _class_0
	return _class_0
end
