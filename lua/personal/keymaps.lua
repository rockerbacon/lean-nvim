require 'common.keymaps'
require 'common.plugins'
require 'personal.options'

set_command_shortcut('<C-l>', profile_opt.explorer_width..'Lexplore')
set_command_shortcut('<C-p>', 'Telescope find_files')

set_command_shortcut('<C-e>', 'lua vim.diagnostic.open_float(nil)')
set_command_shortcut('<C-d>', 'lua vim.lsp.buf.declaration()')
set_command_shortcut('<C-D>', 'lua vim.lsp.buf.definition()')
set_command_shortcut('<C-f>', 'lua vim.lsp.buf.code_action(nil)')
set_command_shortcut('<C-t>', 'lua vim.lsp.buf.hover()')

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
		line = '\\cc',
		block = '\\bc'
	},
	opleader = {
		line = '\\c',
		block = '\\b'
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

