function check_path_exists(pathname)
	local success = os.execute("stat '"..pathname.."' > /dev/null")
	if success then
		return true
	else
		return false
	end
end

function make_directory(dirpath)
	local success = os.execute("mkdir -p '"..dirpath.."' > /dev/null")
	if not success then
		error('Could not create directory')
	end
end

function copy_file(source_path, destination_path, opt_block_size)
	local source_file = io.open(source_path, 'rb')
	if not source_file then
		error('Failed to open source file')
	end

	local destination_file = io.open(destination_path, 'wb')
	if not destination_file then
		source_file:close()
		error('Failed to open destination file')
	end


	local block_size = opt_block_size or 4096

	local buffer = source_file:read(block_size)
	while buffer do
		destination_file:write(buffer)
		buffer = source_file:read(block_size)
	end

	source_file:close()
	destination_file:close()
end

function get_basename(pathname)
	return pathname:match('[^/]+$')
end

function copy_file_into_directory(source_path, directory_path)
	copy_file(
		source_path,
		directory_path..'/'..get_basename(source_path)
	)
end

