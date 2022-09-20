require 'common.files'

local download_url = {
	linux = {
		x86 = 'https://github.com/sumneko/lua-language-server/releases/download/3.5.6/lua-language-server-3.5.6-linux-x64.tar.gz'
	}
}

local function get_install_dir()
	return get_lsp_server_dir()..'/sumneko_lua'
end

local function get_binary_path()
	return get_install_dir()..'/bin/lua-language-server'
end

function sumneko_lua_installer()
	local install_dir = get_install_dir()

	if not check_path_exists(install_dir) then
		print('Installing sumneko_lua server...')

		-- TODO cross platform downloads
		local url = download_url.linux.x86

		if not url then
			error('Installation not supported on your platform')
		end

		print('Downloading binaries...')
		local tarball = download(download_url.linux.x86)

		print('Extracting binaries...')
		make_directory(install_dir)
		local extraction_success = pcall(extract, tarball, install_dir)

		print('Cleaning up downloaded file...')
		remove_path(tarball)

		if not extraction_success then
			error('Could not extract file')
		end

		print('Server installed successfully')
	end
end

sumneko_lua_settings = {
	cmd = {
		get_binary_path()
	},
	settings = {
		Lua = {
			telemetry = { enable = false }
		}
	},
}

