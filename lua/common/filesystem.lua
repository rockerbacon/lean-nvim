local function check_path_exists(pathname)
	local success = os.execute("stat '"..pathname.."' &> /dev/null")
	if success then
		return true
	else
		return false
	end
end

local function make_directory(dirpath)
	local success = os.execute("mkdir -p '"..dirpath.."' > /dev/null")
	if not success then
		error('Could not create directory')
	end
end

local function copy_file(source_path, destination_path, opt_block_size)
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

local function get_basename(pathname)
	return pathname:match('[^/]+$')
end

--- Gets the directory name of the path
--- @param pathname string
--- @param updir ? number How many directories to move up, default is 1
local function get_dirname(pathname, updir)
	updir = updir or 1

	local last_slash = pathname:len() - pathname:reverse():find('/')
	local dirname = pathname:sub(1, last_slash)

	if updir == 1 then
		return dirname
	else
		return get_dirname(dirname, updir - 1)
	end
end

local function copy_file_into_directory(source_path, directory_path)
	copy_file(
		source_path,
		directory_path..'/'..get_basename(source_path)
	)
end

--- Reads an entire file
--- @nodiscard
--- @param pathname string
--- @return string The file contents
local function read_file(pathname)
	local file, err_msg = io.open(pathname, 'r')

	if not file then
		error("Could not open '"..pathname.."': "..err_msg)
	end

	local contents = file:read('a')
	file:close()

	return contents
end

local function remove_path(pathname)
	local success = os.execute("rm -r '"..pathname.."' &> /dev/null")
	if not success then
		error('Could not remove "'..pathname..'"')
	end
end

local function get_file_extension(filepath)
	local subextensions = {}
	for match in get_basename(filepath):gmatch('%.%w+') do
		table.insert(subextensions, match)
	end

	if #subextensions == 0 then
		error('No extension on file')
	elseif #subextensions == 1 then
		return subextensions[1]
	end

	local extension = ''
	for i = #subextensions-1, #subextensions, 1 do
		extension = extension..subextensions[i]
	end

	return extension
end

local function make_temp_dir()
	local tmp_dir_output = os.tmpname()
	local success = os.execute("mktemp -d '/tmp/leannvim_XXXXXX' 1> '"..tmp_dir_output.."' 2> /dev/null")

	local output_file = io.open(tmp_dir_output, 'r')

	if not output_file then
		error('Could not open output file')
	end

	local created_tmpdir = output_file:read()

	output_file:close()
	os.remove(tmp_dir_output)
	if not success then
		error('Could not create temporary directory')
	end

	return created_tmpdir
end

local function mark_executable(pathname)
	local success = os.execute("chmod u+x '"..pathname.."' &> /dev/null")
	if not success then
		error('Could not mark "'..pathname..'" as executable')
	end
end

return {
	check_path_exists = check_path_exists,
	make_directory = make_directory,
	copy_file = copy_file,
	copy_file_into_directory = copy_file_into_directory,
	get_basename = get_basename,
	get_dirname = get_dirname,
	read_file = read_file,
	remove_path = remove_path,
	get_file_extension = get_file_extension,
	make_temp_dir = make_temp_dir,
	mark_executable = mark_executable,
}
