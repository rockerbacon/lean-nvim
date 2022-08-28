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

