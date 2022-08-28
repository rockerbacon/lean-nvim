local entrypoint_module = nil

local pre_change_handler = {}
local last_trigger = nil

function set_reload_entrypoint(module)
	entrypoint_module = module
	vim.cmd([[
		augroup hot_reload
			autocmd!
		augroup end
	]])
end

local function uncache_module(module)
	package.loaded[module] = nil
end

function hot_require(module)
	uncache_module(module)

	local module_name_pattern = module:match('[^%.]+$')..'.lua'

	local autocmd = 'augroup hot_reload\n\tautocmd BufWritePost '
		..module_name_pattern..' lua reload_entrypoint("'..module
	..'")\naugroup end'

	vim.cmd(autocmd)

	if module == last_trigger then
		local handle_change = pre_change_handler[module]
		if handle_change then
			handle_change()
		end
	end

	return require(module)
end

function before_reloading(trigger_module, exec)
	if not exec then
		error('Attempted to register empty hook')
	end

	pre_change_handler[trigger_module] = exec
end

function reload_entrypoint(changed_module)
	if not entrypoint_module then
		error('Attempted to hot reload without an entrypoint')
	end

	last_trigger = changed_module

	uncache_module(entrypoint_module)
	require(entrypoint_module)
end

