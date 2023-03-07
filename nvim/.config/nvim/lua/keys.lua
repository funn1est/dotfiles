local utils = require('utils')
local map = utils.map
local wk = require('which-key')

wk.setup({
  triggers_blacklist = {
    n = { 'c', 'y', 'v', 'd', '@', '"' },
  },
})

map('n', ',p', '"0p', { noremap = false })
map('n', ',P', '"0P', { noremap = false })

map('n', 'gp', '%')

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
-- map('n', 'J', 'mzJ`z')

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map({ 'n', 'v' }, '<leader>/', ':CommentToggle<cr>')

-- map('v', 'J', [[:m '>+1<CR>gv=gv]])
-- map('v', 'K', [[:m '<-2<CR>gv=gv]])

map('t', 'jj', [[<C-\><C-n>]])
map('t', '<esc>', [[<C-\><C-n>]])
map('t', '<C-h>', [[<C-\><C-n><C-w>h]])
map('t', '<C-j>', [[<C-\><C-n><C-w>j]])
map('t', '<C-k>', [[<C-\><C-n><C-w>k]])
map('t', '<C-l>', [[<C-\><C-n><C-w>l]])

map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

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
    name = 'Search',
    e = {
      function()
        require('neo-tree.command').execute({ toggle = true })
      end,
      'File Explorer',
    },
    f = {
      [[<cmd>lua require('telescope.builtin').find_files({ prompt_prefix = "🔍", find_command = { "rg", "--hidden", "--smart-case", "-g", "!{node_modules,.git}" ,"--files" } })<cr>]],
      'Find File',
    },
    h = { '<cmd>Telescope help_tags<cr>', 'Find Help' },
    m = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
    r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    R = { '<cmd>Telescope registers<cr>', 'Registers' },
    g = { '<cmd>Telescope live_grep<cr>', 'Text' },
    k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
    c = { '<cmd>Telescope commands<cr>', 'Commands' },
  },
  p = {
    name = 'Packer',
    c = { '<cmd>PackerCompile<cr>', 'Compile' },
    i = { '<cmd>PackerInstall<cr>', 'Install' },
    s = { '<cmd>PackerSync<cr>', 'Sync' },
    S = { '<cmd>PackerStatus<cr>', 'Status' },
    u = { '<cmd>PackerUpdate<cr>', 'Update' },
  },
  g = {
    name = 'Git',
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
    name = 'LSP',
    d = {
      '<cmd>Trouble document_diagnostics<cr>',
      'Document Diagnostics',
    },
    D = {
      '<cmd>Trouble workspace_diagnostics<cr>',
      'Workspace Diagnostics',
    },
    c = { [[<cmd>Telescope diagnostics bufnr=0<cr>]], 'Cursor Diagnostics' },
    r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
    f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
    h = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover Doc' },
    j = {
      '<cmd>lua vim.diagnostic.goto_next()<CR>',
      'Next Diagnostic',
    },
    k = {
      '<cmd>lua vim.diagnostic.goto_prev()<cr>',
      'Prev Diagnostic',
    },
    l = { [[<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>]], 'Line Diagnostics' },
    p = { [[<cmd>lua require("telescope.builtin").lsp_definitions()<cr>]], 'Preview Definition' },
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
    name = 'LSP',
    a = { [[<cmd>lua require('telescope.builtin').lsp_range_code_actions()<cr>]], 'Code Action' },
  },
}

wk.register(v_mappings, v_opts)
