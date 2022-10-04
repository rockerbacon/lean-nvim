--- @class DeferencePool
--- @field queue (fun(): nil)[]
--- @field is_deferring boolean
local DeferencePool = {}
DeferencePool.__index = DeferencePool

--- Queues a function for execution
--- The function will be deferred until a call to DeferencePool.flush
--- If the pool is in a non-deferring state, the function is executed immediately
--- @param self DeferencePool
--- @param fn fun(): nil
function DeferencePool.call(self, fn)
	if self.is_deferring then
		table.insert(self.queue, fn)
	else
		fn()
	end
end

--- Executes all currently queued functions in order
--- and sets the pool to a non-deferring state
--- @param self DeferencePool
function DeferencePool.flush(self)
	if self.is_deferring then
		self.is_deferring = false

		for _, fn in ipairs(self.queue) do
			fn()
		end

		self.queue = nil
	end
end

--- Clears the pool queue and sets the pool to a deferring state
--- @param self DeferencePool
function DeferencePool.reset(self)
	self.queue = {}
	self.is_deferring = true
end

--- Instantiates a new deference pool in a deferring state
--- @return DeferencePool
function DeferencePool.new()
	local instance = setmetatable({}, DeferencePool)
	instance:reset()
	return instance
end

return DeferencePool

