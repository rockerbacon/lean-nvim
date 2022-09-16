require 'common.theme'
require 'personal.options'

vim.opt.background = 'dark'
vim.opt.termguicolors = false
vim.opt.list = true
vim.opt.listchars = 'tab:¦ ,trail:·,eol:↵'

profile_opt.explorer_width = 34

profile_opt.telescope.layout_strategy = 'vertical'
profile_opt.telescope.preview = false
profile_opt.telescope.layout_config = {
	vertical = {
		anchor = 'SW',
		height = 0.34,
		width = 0.45
	}
}

profile_opt.cmp.formatting = {
	fields = { 'abbr' }
}

use_colorscheme('noctu')

