local lsp = require('common.lsp')

lsp.load_servers({
	'clangd',
	'pylsp',
	'lua_ls',
	'tsserver'
})

