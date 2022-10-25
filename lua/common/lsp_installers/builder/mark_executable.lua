local LspInstallerAction = require('common.lsp_installers.builder.action')

--- @class MarkExecutableActionDeps
--- @field fs unknown

--- @class MarkExecutableActionData
--- @field deps MarkExecutableActionDeps
--- @field path string

local function exec_mark_executable(data)
	--- @module 'common.filesystem'
	local fs = data.deps.fs

	fs.mark_executable(data.path)

	print('Marked "'..data.path..'"'..' as executable')
end

local function clean_mark_executable()
	-- noop
end

--- Instantiates new mark executable action
--- @return LspInstallerAction<MarkExecutableActionData>
local function new_mark_executable_action(path, opt_deps)
	local deps = opt_deps or {}

	return LspInstallerAction.new(
		exec_mark_executable,
		clean_mark_executable,
		{
			deps = {
				fs = deps.fs or require('common.filesystem')
			},
			path = path
		}
	) --[[@as LspInstallerAction<MarkExecutableActionData>]]
end

return new_mark_executable_action

