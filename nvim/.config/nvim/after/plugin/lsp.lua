local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.set_preferences({
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
})

lsp.nvim_workspace()

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I',
  },
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})

--require('mason').setup()
--require('mason-lspconfig').setup()

--require('mason-null-ls').setup_handlers()

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
local b = null_ls.builtins

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)
  end,
  sources = {
    --null_ls.builtins.formatting.stylua,
    b.formatting.stylua.with({
      args = { '--config-path', vim.fn.expand('~/.config/stylua.toml'), '--stdin-filepath', '$FILENAME', '-' },
    }),
  },
})

require('mason-null-ls').setup({
  ensure_installed = { 'stylua' },
  automatic_setup = false,
})
