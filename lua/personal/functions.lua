local plugins = require('common.plugins')

local telescope_builtin = nil
plugins.use(
	'telescope.builtin',
	function(builtin)
		telescope_builtin = builtin
	end
)

local function browse_files(kargs)
	local opts = kargs or {}
	local mode = opts.display or 'split'

	if mode == 'split' then
		vim.cmd(profile_opt.explorer_width..'Lexplore')
	elseif mode == 'popup' then
		telescope_builtin.find_files()
	else
		error('Invalid display mode')
	end
end

leanvim = {
	browse_files = browse_files
}

