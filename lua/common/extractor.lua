local fs = require('common.filesystem')

local function extract_targz(tarball, destination_directory)
	local success = os.execute("tar -xz -f '"..tarball.."' --directory '"..destination_directory.."' &> /home/vitor.santos/extract.log")

	return success
end

local function get_extractor(filepath)
	local file_extension = fs.get_file_extension(filepath)

	local extractor = ({
		['.tar.gz'] = extract_targz
	})[file_extension]

	if not extractor then
		error('No extractor for extension '..file_extension)
	end

	return extractor
end

local function extract(filepath, destination_directory)
	local extractor = get_extractor(filepath)

	local success = extractor(filepath, destination_directory)

	if not success then
		error('Could not extract file')
	end
end

return {
	extract = extract,
}

