--- @class DirExistsCheckDeps
--- @field fs unknown

--- @param pathname string
--- @param opt_deps DirExistsCheckDeps?
--- @return fun(): boolean
local function new_dir_exists_check(pathname, opt_deps)
	local deps = opt_deps or {}

	--- @module 'common.filesystem'
	local fs = deps.fs or require('common.filesystem')

	return function()
		return not fs.check_path_exists(pathname)
	end
end

return new_dir_exists_check

