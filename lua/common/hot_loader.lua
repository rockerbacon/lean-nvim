--- @class HotLoader
--- @field variable_name string
--- @field entrypoint string
--- @field pre_change_handler table<string, fun(): nil>
--- @field last_trigger string?
local HotLoader = {}
HotLoader.__index = HotLoader

local function uncache_module(module)
	package.loaded[module] = nil
end

local function get_augroup_id(entrypoint)
	return 'hot_reload_'..entrypoint
end

--- Get the vim augroup for this loader
--- @param self HotLoader
--- @return string
function HotLoader.get_augroup(self)
	return get_augroup_id(self.entrypoint)
end

--- Creates a new HotLoader instance
--- @param variable_name string Name of the variable referencing the loader instance
--- @param entrypoint string Path to the module where the loader is instantiated, the same as in a standard require call
function HotLoader.new(variable_name, entrypoint)
	local instance = setmetatable(
		{
			entrypoint = entrypoint,
			pre_change_handler = {},
			last_trigger = nil,
			variable_name = variable_name,
		},
		HotLoader
	)

	vim.cmd([[
		augroup hot_reload_]]..get_augroup_id(instance.entrypoint)..[[
			autocmd!
		augroup end
	]])

	return instance
end

--- Loads a module, reloading it whenever it is changed
--- Reload can only work when the module file is edited using Neovim
--- @param self HotLoader
--- @param module string Module path, the same as in a standard require call
function HotLoader.load(self, module)
	uncache_module(module)

	local module_name_pattern = module:match('[^%.]+$')..'.lua'

	local autocmd = 'augroup '..self:get_augroup()..'\n\tautocmd BufWritePost '
		..module_name_pattern..' lua '..self.variable_name..':reload("'..module
	..'")\naugroup end'

	vim.cmd(autocmd)

	if module == self.last_trigger then
		local handle_change = self.pre_change_handler[module]
		if handle_change then
			handle_change()
		end
	end

	return require(module)
end

--- Sets a handler which will execute right before reloading a specific module
--- @param self HotLoader
--- @param trigger_module string Path to the module to watch, the same as in a standard require call
--- @param exec fun(): nil Handler to execute
function HotLoader.before_reloading(self, trigger_module, exec)
	if not exec then
		error('Attempted to register empty hook')
	end

	self.pre_change_handler[trigger_module] = exec
end

--- Start a reload from the entrypoint
--- @param self HotLoader
--- @param changed_module string? The module which triggered the reloading
function HotLoader.reload(self, changed_module)
	self.last_trigger = changed_module

	uncache_module(self.entrypoint)
	require(self.entrypoint)
end

local singleton = {}

function HotLoader.single(entrypoint)
	if not singleton[entrypoint] then
		singleton[entrypoint] = HotLoader.new(
			'require("common.hot_loader").single("'..entrypoint..'")',
			entrypoint
		)
	end

	return singleton[entrypoint]
end

return HotLoader

