local Leader = require('common.keymaps.leader')

local leader = Leader.new()

assert(leader+'a' == '<leader>a', 'Invalid combination')

