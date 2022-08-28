DeferencePool = {}

function DeferencePool.call(self, fn)
	if self.is_deferring then
		table.insert(self.queue, fn)
	else
		fn()
	end
end

function DeferencePool.flush(self)
	if self.is_deferring then
		self.is_deferring = false

		for _, fn in ipairs(self.queue) do
			fn()
		end

		self.queue = nil
	end
end

function DeferencePool.reset(self)
	self.queue = {}
	self.is_deferring = true
end

function DeferencePool.create()
	local pool = {
		call = DeferencePool.call,
		flush = DeferencePool.flush,
		reset = DeferencePool.reset,
	}

	pool:reset()

	return pool
end

