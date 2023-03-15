require('catppuccin').setup({
  flavour = 'frappe', -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = 'latte',
    dark = 'frappe',
  },
  integrations = {
    dashboard = true,
    which_key = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
  },
})

vim.cmd.colorscheme('catppuccin')
