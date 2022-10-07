local lsp = require('common.lsp')

-- see the full list with the command :help lspconfig-all
lsp.load_servers({
	'rust_analyzer',
	'sumneko_lua'
})

