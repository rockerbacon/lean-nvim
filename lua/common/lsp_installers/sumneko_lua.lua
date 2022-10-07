local Installer = require('common.lsp_installers/simple_download_and_extract')

local installer = Installer.new(
	'sumneko_lua',
	{
		linux = {
			x86_64 = 'https://github.com/sumneko/lua-language-server/releases/download/3.5.6/lua-language-server-3.5.6-linux-x64.tar.gz'
		}
	}
)

local binary_path = installer:get_install_dir()..'/bin/lua-language-server'

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
	install = installer,
	settings = settings,
}

