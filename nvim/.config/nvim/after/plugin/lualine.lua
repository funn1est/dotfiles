local function lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ''
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. '%% ' .. (msg.title or ''))
  end
  local spinners = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, ' | ') .. ' ' .. spinners[frame + 1]
end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

local config = {
  options = {
    theme = 'catppuccin',
    section_separators = { '', '' },
    component_separators = { '', '' },
    icons_enabled = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
      { 'diagnostics', symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' } },
    },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'filetype', lsp_progress },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { 'neo-tree' },
}

require('lualine').setup(config)
