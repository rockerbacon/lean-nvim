local LspInstallerAction = require('common.lsp_installers.builder.action')

--- @class ExtractActionDeps
--- @field extractor unknown
--- @field fs unknown

--- @class ExtractActionData
--- @field source_path string
--- @field destination_dir string
--- @field deps ExtractActionDeps

--- Extracts the file to a standard location
--- @param data ExtractActionData
local function exec_extraction(data)
	print('Extracting "'..data.source_path..'" to "'..data.destination_dir..'"')

	--- @module 'common.extractor'
	local extractor = data.deps.extractor
	--- @module 'common.filesystem'
	local fs = data.deps.fs

	if fs.check_path_exists(data.destination_dir) then
		error('Cannot extract to existing directory')
	end

	fs.make_directory(data.destination_dir)
	extractor.extract(data.source_path, data.destination_dir)

	print('Extraction finished')
end

local function clean_extraction(data)
	-- noop
end

--- Instantiates new extract action
--- @param source_path string Path to the compressed file
--- @param destination_dir string Path to the directory where to extract the file to
--- @param opt_deps ExtractActionDeps?
--- @return LspInstallerAction<ExtractActionData>
local function new_extract_action(source_path, destination_dir, opt_deps)
	local deps = opt_deps or {}

	return LspInstallerAction.new(
		exec_extraction,
		clean_extraction,
		{
			deps = {
				extractor = deps.extractor or require('common.extractor'),
				fs = deps.fs or require('common.filesystem'),
			},
			destination_dir = destination_dir,
			source_path = source_path,
		}
	) --[[@as LspInstallerAction<ExtractActionData>]]
end

return new_extract_action

