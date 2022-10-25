--- @class CommandAvailableCheckDeps
--- @field os unknown

--- @param command string
--- @param opt_deps CommandAvailableCheckDeps?
--- @return fun(): boolean
local function new_command_available_check(command, opt_deps)
	local deps = opt_deps or {}

	local op_sys = deps.os or os

	return function()
		local success = op_sys.execute("command -v '"..command.."' &> /dev/null")
		return not success
	end
end

return new_command_available_check
