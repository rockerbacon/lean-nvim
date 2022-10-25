local Builder = require('common.lsp_installers.builder')
local download = require('common.lsp_installers.builder.download')
local extract = require('common.lsp_installers.builder.extract')

local check_dir_exists = require('common.lsp_installers.builder.check_dir_exists')

local path = require('common.path')
local http = require('common.http')

local server_name = 'sumneko_lua'

local url = 'https://github.com/sumneko/lua-language-server/releases/download/3.5.6/lua-language-server-3.5.6-linux-x64.tar.gz'

local install_dir = path.lsp_servers..'/'..server_name
local binary_path = install_dir..'/bin/lua-language-server'

local installer = Builder.start(server_name)
	:check_install_requirement(check_dir_exists(install_dir))
	:exec(download({
		 linux = {
			 x86_64 = url
		}
	}))
	:exec(extract(http.get_download_destination(url), install_dir))
:finish()

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
