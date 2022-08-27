require "common.packer"

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
	}
})

telescope_actions = require('telescope.actions')
require('telescope').setup({
	defaults = {
		layout_strategy = 'bottom_pane',
		preview = false,
		scroll_strategy = 'limit',
		mappings = {
			i = {
				['<esc>'] = telescope_actions.close,
				['<C-j>'] = telescope_actions.move_selection_next,
				['<C-k>'] = telescope_actions.move_selection_previous,
				['<C-o>'] = telescope_actions.select_horizontal,
			}
		}
	}
})

