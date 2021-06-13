local utils = require('utils')
local opt = utils.opt
local map = utils.map
local g = vim.g

g.mapleader = ' '

opt('termguicolors', true)

opt('mouse', 'a')
opt('clipboard', 'unnamedplus')

opt('number', true)
opt('relativenumber', true)
opt('cursorline', true)
opt('scrolloff', 5)

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
opt('updatetime', 50)

opt('listchars', 'nbsp:¬,eol:¶,extends:»,precedes:«,trail:•')

map('i', 'jj', '<esc>')
map({'n','v'}, 'H', '^')
map({'n','v'}, 'L', '$')
map('n', '<cr>', 'G')
map('n', '<bs>', 'gg')
map('n', 'U', '<C-r>')
map('n', 'Y', 'y$')
map('x', '<', '<gv')
map('x', '>', '>gv')

require('config.compe')
require('config.galaxyline')
require('config.indentline')
require('config.lsp')
require('config.nvim_bufferline')
require('config.nvim_tree')
require('config.nvim_treesitter')
require('config.telescope')
require('config.vim_sneak')

require('colorizer').setup()
require('nvim-autopairs').setup()
require('lspkind').init()
