local HotLoader = require('common.hot_loader')
local plugins = require('common.plugins')

local loader = HotLoader.single('work.init')

loader:before_reloading(
	'work.plugins',
	plugins.update_on_next_load
)

loader:load('work.options')
loader:load('work.theme')
loader:load('work.functions')
loader:load('work.keymaps')
loader:load('work.plugins')
loader:load('work.lsp')

