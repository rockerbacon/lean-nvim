--- @class Leader
--- @field key string
--- @operator add(string): string
local Leader = {}

--- Combines leader and a key
--- @param self Leader
--- @param key string
function Leader.combine(self, key)
	return self.key..key
end

local leader_meta = {
	__add = Leader.combine
}

function Leader.new()
	local new_instance = {
		key = '<leader>'
	}
	setmetatable(new_instance, leader_meta)
	return new_instance
end

return Leader

