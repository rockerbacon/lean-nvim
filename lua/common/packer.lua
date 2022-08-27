require "common.files"

local fn = vim.fn

local packer_plugins_path = fn.stdpath('data')..'/site/pack/packer/start'
local packer_module_path = packer_plugins_path..'/packer.nvim/lua/packer.lua'

local requires_packer_install = not check_is_file_readable(packer_module_path)

if requires_packer_install then
	print 'Downloading packer...'
	fn.system {
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		packer_path,
	}
	vim.cmd 'packadd packer.nvim'
	print 'Packer downloaded successfully!'
end

packer = dofile(packer_module_path)

function check_is_plugin_installed(plugin)
	local plugin_name = plugin:match('[^/]+$')
	local plugin_dir = packer_plugins_path..'/'..plugin_name

	return check_directory_exists(plugin_dir)
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

	if requires_packer_install or uninstalled_plugins > 0 then
		packer.sync()
	end
end

