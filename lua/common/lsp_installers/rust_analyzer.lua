local Installer = require('common.lsp_installers.simple_download_and_extract')

local installer = Installer.new(
	'rust_analyzer',
	{
		linux = {
			x86_64 = 'https://github.com/rust-lang/rust-analyzer/releases/download/2022-10-03/rust-analyzer-aarch64-unknown-linux-gnu.gz'
		}
	}
)

local binary_path = installer:get_install_dir()..'/rust-analyzer-aarch64-unknown-linux-gnu'

local settings = {
	cmd = {
		binary_path,
	},
}

return {
	install = installer,
	settings = settings,
}
