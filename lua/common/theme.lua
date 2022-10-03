local plugins = require('common.plugins')

local function use_colorscheme(colorscheme)
	plugins.post_initialization(function()
		vim.cmd('colorscheme '..colorscheme)
	end)
end

return {
	use_colorscheme = use_colorscheme
}

