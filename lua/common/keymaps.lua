local set_keymap = vim.api.nvim_set_keymap
local del_keymap = vim.api.nvim_del_keymap

keymap_mode = {
	normal = 'n',
	insert = 'i',
	visual = 'v',
	visual_block = 'x',
	term = 't',
	command = 'c'
}

local function check_is_special_key(key)
	return key:sub(1, 1) == '<'
end

local function modify_key(modifier, key)
	if check_is_special_key(key) then
		local trimmed_key = key:sub(2)
		return '<'..modifier..'-'..trimmed_key
	else
		return '<'..modifier..'-'..key..'>'
	end
end

modifier_key = {
	ctrl = function(key)
		return modify_key('C', key)
	end,
	alt = function(key)
		return modify_key('M', key)
	end,
	shift = function(key)
		return modify_key('S', key)
	end
}

special_key = {
	escape = '<esc>',
	space = '<Space>',
	tab = '<Tab>',
}

local custom_keymaps = {
	[keymap_mode.normal] = {},
	[keymap_mode.insert] = {},
	[keymap_mode.visual] = {},
	[keymap_mode.visual_block] = {},
	[keymap_mode.term] = {},
	[keymap_mode.command] = {},
}

function lead_key(key)
	return '<Leader>'..key
end

function add_keymap(key, command, opt_modes, opt_kargs)
	local modes = opt_modes or {
		keymap_mode.normal,
	}
	local opts = opt_kargs or { noremap = true }

	local full_command = ':'..command..'<CR>'
	local full_key = lead_key(key)

	for _, mode in ipairs(modes) do
		if not custom_keymaps[mode][full_key] then
			custom_keymaps[mode][full_key] = command
		else
			error('Attempt to set duplicate keymap for "'..key..'"')
		end

		set_keymap(mode, full_key, full_command, opts)
	end
end

function clear_all_keymaps()
	for mode, keymaps in pairs(custom_keymaps) do
		for full_key in pairs(keymaps) do
			del_keymap(mode, full_key)
		end

		custom_keymaps[mode] = {}
	end
end

