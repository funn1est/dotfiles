local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'sumneko_lua',
  'rust_analyzer',
})

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

  --vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  --vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  --vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  --vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  --vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  --vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  --vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  --vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  --vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  --vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
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
