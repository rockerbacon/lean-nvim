--- @class LspInstallerAction<T>
--- @field clean fun(self: LspInstallerAction): nil
--- @field data `T`
--- @field exec fun(self: LspInstallerAction): nil
local LspInstallerAction = {}
LspInstallerAction.__index = LspInstallerAction

--- Instantiate new action 
--- @generic T
--- @param exec fun(data: `T`): nil
--- @param clean fun(data: `T`): nil
--- @param data `T`
function LspInstallerAction.new(exec, clean, data)
	return setmetatable(
		{
			clean = clean,
			data = data,
			exec = exec,
		},
		LspInstallerAction
	)
end

return LspInstallerAction

