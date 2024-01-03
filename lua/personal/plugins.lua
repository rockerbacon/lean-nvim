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
		tag = 'v0.1.5'
	},
	{
		'numToStr/Comment.nvim',
		tag = 'v0.8.0'
	},
	{
		'L3MON4D3/LuaSnip',
		tag = '2.2.0'
	},
	{
		'hrsh7th/nvim-cmp',
		commit = '538e37ba87284942c1d76ed38dd497e54e65b891'
	},
	{
		'hrsh7th/cmp-buffer',
		commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa'
	},
	{
		'hrsh7th/cmp-path',
		commit = '91ff86cd9c29299a64f968ebb45846c485725f23'
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		commit = '5af77f54de1b16c34b23cba810150689a3a90312'
	},
	{
		'neovim/nvim-lspconfig',
		tag = 'v0.1.7'
	},
	{
		'steelsojka/pears.nvim',
		commit = '14e6c47c74768b74190a529e41911ae838c45254'
	},
	{
		'Darazaki/indent-o-matic',
		commit = '4d11e98f523d3c4500b1dc33f0d1a248a4f69719'
	}
})

plugins.setup('telescope', {
	defaults = profile_opt.telescope,
})

plugins.setup('cmp', profile_opt.cmp)

plugins.setup('Comment', profile_opt.comment)

plugins.setup('pears', nil)

plugins.setup('indent-o-matic', {})

