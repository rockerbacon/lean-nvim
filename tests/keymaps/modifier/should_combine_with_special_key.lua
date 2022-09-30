local Modifier = require('common.keymaps.modifier')

local ctrl = Modifier.new('C')

assert(ctrl+'<Tab>' == '<C-Tab>', 'Incorrect combination')

