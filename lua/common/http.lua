local fs = require('common.filesystem')
local path = require('common.path')

--- Gets the path to a downloaded resource
--- @param url string HTTP URL for the resource
--- @return string Path where the downloaded resource resides
local function get_download_destination(url)
	return path.downloads..'/'..fs.get_basename(url)
end

--- Downloads a resource to a standard directory
--- Download location can be acquired using get_download_destination()
--- @param url string HTTP URL for the resource
--- @return string Path to the downloaded resource
local function download(url)
	local filepath = get_download_destination(url)

	local success = os.execute("curl -L -XGET '"..url.."' -o '"..filepath.."' &> /dev/null")
	if not success then
		error('Failure downloading file')
	end

	return filepath
end

return {
	download = download,
	get_download_destination = get_download_destination
}

