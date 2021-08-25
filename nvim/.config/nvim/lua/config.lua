local utils = require('utils')
local opt = utils.opt
local map = utils.map

vim.cmd('syntax on')

opt('termguicolors', true)

opt('mouse', 'a')
opt('clipboard', 'unnamedplus')
opt('autoread', true)

opt('hidden', true)
opt('number', true)
opt('relativenumber', true)
opt('cursorline', true)
opt('scrolloff', 5)
opt('cmdheight', 2)

opt('splitright', true)
opt('splitbelow', true)

opt('tabstop', 2)
opt('shiftwidth', 2)
opt('softtabstop', 2)
opt('scrolloff', 5)
opt('expandtab', true)
opt('smarttab', true)
opt('autoindent', true)
opt('smartindent', true)

opt('showmatch', true)
opt('hlsearch', true)
opt('incsearch', true)
opt('ignorecase', true)
opt('smartcase', true)

opt('timeoutlen', 300)
opt('updatetime', 300)

opt('completeopt', 'menuone,noselect,noinsert')
opt('shortmess', vim.o.shortmess .. 'c')
opt('signcolumn', 'yes')

opt('undofile', true)

opt('listchars', 'nbsp:¬,eol:¶,extends:»,precedes:«,trail:•')

map('n', '<leader>w', '<cmd>wa<cr>')
map('n', '<C-s>', '<cmd>up<cr>')
map('n', '<C-f>', '<Nop>')
map('n', '<C-b>', '<Nop>')

map('i', 'jj', '<esc>')
map('i', '<C-h>', '<left>')
map('i', '<C-j>', '<down>')
map('i', '<C-k>', '<up>')
map('i', '<C-l>', '<right>')
map({ 'n', 'v' }, 'H', '^')
map({ 'n', 'v' }, 'L', '$')
map('n', '<cr>', 'G')
map('n', '<bs>', 'gg')
map('n', 'U', '<C-r>')
map('n', 'Y', 'y$')
map('n', '<leader>hl', '<cmd>nohls<cr>')
map('n', '<leader>ij', 'o<esc>k')
map('n', '<leader>ik', 'O<esc>j')
map('x', '<', '<gv')
map('x', '>', '>gv')

require('config.bufferline')
--require('config.compe')
require('config.coq_nvim')
require('config.dashboard')
require('config.gitsigns')
require('config.indentline')
require('config.lsp')
require('config.lualine')
require('config.nvim_tree')
require('config.terminal')
require('config.telescope')
require('config.treesitter')
require('config.trouble')
require('config.vim_sneak')

require('keys')

require('colorizer').setup()
require('nvim-autopairs').setup()
