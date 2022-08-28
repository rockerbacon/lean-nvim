require 'common.hot_reload'

set_reload_entrypoint 'personal.init'

hot_require 'personal.options'
hot_require 'personal.theme'
hot_require 'personal.keymaps'
hot_require 'personal.plugins'

before_reloading(
	'personal.plugins',
	request_plugin_update_on_next_load
)

