local set_keymap = vim.api.nvim_set_keymap

local opt = {
	noremap = { noremap = true }
}

local mode = {
	normal = 'n',
	insert = 'i',
	visual = 'v',
	visual_block = 'x',
	term = 't',
	command = 'c'
}

set_keymap(mode.normal, "<C-l>", ":NERDTree<CR>", opt.noremap)

