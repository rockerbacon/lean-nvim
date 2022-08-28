require 'common.files'

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

function check_is_plugin_installed(plugin)
	local plugin_full_name = nil
	if type(plugin) == 'table' then
		plugin_full_name = plugin[1]
	else
		plugin_full_name = plugin
	end

	local plugin_name = get_basename(plugin_full_name)
	local plugin_dir = plugins_path..'/'..plugin_name

	return check_path_exists(plugin_dir)
end

function register_plugin(plugin)
	packer.use(plugin)

	if (check_is_plugin_installed(plugin)) then
		return 0
	else
		return 1
	end
end

local is_packer_finished = false
local deferred_functions = {}
function exec_post_plugin_management_routines()
	is_packer_finished = true

	for _, fn in ipairs(deferred_functions) do
		fn()
	end

	deferred_functions = nil
end

function do_after_plugin_initialization(fn)
	if is_packer_finished then
		fn()
	else
		table.insert(deferred_functions, fn)
	end
end

function load_plugins(plugin_list)
	local uninstalled_plugins = 0
	packer.init()

	uninstalled_plugins = uninstalled_plugins + register_plugin('wbthomason/packer.nvim')

	for _, plugin in ipairs(plugin_list) do
		uninstalled_plugins = uninstalled_plugins + register_plugin(plugin)
	end

	if requires_packer_install or uninstalled_plugins > 0 or plugin_list.force_sync then
		vim.cmd('autocmd User PackerComplete lua exec_post_plugin_management_routines()')
		packer.sync()
	else
		exec_post_plugin_management_routines()
	end
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
	do_after_plugin_initialization(function()
		fn(require(plugin_module))
	end)
end

function setup_plugin(plugin_module, kargs)
	do_after_plugin_initialization(function()
		require(plugin_module).setup(kargs)
	end)
end

