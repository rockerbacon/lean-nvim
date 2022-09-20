function check_path_exists(pathname)
	local success = os.execute("stat '"..pathname.."' &> /dev/null")
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

function get_colorscheme_dir()
	return vim.fn.stdpath('config')..'/colors'
end

function get_lsp_server_dir()
	return vim.fn.stdpath('config')..'/lsp_servers'
end

function remove_path(pathname)
	local success = os.execute("rm -r '"..pathname.."' &> /dev/null")
	if not success then
		error('Could not remove "'..pathname..'"')
	end
end

function get_download_path()
	local download_directory = os.getenv('XDG_DOWNLOAD_DIR')

	if not download_directory then
		local home_path = os.getenv('HOME')

		if not home_path then
			error('Could not determine home directory')
		end
		
		download_directory = home_path..'/Downloads'
	end

	if not check_path_exists(download_directory) then
		error('Download directory does not exist')
	end

	return download_directory
end

function download(url)
	local filename = get_basename(url)
	local filepath = get_download_path()..'/'..filename

	local success = os.execute("curl -L -XGET '"..url.."' -o '"..filepath.."' &> /dev/null")
	if not success then
		error('Failure downloading file')
	end

	return filepath
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

local function extract_targz(tarball, destination_directory)
	local success = os.execute("tar -xz -f '"..tarball.."' --directory '"..destination_directory.."' &> /home/vitor.santos/extract.log")

	return success
end

local function get_extractor(filepath)
	local file_extension = get_file_extension(filepath)

	local extractor = ({
		['.tar.gz'] = extract_targz
	})[file_extension]

	if not extractor then
		error('No extractor for extension '..file_extension)
	end

	return extractor
end

function make_temp_dir()
	local tmp_dir_output = os.tmpname()
	local success = os.execute("mktemp -d '/tmp/leannvim_XXXXXX' 1> '"..tmp_dir_output.."' 2> /dev/null")

	local output_file = io.open(tmp_dir_output, 'r')
	local created_tmpdir = output_file:read()

	output_file:close()
	os.remove(tmp_dir_output)
	if not success then
		error('Could not create temporary directory')
	end

	return created_tmpdir
end

function extract(filepath, destination_directory)
	local extractor = get_extractor(filepath)

	local success = extractor(filepath, destination_directory)

	if not success then
		error('Could not extract file')
	end
end

