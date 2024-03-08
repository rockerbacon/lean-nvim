local Modifier = require('common.keymaps.modifier')
local Leader = require('common.keymaps.leader')

local mode = {
	normal = 'n',
	insert = 'i',
	visual = 'v',
	visual_block = 'x',
	term = 't',
	command = 'c'
}

local modifier = {
	ctrl = Modifier.new('C'),
	alt = Modifier.new('M'),
	shift = Modifier.new('S')
}

local special = {
	escape = '<esc>',
	space = '<Space>',
	tab = '<Tab>',
}

local custom_keymaps = {
	[mode.normal] = {},
	[mode.insert] = {},
	[mode.visual] = {},
	[mode.visual_block] = {},
	[mode.term] = {},
	[mode.command] = {},
}

local leader = Leader.new()

local function set_keymap(modes, key, map, opts)
	for _, mode in ipairs(modes) do
		if not custom_keymaps[mode][key] then
			custom_keymaps[mode][key] = map
		else
			error('Attempt to set duplicate keymap for "'..key..'"')
		end

		vim.api.nvim_set_keymap(mode, key, map, opts)
	end
end

local function add(key, command, opt_modes, opt_kargs)
	local modes = opt_modes or {
		mode.normal,
	}
	local opts = opt_kargs or { noremap = true }

	local full_command = ':'..command..'<CR>'

	set_keymap(modes, key, full_command, opts)
end

local function alias(alias_key, ref_key, opt_modes, opt_kargs)
	local modes = opt_modes or {
		mode.normal,
	}
	local opts = opt_kargs or {}

	set_keymap(modes, alias_key, ref_key, opts)
end

local function clear_all()
	for keymap_mode, keymaps in pairs(custom_keymaps) do
		for key in pairs(keymaps) do
			vim.api.nvim_del_keymap(keymap_mode, key)
		end

		custom_keymaps[keymap_mode] = {}
	end
end

return {
	add = add,
	alias = alias,
	clear_all = clear_all,
	leader = leader,
	mode = mode,
	modifier = modifier,
	special = special,
}

