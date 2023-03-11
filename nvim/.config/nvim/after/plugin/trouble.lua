require('trouble').setup({
  use_diagnostic_signs = true,
})

local wk = require('which-key')
local n_opts = {
  mode = 'n',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

wk.register({
  ['<leader>'] = {
    x = {
      name = '+trouble',
      x = { '<cmd>TroubleToggle<cr>', 'TroubleToggle' },
      w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace Diagnostics' },
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Document Diagnostics' },
      q = { '<cmd>TroubleToggle quickfix<cr>', 'Quickfix List' },
      l = { '<cmd>TroubleToggle loclist<cr>', 'Location List' },
    },
  },
  ['[q'] = {
    function()
      require('trouble').previous({ skip_groups = true, jump = true })
    end,
    'Previous trouble/quickfix item',
  },
  [']q'] = {
    function()
      require('trouble').next({ skip_groups = true, jump = true })
    end,
    'Next trouble/quickfix item',
  },
}, n_opts)
