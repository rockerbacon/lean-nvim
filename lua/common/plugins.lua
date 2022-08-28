require 'common.files'
require 'common.deference_pool'

local fn = vim.fn

local plugins_path = fn.stdpath('data')..'/site/pack/packer/start'
local packer_install_path = plugins_path..'/packer.nvim'

local requires_packer_install = not check_path_exists(packer_install_path)

if requires_packer_install then
	print('Downloading packer...')
	fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		packer_install_path,
	})
	vim.cmd('packadd packer.nvim')
	print('Packer downloaded successfully!')
end

local packer = dofile(packer_install_path..'/lua/packer.lua')

local force_sync = false

post_plugin_initialization = DeferencePool.create()

function load_plugins(plugin_list)
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

function request_plugin_update_on_next_load()
	post_plugin_initialization:reset()
	force_sync = true
end

function colorscheme_installer(colorscheme_files_subpaths)
	return function (plugin_info)
		local colorschemes_dir = get_colorscheme_dir()

		make_directory(colorschemes_dir)

		for _, subpath in ipairs(colorscheme_files_subpaths) do
			copy_file_into_directory(
				plugin_info.install_path..'/'..subpath,
				colorschemes_dir
			)
		end
	end
end

function use_plugin(plugin_module, fn)
	post_plugin_initialization:call(function()
		fn(require(plugin_module))
	end)
end

function setup_plugin(plugin_module, kargs)
	post_plugin_initialization:call(function()
		require(plugin_module).setup(kargs)
	end)
end

