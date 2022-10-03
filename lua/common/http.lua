local fs = require('common.filesystem')
local path = require('common.path')

local function download(url)
	local filename = fs.get_basename(url)
	local filepath = path.downloads..'/'..filename

	local success = os.execute("curl -L -XGET '"..url.."' -o '"..filepath.."' &> /dev/null")
	if not success then
		error('Failure downloading file')
	end

	return filepath
end

return {
	download = download,
}

