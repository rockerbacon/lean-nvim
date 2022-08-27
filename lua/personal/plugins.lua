require "common.packer"

load_plugins({
	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
	{
		'rockerbacon/vim-noctu',
		run = colorscheme_installer({ 'colors/noctu.vim' })
	}
})

