require 'common.keymaps'
require 'common.plugins'
require 'personal.options'

clear_all_keymaps()

vim.g.mapleader = ','

add_keymap('l', 'lua leanvim.browse_files({ display = "split" })')
add_keymap('p', 'lua leanvim.browse_files({ display = "popup" })')

add_keymap('e', 'lua vim.diagnostic.open_float(nil)')
add_keymap('gd', 'lua vim.lsp.buf.declaration()')
add_keymap('d', 'lua vim.lsp.buf.definition()')
add_keymap('f', 'lua vim.lsp.buf.code_action(nil)')
add_keymap('t', 'lua vim.lsp.buf.hover()')

use_plugin(
	'telescope.actions',
	function(actions)
		profile_opt.telescope.mappings = {
			i = {
				[special_key.escape] = actions.close,
				[modifier_key.ctrl('j')] = actions.move_selection_next,
				[modifier_key.ctrl('k')] = actions.move_selection_previous,
				[modifier_key.ctrl('o')] = actions.select_horizontal,
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
		line = lead_key('cc'),
		block = lead_key('bc')
	},
	opleader = {
		line = lead_key('c'),
		block = lead_key('b')
	}
}

use_plugin(
	'cmp',
	function(cmp)
		local selectionOptions = {
			behavior = cmp.SelectBehavior.Insert
		}

		local insertMode = { keymap_mode.insert }

		profile_opt.cmp.mapping = {
			[special_key.tab] = cmp.mapping.select_next_item(
				selectionOptions,
				insertMode
			),
			[modifier_key.shift(special_key.tab)] = cmp.mapping.select_prev_item(
				selectionOptions,
				insertMode
			),
			[modifier_key.ctrl(special_key.space)] = cmp.mapping(cmp.mapping.complete(), insertMode),
		}
	end
)

