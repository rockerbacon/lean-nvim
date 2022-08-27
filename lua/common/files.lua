function check_is_file_readable(filepath)
	local file = io.open(filepath, 'r')

	if file == nil then
		return false
	else
		io.close(file)
		return true
	end
end

function check_directory_exists(dirpath)
	local success = os.execute("ls -d '"..dirpath.."' > /dev/null")

	if success then
		return true
	else
		return false
	end
end

