local map = require('utils').map
local g = vim.g

-- 2-character Sneak (default)
local opts = {noremap = false}
map('', 'z', '<Plug>Sneak_s', opts)
map('', 'Z', '<Plug>Sneak_S', opts)

-- 1-character enhanced 'f'
map('', 'f', '<Plug>Sneak_f', opts)
map('', 'F', '<Plug>Sneak_F', opts)

-- 1-character enhanced 't'
map('', 't', '<Plug>Sneak_t', opts)
map('', 'T', '<Plug>Sneak_T', opts)

g['sneak#s_next'] = 1
g['sneak#label'] = 1
g['sneak#use_ic_scs'] = 1
