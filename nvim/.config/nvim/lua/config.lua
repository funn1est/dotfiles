local utils = require('utils')
local opt = utils.opt

vim.cmd('syntax on')

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.clipboard:append('unnamedplus')
vim.opt.shortmess:append('c')

opt('termguicolors', true)
opt('mouse', 'a')
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
opt('updatetime', 50)

opt('signcolumn', 'yes')

opt('undofile', true)

opt('listchars', 'nbsp:¬,eol:¶,extends:»,precedes:«,trail:•')

require('keys')

require('colorizer').setup()
