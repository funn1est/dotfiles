local utils = require('utils')
local map = utils.map
local wk = require('which-key')

wk.setup({})

map({ 'n', 'v' }, '<leader>/', ':CommentToggle<cr>')

local n_opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local n_mappings = {
  ['/'] = 'Comment',
  f = {
    name = '+file',
  },
  g = {
    name = 'Git',
    f = { '<cmd>Telescope git_files<cr>', 'Git files' },
    o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
    C = {
      '<cmd>Telescope git_bcommits<cr>',
      'Checkout commit(for current file)',
    },
  },
  l = {
    name = '+LSP',
    a = { '<cmd>Lspsaga code_action<cr>', 'Code Action' },
    A = { '<cmd>Lspsaga range_code_action<cr>', 'Selected Action' },
    d = {
      '<cmd>Trouble lsp_document_diagnostics<cr>',
      'Document Diagnostics',
    },
    D = {
      '<cmd>Trouble lsp_workspace_diagnostics<cr>',
      'Workspace Diagnostics',
    },
    r = { '<cmd>Lspsaga rename<cr>', 'Rename' },
    f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
    h = { '<cmd>Lspsaga hover_doc<cr>', 'Hover Doc' },
    j = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Prev Diagnostic' },
    k = { '<cmd>Lspsaga diagnostic_jump_next<cr>', 'Next Diagnostic' },
    l = { '<cmd>Lspsaga lsp_finder<cr>', 'LSP Finder' },
    L = { '<cmd>Lspsaga show_line_diagnostics<cr>', 'Line Diagnostics' },
    p = { '<cmd>Lspsaga preview_definition<cr>', 'Preview Definition' },
    q = { '<cmd>TroubleToggle quickfix<cr>', 'Quickfix' },
    t = { '<cmd>TroubleToggle<cr>', 'Trouble Toggle' },
    i = { '<cmd>TroubleToggle lsp_references<cr>', 'references' },
  },
}

wk.register(n_mappings, n_opts)

local v_opts = {
  mode = 'v',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local v_mappings = {
  l = {
    name = '+LSP',
    a = { ':<C-U>Lspsaga range_code_action<cr>', 'Code Action' },
  },
}

wk.register(v_mappings, v_opts)
