local fs = require('common.filesystem')
local path = require('common.path')
local PluginsManager = require('common.plugins.manager')

local requires_packer_install = not fs.check_path_exists(path.packer_installation)

if requires_packer_install then
	print('Downloading packer...')
	vim.fn.system({
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

local manager = PluginsManager.new()
if requires_packer_install then
	manager:update_on_next_load()
end

local function load(plugin_list)
	manager:load(plugin_list)
end

local function update_on_next_load()
	manager:update_on_next_load()
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
	manager:after_sync(function()
		fn(require(plugin_module))
	end)
end

local function setup(plugin_module, kargs)
	manager:after_sync(function()
		require(plugin_module).setup(kargs)
	end)
end

local function post_initialization(fn)
	manager:after_sync(fn)
end

local function run_post_initialization()
	manager:run_post_sync()
end

vim.cmd('autocmd User PackerComplete lua require("common.plugins").run_post_initialization()')

return {
	load = load,
	use = use,
	setup = setup,
	update_on_next_load = update_on_next_load,
	new_colorscheme_installer = new_colorscheme_installer,
	post_initialization = post_initialization,
	run_post_initialization = run_post_initialization,
}
