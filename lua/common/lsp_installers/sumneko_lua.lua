local fs = require('common.filesystem')
local extractor = require('common.extractor')
local http = require('common.http')
local path = require('common.path')

local download_url = {
	linux = {
		x86 = 'https://github.com/sumneko/lua-language-server/releases/download/3.5.6/lua-language-server-3.5.6-linux-x64.tar.gz'
	}
}

local install_dir = path.lsp_servers..'/sumneko_lua'

local binary_path = install_dir..'/bin/lua-language-server'

local function install()
	if not fs.check_path_exists(install_dir) then
		print('Installing sumneko_lua server...')

		-- TODO cross platform downloads
		local url = download_url.linux.x86

		if not url then
			error('Installation not supported on your platform')
		end

		print('Downloading binaries...')
		local tarball = http.download(download_url.linux.x86)

		print('Extracting binaries...')
		fs.make_directory(install_dir)
		local extraction_success = pcall(extractor.extract, tarball, install_dir)

		print('Cleaning up downloaded file...')
		fs.remove_path(tarball)

		if not extraction_success then
			error('Could not extract file')
		end

		print('Server installed successfully')
	end
end

local settings = {
	cmd = {
		binary_path,
	},
	settings = {
		Lua = {
			telemetry = { enable = false },
			completion = {
				enable = true,
				autoRequire = false
			}
		}
	},
}

return {
	install = install,
	settings = settings,
}

