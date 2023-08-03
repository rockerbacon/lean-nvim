local shell = require('common.shell')

local Builder = require('common.lsp_installers.builder')
local LspInstallerAction = require('common.lsp_installers.builder.action')


local check_command_unavailable = require('common.lsp_installers.builder.check_command_unavailable')

local server_name = 'gopls'

local function install_gopls()
	if check_command_unavailable('go')() then
		error("Go not available. Refer to https://go.dev for install instructions")
	end

	print('Installing gopls...')
	local installation = shell.exec('go install golang.org/x/tools/gopls@latest')

	if installation.success then
		print('gopls installation complete!')
	else
		error('Could not install gopls')
	end
end

local installer = Builder.start(server_name)
	:check_install_requirement(check_command_unavailable('gopls'))
	:exec(LspInstallerAction.new(
		install_gopls,
		function() end,
		nil
	))
:finish()

return {
	install = installer,
	settings = nil
}
