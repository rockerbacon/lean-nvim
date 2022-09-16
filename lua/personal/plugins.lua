require 'common.plugins'
require 'personal.options'

load_plugins({
	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
	{
		'rockerbacon/vim-noctu',
		run = colorscheme_installer({ 'colors/noctu.vim' })
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
	}
})

setup_plugin('telescope', {
	defaults = profile_opt.telescope,
})

setup_plugin('cmp', profile_opt.cmp)

setup_plugin('Comment', profile_opt.comment)

