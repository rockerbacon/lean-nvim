local DeferencePool = require('common.deference_pool')
local path = require('common.path')

--- @class Vim
--- @field cmd fun(string): nil

--- @class Packer
--- @field use fun(unknown): nil
--- @field init fun(): nil
--- @field sync fun(): nil

--- @class PluginsManager
--- @field force_sync boolean
--- @field packer Packer
--- @field post_sync DeferencePool
--- @field vim Vim
local PluginsManager = {}
PluginsManager.__index = PluginsManager

--- Creates a new PluginsManager instance
--- @param opt_kargs { packer: Packer?, vim: Vim? }?
--- @return PluginsManager
function PluginsManager.new(opt_kargs)
	local kargs = opt_kargs or {}

	return setmetatable(
		{
			force_sync = false,
			packer = kargs.packer or dofile(path.packer_installation..'/lua/packer.lua'),
			post_sync = DeferencePool.new(),
			vim = kargs.vim or vim,
		},
		PluginsManager
	)
end

--- Loads plugins from a list
--- @param self PluginsManager
--- @param plugin_list unknown[] List of plugins in packer format
function PluginsManager.load(self, plugin_list)
	self.packer.init()

	self.packer.use('wbthomason/packer.nvim')

	for _, plugin in ipairs(plugin_list) do
		self.packer.use(plugin)
	end

	if self.force_sync then
		self.packer.sync()
		self.force_sync = false
	else
		self.post_sync:flush()
	end
end

function PluginsManager.update_on_next_load(self)
	self.post_sync:reset()
	self.force_sync = true
end

function PluginsManager.after_sync(self, exec)
	self.post_sync:call(exec)
end

function PluginsManager.run_post_sync(self)
	self.post_sync:flush()
end

return PluginsManager

