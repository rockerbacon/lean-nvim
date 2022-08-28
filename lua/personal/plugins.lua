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

use_plugin(
	'telescope.actions',
	function(actions)
		setup_plugin('telescope', {
			defaults = {
				layout_strategy = 'vertical',
				preview = false,
				scroll_strategy = 'limit',
				mappings = {
					i = {
						['<esc>'] = actions.close,
						['<C-j>'] = actions.move_selection_next,
						['<C-k>'] = actions.move_selection_previous,
						['<C-o>'] = actions.select_horizontal,
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
	end
)

setup_plugin('nvim-autopairs', {
	disable_in_macro = true
})

