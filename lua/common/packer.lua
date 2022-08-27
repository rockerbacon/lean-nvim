require 'common.files'

local fn = vim.fn

local packer_plugins_path = fn.stdpath('data')..'/site/pack/packer/start'
local packer_install_path = packer_plugins_path..'/packer.nvim'

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

packer = dofile(packer_install_path..'/lua/packer.lua')

function check_is_plugin_installed(plugin)
	local plugin_full_name = nil
	if type(plugin) == 'table' then
		plugin_full_name = plugin[1]
	else
		plugin_full_name = plugin
	end

	local plugin_name = get_basename(plugin_full_name)
	local plugin_dir = packer_plugins_path..'/'..plugin_name

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

function load_plugins(plugin_list)
	local uninstalled_plugins = 0
	packer.init()

	uninstalled_plugins = uninstalled_plugins + register_plugin('wbthomason/packer.nvim')

	for _, plugin in ipairs(plugin_list) do
		uninstalled_plugins = uninstalled_plugins + register_plugin(plugin)
	end

	if requires_packer_install or uninstalled_plugins > 0 or plugin_list.force_sync then
		packer.sync()
	end
end

function colorscheme_installer(colorscheme_files_subpaths)
	return function (plugin_info)
		local colorschemes_dir = fn.stdpath('config')..'/colors'

		make_directory(colorschemes_dir)

		for _, subpath in ipairs(colorscheme_files_subpaths) do
			copy_file_into_directory(
				plugin_info.install_path..'/'..subpath,
				fn.stdpath('config')..'/colors'
			)
		end
	end
end
