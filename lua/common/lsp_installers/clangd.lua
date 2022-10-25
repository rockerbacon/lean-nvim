local Builder = require('common.lsp_installers.builder')
local LspInstallerAction = require('common.lsp_installers.builder.action')

local check_command_unavailable = require('common.lsp_installers.builder.check_command_unavailable')

local server_name = 'clangd'

local installer = Builder.start(server_name)
	:check_install_requirement(check_command_unavailable('clangd'))
	:exec(LspInstallerAction.new(
		function()
			error("clangd not available. Please install through your distribution's package manager")
		end,
		function() end,
		nil
	))
:finish()

return {
	install = installer,
	settings = nil,
}

