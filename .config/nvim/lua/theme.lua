local base16 = require('base16')
base16(base16.themes['onedark'], true)

vim.api.nvim_command('hi illuminatedWord cterm=underline gui=underline')
--vim.api.nvim_command('hi link illuminatedCurWord Search')
