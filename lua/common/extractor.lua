local fs = require('common.filesystem')

local function remove_extension(path, extension)
	return path:sub(1, -extension:len() - 1)
end

local function extract_targz(tarball, destination_directory)
	local success = os.execute("tar -xz -f '"..tarball.."' --directory '"..destination_directory.."' &> /dev/null")

	return success
end

local function extract_gz(file, destination_directory)
	local file_without_extension = remove_extension(
		fs.get_basename(file),
		'.gz'
	)

	local success = os.execute("gzip -cd '"..file.."' 2> /home/vitor.santos/extract.log 1> '"..destination_directory.."/"..file_without_extension.."'")

	return success
end

local function get_extractor(filepath)
	local file_extension = fs.get_file_extension(filepath)

	local extractor = ({
		['.tar.gz'] = extract_targz,
		['.gz'] = extract_gz,
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

