require 'common.plugins'

function use_colorscheme(colorscheme)
	post_plugin_initialization:call(function()
		vim.cmd('colorscheme '..colorscheme)
	end)
end

