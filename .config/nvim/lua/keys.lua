local utils = require('utils')
local map = utils.map
local wk = require('which-key')

wk.setup({})

map('n', 'gp', '%')

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map({ 'n', 'v' }, '<leader>/', ':CommentToggle<cr>')

map('t', 'jj', [[<C-\><C-n>]])
map('t', '<esc>', [[<C-\><C-n>]])
map('t', '<C-h>', [[<C-\><C-n><C-w>h]])
map('t', '<C-j>', [[<C-\><C-n><C-w>j]])
map('t', '<C-k>', [[<C-\><C-n><C-w>k]])
map('t', '<C-l>', [[<C-\><C-n><C-w>l]])

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
  w = {
    name = '+windows',
    d = { '<C-W>c', 'delete-window' },
    ['-'] = { '<C-W>s', 'split-window-below' },
    ['|'] = { '<C-W>v', 'split-window-right' },
    H = { '<C-W>5<', 'expand-window-left' },
    J = { ':resize +5', 'expand-window-below' },
    L = { '<C-W>5>', 'expand-window-right' },
    K = { ':resize -5', 'expand-window-up' },
  },
  f = {
    name = '+file',
  },
  h = {
    name = '+help',
    p = {
      name = '+packer',
      p = { '<cmd>PackerSync<cr>', 'Sync' },
      s = { '<cmd>PackerStatus<cr>', 'Status' },
      i = { '<cmd>PackerInstall<cr>', 'Install' },
      c = { '<cmd>PackerCompile<cr>', 'Compile' },
    },
  },
  g = {
    name = '+git',
    l = { [[<cmd>lua require('gitsigns').blame_line()<cr>]], 'Blame' },
    j = { [[<cmd>lua require('gitsigns').next_hunk()<cr>]], 'Next Hunk' },
    k = { [[<cmd>lua require('gitsigns').prev_hunk()<cr>]], 'Prev Hunk' },
    p = { [[<cmd>lua require('gitsigns').preview_hunk()<cr>]], 'Preview Hunk' },
    r = { [[<cmd>lua require('gitsigns').reset_hunk()<cr>]], 'Reset Hunk' },
    R = { [[<cmd>lua require('gitsigns').reset_buffer()<cr>]], 'Reset Buffer' },
    s = { [[<cmd>lua require('gitsigns').stage_hunk()<cr>]], 'Stage Hunk' },
    u = {
      [[<cmd>lua require('gitsigns').undo_stage_hunk()<cr>]],
      'Undo Stage Hunk',
    },
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
