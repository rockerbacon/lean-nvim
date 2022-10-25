local Builder = require('common.lsp_installers.builder')
local download = require('common.lsp_installers.builder.download')
local extract = require('common.lsp_installers.builder.extract')
local mark_executable = require('common.lsp_installers.builder.mark_executable')

local check_dir_exists = require('common.lsp_installers.builder.check_dir_exists')

local path = require('common.path')
local http = require('common.http')

local server_name = 'rust_analyzer'

local url = 'https://github.com/rust-lang/rust-analyzer/releases/download/2022-10-03/rust-analyzer-x86_64-unknown-linux-gnu.gz'

local install_dir = path.lsp_servers..'/'..server_name
local binary_path = install_dir..'/rust-analyzer-x86_64-unknown-linux-gnu'

local installer = Builder.start(server_name)
	:check_install_requirement(check_dir_exists(install_dir))
	:exec(download({
		 linux = {
			 x86_64 = url
		}
	}))
	:exec(extract(http.get_download_destination(url), install_dir))
	:exec(mark_executable(binary_path))
:finish()


local settings = {
	cmd = {
		binary_path,
	},
}

return {
	install = installer,
	settings = settings,
}
