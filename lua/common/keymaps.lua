local set_keymap = vim.api.nvim_set_keymap

local keymap_mode = {
	normal = 'n',
	insert = 'i',
	visual = 'v',
	visual_block = 'x',
	term = 't',
	command = 'c'
}

function set_command_shortcut(key, command, opt_modes, opt_kargs)
	local modes = opt_modes or {
		keymap_mode.normal,
		keymap_mode.insert,
		keymap_mode.visual,
		keymap_mode.visual_block
	}
	local opts = opt_kargs or { noremap = true }

	local full_command = ':'..command..'<CR>'

	for _, mode in ipairs(modes) do
		set_keymap(mode, key, full_command, opts)
	end
end

