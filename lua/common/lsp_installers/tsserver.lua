local fs = require('common.filesystem')
local shell = require('common.shell')
local Builder = require('common.lsp_installers.builder')
local LspInstallerAction = require('common.lsp_installers.builder.action')

local check_command_unavailable = require('common.lsp_installers.builder.check_command_unavailable')

local server_name = 'tsserver'

local function check_is_npm_package_installed(package, install_paths)
	-- We don't use standard NPM functionality because it is painfully slow.
	-- This can detect package installation insanely faster
	for _, path in ipairs(install_paths) do
		if fs.check_path_exists(path..'/node_modules/'..package) then
			return true
		end
	end

	return false
end

local function get_npm_prefix(location)
	-- We don't use standard NPM functionality because it is painfully slow.
	-- This can get prefixes insanely faster

	if location == 'project' then
		return '.'
	elseif location == 'global' then
		local executable_location = shell.exec('command -v npm').stdout:sub(1, -2)
		return fs.get_dirname(executable_location, 2)
	else
		error('Invalid prefix location "'..location'"')
	end
end

local installer = Builder.start(server_name)
	:check_install_requirement(function()
		if not check_command_unavailable('npm') then
			error("NPM not available. Please install through NVM or your distribution's package manager")
		end

		local install_paths = {
			get_npm_prefix('project'),
			get_npm_prefix('global')..'/lib',
		}

		local has_typescript = check_is_npm_package_installed('typescript', install_paths)
		local has_language_server = check_is_npm_package_installed('typescript-language-server', install_paths)

		return not has_typescript or not has_language_server
	end)
	:exec(LspInstallerAction.new(
		function()
			print('Installing typescript and typescript-language-server NPM packages...')
			local installation = shell.exec('npm install --location=global typescript typescript-language-server')

			if installation.success then
				print('NPM package installation complete!')
			else
				error('Could not install npm packages "typescript" and "typescript-language-server"')
			end
		end,
		function() end,
		nil
	))
:finish()

return {
	install = installer,
	settings = nil,
}

