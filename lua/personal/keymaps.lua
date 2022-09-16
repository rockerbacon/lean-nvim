require 'common.keymaps'
require 'common.plugins'
require 'personal.options'

set_command_shortcut('<C-l>', profile_opt.explorer_width..'Lexplore')
set_command_shortcut('<C-p>', 'Telescope find_files')

use_plugin(
	'telescope.actions',
	function(actions)
		profile_opt.telescope.mappings = {
			i = {
				['<esc>'] = actions.close,
				['<C-j>'] = actions.move_selection_next,
				['<C-k>'] = actions.move_selection_previous,
				['<C-o>'] = actions.select_horizontal,
			}
		}
	end
)

profile_opt.comment = {
	mappings = {
		basic = true,
		extra = false,
		extended = false,
	},
	toggler = {
		line = '/cc',
		block = '/bc'
	},
	opleader = {
		line = '/c',
		block = '/b'
	}
}

use_plugin(
	'cmp',
	function(cmp)
		local selectionOptions = {
			behavior = cmp.SelectBehavior.Insert
		}

		local insertMode = { 'i' }

		profile_opt.cmp.mapping = {
			['<Tab>'] = cmp.mapping.select_next_item(
				selectionOptions,
				insertMode
			),
			['<S-Tab>'] = cmp.mapping.select_prev_item(
				selectionOptions,
				insertMode
			),
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), insertMode),
		}
	end
)

