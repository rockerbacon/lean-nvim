require 'common.packer'

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

local telescope_actions = require('telescope.actions')
require('telescope').setup({
	defaults = {
		layout_strategy = 'vertical',
		preview = false,
		scroll_strategy = 'limit',
		mappings = {
			i = {
				['<esc>'] = telescope_actions.close,
				['<C-j>'] = telescope_actions.move_selection_next,
				['<C-k>'] = telescope_actions.move_selection_previous,
				['<C-o>'] = telescope_actions.select_horizontal,
			}
		},
		layout_config = {
			vertical = {
				anchor = 'SW',
				height = 0.34,
				width = 0.45
			}
		}
	},
})

require('nvim-autopairs').setup({
	disable_in_macro = true
})

