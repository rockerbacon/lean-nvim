--- @class SimpleDownloadAndExtractDependencies
--- @field extractor any
--- @field fs any
--- @field http any
--- @field path any

--- @class ArchitectureUrl
--- @field x86_64 string?
--- @field arm64 string?

--- @class CrossPlatformDownloadUrl
--- @field linux ArchitectureUrl?
--- @field macos ArchitectureUrl?
--- @field windows ArchitectureUrl?
--- @field freebsd ArchitectureUrl?

--- @class SimpleDownloadAndExtractInstaller
--- @field deps SimpleDownloadAndExtractDependencies
--- @field download_url CrossPlatformDownloadUrl
--- @field server_name string
local SimpleDownloadAndExtractInstaller = {}
SimpleDownloadAndExtractInstaller.__index = SimpleDownloadAndExtractInstaller

--- Get installation directory
--- @param self SimpleDownloadAndExtractInstaller
--- @return string Absolute path to the installation directory
function SimpleDownloadAndExtractInstaller.get_install_dir(self)
	return self.deps.path.lsp_servers..'/'..self.server_name
end

function SimpleDownloadAndExtractInstaller.__call(self)
	local extractor = self.deps.extractor
	local fs = self.deps.fs
	local http = self.deps.http

	if not fs.check_path_exists(self:get_install_dir()) then
		print('Installing '..self.server_name..' server...')

		-- TODO cross platform downloads
		local url = self.download_url.linux.x86_64

		if not url then
			error('Installation not supported on your platform')
		end

		print('Downloading binaries...')
		local tarball = http.download(self.download_url.linux.x86_64)

		local install_dir = self:get_install_dir()

		print('Extracting binaries...')
		fs.make_directory(install_dir)
		local extraction_success, extraction_error = pcall(extractor.extract, tarball, install_dir)

		print('Cleaning up downloaded file...')
		fs.remove_path(tarball)

		if not extraction_success then
			fs.remove_path(install_dir)
			error('Could not extract file: '..extraction_error)
		end

		print('Server installed successfully')
	end
end

--- Simple LSP server installer which downloads and extracts files to a standard directory
--- @param server_name string Name of the server. Must be unique
--- @param download_url CrossPlatformDownloadUrl URL options 
--- @param opt_deps SimpleDownloadAndExtractDependencies?
--- @returns SimpleDownloadAndExtractInstaller
function SimpleDownloadAndExtractInstaller.new(server_name, download_url, opt_deps)
	local deps = opt_deps or {}

	--- @require common.extractor
	deps.extractor = deps.extractor or require('common.extractor')

	--- @require common.filesystem
	deps.fs = deps.fs or require('common.filesystem')

	--- @require common.http
	deps.http = deps.http or require('common.http')

	--- @require common.path
	deps.path = deps.path or require('common.path')

	return setmetatable(
		{
			deps = deps,
			download_url = download_url,
			server_name = server_name,
		},
		SimpleDownloadAndExtractInstaller
	)
end

return SimpleDownloadAndExtractInstaller

