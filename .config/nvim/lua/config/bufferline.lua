require('bufferline').setup({
  options = {
    offsets = { { filetype = 'NvimTree', text = '' } },
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    show_buffer_close_icons = true,
    separator_style = 'thin',
    mappings = 'true',
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(_, _, diagnostics_dict)
      local s = ' '
      for e, n in pairs(diagnostics_dict) do
        local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or (e == 'info' and ' ' or ' '))
        s = s .. sym .. n .. ' '
      end
      return s
    end,
  },
})

local opt = { silent = true }
local map = vim.api.nvim_set_keymap

-- MAPPINGS
map('n', '<leader>bn', '<Cmd>tabnew<CR>', opt) -- new tab
map('n', '<C-x>', '<Cmd>bdelete<CR>', opt) -- close tab

-- move between tabs
map('n', '<TAB>', '<Cmd>BufferLineCycleNext<CR>', opt)
map('n', '<S-TAB>', '<Cmd>BufferLineCyclePrev<CR>', opt)
