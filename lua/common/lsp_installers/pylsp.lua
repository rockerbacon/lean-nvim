local Builder = require('common.lsp_installers.builder')
local LspInstallerAction = require('common.lsp_installers.builder.action')

local check_command_unavailable = require('common.lsp_installers.builder.check_command_unavailable')

local server_name = 'pylsp'

local installer = Builder.start(server_name)
	:check_install_requirement(check_command_unavailable('pylsp'))
	:exec(LspInstallerAction.new(
		function()
			error("pylsp not available, please install through your distribution's package manager")
		end,
		function() end,
		nil
	))
:finish()

return {
	install = installer,
	settings = {
		pylsp = {
			plugins = {
				autopep8 = {
					enabled = false
				},
				flake8 = {
					enabled = false
				},
				mccabe = {
					enabled = false
				},
				pycodestyle = {
					enabled = false
				},
				pydocstyle = {
					enabled = true,
					convention = 'google'
				},
				pylint = {
					enabled = false
				},
				yapf = {
					enabled = false
				}
			}
		}
	},
}

