local normal_bg = '#3e4451'
local selected_keys = {
  'tab_selected',
  'close_button_selected',
  'buffer_selected',
  'diagnostic_selected',
  'info_selected',
  'info_diagnostic_selected',
  'warning_selected',
  'warning_diagnostic_selected',
  'error_selected',
  'error_diagnostic_selected',
  'modified_selected',
  'duplicate_selected',
  'separator_selected',
  'indicator_selected',
  'pick_selected',
}

local highlights = {}
for _, key in ipairs(selected_keys) do
  highlights[key] = {
    guibg = normal_bg,
  }
end
highlights.indicator_selected.guifg = '#61afef'

require('bufferline').setup({
  highlights = highlights,
  options = {
    offsets = { { filetype = 'NvimTree', text = '' } },
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    show_buffer_close_icons = true,
    separator_style = 'thin',
    diagnostics = false,
    --diagnostics = 'nvim_lsp',
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
