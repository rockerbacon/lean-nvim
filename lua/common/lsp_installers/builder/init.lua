--- @class LspInstallerBuilder
--- @field actions LspInstallerAction[]
--- @field check_requires_install ? fun(): boolean
--- @field name string
local LspInstallerBuilder = {}
LspInstallerBuilder.__index = LspInstallerBuilder

--- Instantiates new installer builder
--- @nodiscard
--- @param name string
--- @return LspInstallerBuilder
function LspInstallerBuilder.start(name)
	return setmetatable(
		{
			actions = {},
			check_requires_install = nil,
			name = name,
		},
		LspInstallerBuilder
	)
end

--- Check whether or not installation is required before executing any actions
--- @param self LspInstallerBuilder
--- @param check fun(): boolean
--- @return LspInstallerBuilder Returns itself
function LspInstallerBuilder.check_install_requirement(self, check)
	self.check_requires_install = check
	return self
end

--- Build the installer
--- @param self LspInstallerBuilder
--- @return fun(): nil Function which executes all installer actions
function LspInstallerBuilder.finish(self)
	return function()
		if not self.check_requires_install or self.check_requires_install() then
			print('Installing lsp server '..self.name..'...')
			local executed_actions_limit = 0
			local execution_error_message = nil

			for i, action in ipairs(self.actions) do
				local success, error_message = pcall(action.exec, action.data)

				if success then
					executed_actions_limit = i
				else
					execution_error_message = error_message
					break
				end
			end

			local clean_errors = {}
			for i = 1, executed_actions_limit do
				local action = self.actions[i]
				local success, error_msg = pcall(action.clean, action.data)

				if not success then
					table.insert(clean_errors, error_msg)
				end
			end

			-- TODO improve error handling
			if execution_error_message then
				error(execution_error_message)
			elseif #clean_errors > 0 then
				error(clean_errors)
			end

			print('Server installed successfully!')
		end
	end
end

--- Adds action to the installer
--- Actions are executed in the order in which they are defined
--- @param self LspInstallerBuilder
--- @param action LspInstallerAction
--- @return LspInstallerBuilder Returns itself
function LspInstallerBuilder.exec(self, action)
	table.insert(self.actions, action)
	return self
end

return LspInstallerBuilder

