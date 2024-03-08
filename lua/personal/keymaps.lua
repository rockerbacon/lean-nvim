local keymaps = require('common.keymaps')
local plugins = require('common.plugins')
require 'personal.options'

local esc = keymaps.special.escape
local tab = keymaps.special.tab
local space = keymaps.special.space

local alt = keymaps.modifier.alt
local ctrl = keymaps.modifier.ctrl
local shift = keymaps.modifier.shift

local leader = keymaps.leader

keymaps.clear_all()

vim.g.mapleader = ','

keymaps.alias(ctrl+'h', ctrl+'w'..'h')
keymaps.alias(ctrl+'l', ctrl+'w'..'l')
keymaps.alias(ctrl+'k', ctrl+'w'..'k')
keymaps.alias(ctrl+'j', ctrl+'w'..'j')
keymaps.alias(ctrl+alt+'h', ctrl+'w'..'H')
keymaps.alias(ctrl+alt+'l', ctrl+'w'..'L')
keymaps.alias(ctrl+alt+'k', ctrl+'w'..'K')
keymaps.alias(ctrl+alt+'j', ctrl+'w'..'J')

keymaps.add(leader+'l', 'lua leanvim.browse_files({ display = "split" })')
keymaps.add(leader+'p', 'lua leanvim.browse_files({ display = "popup" })')

keymaps.add(leader+'e', 'lua vim.diagnostic.open_float(nil)')
keymaps.add(leader+'gd', 'lua vim.lsp.buf.declaration()')
keymaps.add(leader+'d', 'lua vim.lsp.buf.definition()')
keymaps.add(leader+'f', 'lua vim.lsp.buf.code_action(nil)')
keymaps.add(leader+'t', 'lua vim.lsp.buf.hover()')

plugins.use(
	'telescope.actions',
	function(actions)
		profile_opt.telescope.mappings = {
			i = {
				[esc] = actions.close,
				[ctrl+'j'] = actions.move_selection_next,
				[ctrl+'k'] = actions.move_selection_previous,
				[ctrl+'o'] = actions.select_horizontal,
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
		line = leader+'cc',
		block = leader+'bc',
	},
	opleader = {
		line = leader+'c',
		block = leader+'b'
	}
}

plugins.use(
	'cmp',
	function(cmp)
		local selectionOptions = {
			behavior = cmp.SelectBehavior.Insert
		}

		local insertMode = { keymaps.mode.insert }

		profile_opt.cmp.mapping = {
			[tab] = cmp.mapping.select_next_item(
				selectionOptions,
				insertMode
			),
			[shift+tab] = cmp.mapping.select_prev_item(
				selectionOptions,
				insertMode
			),
			[ctrl+space] = cmp.mapping(cmp.mapping.complete(), insertMode),
		}
	end
)

