local fs = require('common.filesystem')
local path = require('common.path')
local DeferencePool = require('common.deference_pool')

local fn = vim.fn

local requires_packer_install = not fs.check_path_exists(path.packer_installation)

if requires_packer_install then
	print('Downloading packer...')
	fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		path.packer_installation,
	})
	vim.cmd('packadd packer.nvim')
	print('Packer downloaded successfully!')
end

local packer = dofile(path.packer_installation..'/lua/packer.lua')

local force_sync = false

local post_plugin_initialization = DeferencePool.new()

local function load(plugin_list)
	packer.init()

	packer.use('wbthomason/packer.nvim')

	for _, plugin in ipairs(plugin_list) do
		packer.use(plugin)
	end

	if requires_packer_install or force_sync then
		vim.cmd('autocmd User PackerComplete lua post_plugin_initialization:flush()')
		packer.sync()
		force_sync = false
	else
		post_plugin_initialization:flush()
	end
end

local function update_on_next_load()
	post_plugin_initialization:reset()
	force_sync = true
end

local function new_colorscheme_installer(colorscheme_files_subpaths)
	return function (plugin_info)
		fs.make_directory(path.colorschemes)

		for _, subpath in ipairs(colorscheme_files_subpaths) do
			fs.copy_file_into_directory(
				plugin_info.install_path..'/'..subpath,
				path.colorschemes
			)
		end
	end
end

local function use(plugin_module, fn)
	post_plugin_initialization:call(function()
		fn(require(plugin_module))
	end)
end

local function setup(plugin_module, kargs)
	post_plugin_initialization:call(function()
		require(plugin_module).setup(kargs)
	end)
end

local function post_initialization(fn)
	post_plugin_initialization:call(fn)
end

return {
	load = load,
	use = use,
	setup = setup,
	update_on_next_load = update_on_next_load,
	new_colorscheme_installer = new_colorscheme_installer,
	post_initialization = post_initialization,
}
