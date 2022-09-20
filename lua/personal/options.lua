require 'common.plugins'

profile_opt = {}

vim.opt.autoindent = true
vim.opt.conceallevel = 0
vim.opt.concealcursor = ''
vim.opt.cursorline = true
vim.opt.encoding = 'utf-8'
vim.opt.expandtab = false
vim.opt.fileencoding = 'utf-8'
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 300

profile_opt.telescope = {
	scroll_strategy = 'limit'
}

profile_opt.cmp = {}
use_plugin(
	'luasnip',
	function(luasnip)
		profile_opt.cmp.snipet = {
			expand = function(args)
				luasnip.expand(args.body)
			end
		}

		profile_opt.cmp.sources = {
			{ name = 'buffer' },
			{ name = 'path' },
			{ name = 'luasnip' },
			{ name = 'nvim-lsp' }
		}
	end
)

