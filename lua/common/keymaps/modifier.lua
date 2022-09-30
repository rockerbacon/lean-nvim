--- @class Modifier
--- @field key string
--- @operator add(string): string
--- @operator add(Modifier): Modifier
local Modifier = {}

--- Checks if key is a special key. eg: esc, tab, Ctrl+M
--- @param key string string representing the key
--- @return boolean true if key is a special key and false otherwise
local function check_is_special_key(key)
	return key:sub(1, 1) == '<'
end

--- Checks if candidate is a modifier key
--- @param candidate any
--- @return boolean true if candidate is an instance of Modifier and false otherwise
local function is_modifier(candidate)
	if type(candidate) == 'table' then
		return candidate.key ~= nil
	else
		return false
	end
end

--- Combines two modifier keys
--- @param a Modifier
--- @param b Modifier
--- @return Modifier combination of the two modifiers
local function combine_modifiers(a, b)
	return Modifier.new(a.key..'-'..b.key)
end

--- Combines a modifier and a key
--- @param modifier Modifier
--- @param key string
--- @return string combination of the modifier and key
local function combine_modifier_and_key(modifier, key)
	if check_is_special_key(key) then
		local trimmed_key = key:sub(2)
		return '<'..modifier.key..'-'..trimmed_key
	else
		return '<'..modifier.key..'-'..key..'>'
	end
end

--- Combine two keys
--- @param a Modifier key to be combined
--- @param b string|Modifier key to be combined
--- @return string|Modifier the key combination
local function combine_keys(a, b)
	if is_modifier(b) then
		return combine_modifiers(
			a,
			b --[[@as Modifier]]
		)
	else
		return combine_modifier_and_key(
			a,
			b --[[@as string]]
		)
	end
end
Modifier.combine = combine_keys

--- Converts modifier into a string
--- @param self Modifier
--- @return string
function Modifier.tostring(self)
	return self.key
end

local modifier_meta = {
	__tostring = Modifier.tostring,
	__add = Modifier.combine,
}

--- Instantiate new Modifier
--- @param key string neovim string for the modifier key. eg: C for Ctrl
--- @return Modifier
function Modifier.new(key)
	local new_instance = {
		key = key
	}
	setmetatable(new_instance, modifier_meta)
	return new_instance
end

return Modifier
