local Action = require('common.lsp_installers.builder.action')

--- @class DownloadActionDeps
--- @field http unknown
--- @field fs unknown

--- @class DownloadActionData
--- @field deps DownloadActionDeps
--- @field download_url string

--- @class ArchitectureUrl
--- @field x86_64 string?
--- @field arm64 string?

--- @class CrossPlatformDownloadUrl
--- @field linux ArchitectureUrl?
--- @field macos ArchitectureUrl?
--- @field windows ArchitectureUrl?
--- @field freebsd ArchitectureUrl?

--- Gets the correct url for the machine platform
--- This function is currently just a placeholder and will always return the URL for a Linux x86_64 machine
--- @param platform_urls CrossPlatformDownloadUrl
--- @return string
local function get_platform_url(platform_urls)
	local url = platform_urls.linux.x86_64

	if not url then
		error('No download URL available for your platform')
	end

	return url
end

--- Gets the location where the file will be downloaded to
--- @param data DownloadActionData
--- @return string
local function get_destination(data)
	--- @module 'common.http'
	local http = data.deps.http

	return http.get_download_destination(data.download_url)
end

--- Downloads a file
--- @param data DownloadActionData
local function exec_download(data)
	print('Downloading "'..data.download_url..'"')

	--- @module 'common.http'
	local http = data.deps.http

	http.download(data.download_url)

	print('Download finished')
end

--- Deletes a downloaded file
--- @param data DownloadActionData
local function clean_download(data)
	--- @module 'common.filesystem'
	local fs = data.deps.fs

	fs.remove_path(get_destination(data))
end

--- Instantiates a new download action
--- @param platform_urls CrossPlatformDownloadUrl
--- @param opt_deps DownloadActionDeps?
--- @return LspInstallerAction<DownloadActionData>
local function new_download_action(platform_urls, opt_deps)
	local deps = opt_deps or {}

	return Action.new(
		exec_download,
		clean_download,
		{
			deps = {
				http = deps.http or require('common.http'),
				fs = deps.fs or require('common.filesystem'),
			},
			download_url = get_platform_url(platform_urls)
		}
	) --[[@as LspInstallerAction<DownloadActionData>]]
end

return new_download_action

