local map = require('utils').map
local g = vim.g

-- 2-character Sneak (default)
local opts = {noremap = false}
map('', 'z', '<Plug>Sneak_s', opts)
map('', 'Z', '<Plug>Sneak_S', opts)

-- 1-character enhanced 'f'
map('', '<leader>jf', '<Plug>Sneak_f', opts)
map('', '<leader>jF', '<Plug>Sneak_F', opts)

-- 1-character enhanced 't'
map('', '<leader>jt', '<Plug>Sneak_t', opts)
map('', '<leader>jT', '<Plug>Sneak_T', opts)

g['sneak#s_next'] = 1
g['sneak#label'] = 1
g['sneak#use_ic_scs'] = 1
