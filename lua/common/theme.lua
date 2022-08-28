require 'common.packer'

function use_colorscheme(colorscheme)
	exec_after_packer(function()
		vim.cmd('colorscheme '..colorscheme)
	end)
end

