local Modifier = require('common.keymaps.modifier')

local ctrl = Modifier.new('C')

assert(ctrl+'j' == '<C-j>', 'Incorrect combination')

