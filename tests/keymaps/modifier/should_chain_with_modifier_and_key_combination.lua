local Modifier = require('common.keymaps.modifier')

local ctrl = Modifier.new('C')
local alt = Modifier.new('M')

local combination = ctrl+alt+'f'

assert(type(combination) == 'string', 'Incorrect combination type')
assert(combination == '<C-M-f>', 'Incorrect combination '..tostring(combination))

