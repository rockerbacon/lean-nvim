local fs = require('common.filesystem')

--- @class ExecutionResult
--- @field success boolean
--- @field stdout string
--- @field stderr string

--- Executes a shell command
--- @param command string
--- @return ExecutionResult
local function exec(command)
	local tmp_dir = fs.make_temp_dir()
	local stdout_file = tmp_dir..'/stdout.log'
	local stderr_file = tmp_dir..'/stderr.log'

	local success = os.execute(command.." 1>'"..stdout_file.."' 2>'"..stderr_file.."'")

	local result = {
		success = success,
		stdout = fs.read_file(stdout_file),
		stderr = fs.read_file(stderr_file),
	}

	fs.remove_path(tmp_dir)

	return result
end

return {
	exec = exec,
}

