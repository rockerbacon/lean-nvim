local Modifier = require('common.keymaps.modifier')

local ctrl = Modifier.new('C')
local alt = Modifier.new('M')

local combination = ctrl+alt

assert(combination.key == 'C-M', 'Incorrect combination')

