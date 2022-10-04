local HotLoader = require('common.hot_loader')
local plugins = require('common.plugins')

local loader = HotLoader.single('personal.init')

loader:load('personal.options')
loader:load('personal.theme')
loader:load('personal.functions')
loader:load('personal.keymaps')
loader:load('personal.plugins')
loader:load('personal.lsp')

loader:before_reloading(
	'personal.plugins',
	plugins.update_on_next_load
)

