local lsp = require('common.lsp')

lsp.load_servers({
	'clangd',
	'gopls',
	'rust_analyzer',
	'lua_ls'
})

