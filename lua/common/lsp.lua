local plugins = require('common.plugins')
local installers = require('common.lsp_installers')

local capabilities = {
	vim = vim.lsp.protocol.make_client_capabilities(),
	cmp = nil
}

plugins.use(
	'cmp_nvim_lsp',
	function (cmp)
		capabilities.cmp = cmp.update_capabilities(capabilities.vim)
	end
)

local function get_server_name(server_info)
	if type(server_info) == 'table' then
		return server_info[1]
	else
		return server_info
	end
end

local function check_should_install_server(server_info)
	if type(server_info) == 'table' then
		return server_info.install_server or true
	else
		return true
	end
end

local function get_server_settings(server_info)
	local installer = installers[get_server_name(server_info)]

	local default_settings = {
		capabilities = capabilities.cmp
	}

	if not installer.settings then
		return default_settings
	end

	return {
		capabilities = default_settings.capabilities,
		cmd = installer.settings.cmd,
		settings = installer.settings,
	}
end

local function install_server(server_info)
	local server_name = get_server_name(server_info)
	local installer = installers[server_name]

	if not installer then
		error('No installer for lsp server: '..server_name)
	end

	installer.install()
end

local function setup_server(server_info)
	plugins.use(
		'lspconfig',
		function(lspconfig)
			local server_name = get_server_name(server_info)
			local server = lspconfig[server_name]

			if not server then
				error('Unknown lsp server: '..server_name)
			end

			if check_should_install_server(server_info) then
				install_server(server_info)
			end

			server.setup(
				get_server_settings(server_info)
			)
		end
	)
end

local function load_servers(lsp_servers)
	for _, server in ipairs(lsp_servers) do
		setup_server(server)
	end
end

return {
	load_servers = load_servers,
}

