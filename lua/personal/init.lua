require 'common.hot_reload'
local plugins = require('common.plugins')

set_reload_entrypoint 'personal.init'

hot_require 'personal.options'
hot_require 'personal.theme'
hot_require 'personal.functions'
hot_require 'personal.keymaps'
hot_require 'personal.plugins'
hot_require 'personal.lsp'

before_reloading(
	'personal.plugins',
	plugins.update_on_next_load
)

