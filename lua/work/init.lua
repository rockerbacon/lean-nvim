local HotLoader = require('common.hot_loader')
local plugins = require('common.plugins')

local loader = HotLoader.single('work.init')

loader:before_reloading(
	'personal.plugins',
	plugins.update_on_next_load
)

loader:load('personal.options')
loader:load('personal.theme')
loader:load('personal.functions')
loader:load('personal.keymaps')
loader:load('personal.plugins')
loader:load('work.lsp')

