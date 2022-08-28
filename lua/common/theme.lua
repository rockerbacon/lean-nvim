require 'common.plugins'

function use_colorscheme(colorscheme)
	do_after_plugin_initialization(function()
		vim.cmd('colorscheme '..colorscheme)
	end)
end

