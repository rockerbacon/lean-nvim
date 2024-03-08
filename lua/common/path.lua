local fs = require('common.filesystem')

local function get_colorscheme_dir()
	return vim.fn.stdpath('config')..'/colors'
end

local function get_download_path()
	local download_directory = os.getenv('XDG_DOWNLOAD_DIR')

	if not download_directory then
		local home_path = os.getenv('HOME')

		if not home_path then
			error('Could not determine home directory')
		end

		download_directory = home_path..'/Downloads'
	end

	if not fs.check_path_exists(download_directory) then
		error('Download directory does not exist')
	end

	return download_directory
end

local function get_lsp_server_dir()
	return vim.fn.stdpath('data')..'/lsp_servers'
end

local function get_plugins_dir()
	return vim.fn.stdpath('data')..'/site/pack/packer/start'
end

local function get_packer_install_dir()
	return get_plugins_dir()..'/packer.nvim'
end

return {
	colorschemes = get_colorscheme_dir(),
	downloads = get_download_path(),
	lsp_servers = get_lsp_server_dir(),
	plugins = get_plugins_dir(),
	packer_installation = get_packer_install_dir(),
}

