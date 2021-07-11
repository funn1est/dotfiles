local utils = require('utils')
local map = utils.map

local saga = require('lspsaga')
saga.init_lsp_saga()

map('n', 'K', '<cmd>Lspsaga hover_doc<cr>')
