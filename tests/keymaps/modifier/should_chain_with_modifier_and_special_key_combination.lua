local Modifier = require('common.keymaps.modifier')

local ctrl = Modifier.new('C')
local alt = Modifier.new('M')

local combination = ctrl+alt+'<Tab>'

assert(type(combination) == 'string', 'Incorrect combination type '..type(combination))
assert(combination == '<C-M-Tab>', 'Incorrect combination '..combination)

