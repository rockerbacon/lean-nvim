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
		commit = 'nvim-0.6'
	},
	{
		'windwp/nvim-autopairs',
		commit = '34bd374f75fb58656572f847e2bc3565b0acb34f'
	},
})

setup_plugin('telescope', {
	defaults = profile_opt.telescope,
})

setup_plugin('nvim-autopairs', profile_opt.autopairs)

