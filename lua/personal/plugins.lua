local plugins = require('common.plugins')
require 'personal.options'

plugins.load({
	{
		'nvim-lua/plenary.nvim',
		tag = 'v0.1.4'
	},
	{
		'rockerbacon/vim-noctu',
		run = plugins.new_colorscheme_installer({ 'colors/noctu.vim' })
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = 'nvim-0.6'
	},
	{
		'numToStr/Comment.nvim',
		tag = 'v0.6'
	},
	{
		'L3MON4D3/LuaSnip',
		commit = 'a45cd5f4d9dea7c64b37fa69dea91e46bbbe9671'
	},
	{
		'hrsh7th/nvim-cmp',
		commit = '4efecf7f5b86949de387e63fa86715bc39f92219'
	},
	{
		'hrsh7th/cmp-buffer',
		commit = 'a0fe52489ff6e235d62407f8fa72aef80222040a'
	},
	{
		'hrsh7th/cmp-path',
		commit = '56a0fe5c46835ecc6323bda69f3924758b991590'
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		commit = '134117299ff9e34adde30a735cd8ca9cf8f3db81'
	},
	{
		'neovim/nvim-lspconfig',
		tag = 'v0.1.2'
	},
	{
		'steelsojka/pears.nvim',
		commit = '14e6c47c74768b74190a529e41911ae838c45254'
	},
	{
		'Darazaki/indent-o-matic',
		commit = '68f19ea15da7e944e7a5c848831837d2023b4ac2'
	}
})

plugins.setup('telescope', {
	defaults = profile_opt.telescope,
})

plugins.setup('cmp', profile_opt.cmp)

plugins.setup('Comment', profile_opt.comment)

plugins.setup('pears', nil)

plugins.setup('indent-o-matic', {})

