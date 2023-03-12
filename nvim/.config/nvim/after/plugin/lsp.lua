local lsp = require('lsp-zero').preset('recommended')

lsp.set_sign_icons({
  error = 'E',
  warn = 'W',
  hint = 'H',
  info = 'I',
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr }
  local bind = vim.keymap.set
  lsp.default_keymaps(opts) -- add lsp-zero defaults

  bind('n', '<leader>cf', vim.lsp.buf.format, opts)
end)

require('neodev').setup()
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
  }),
  sources = cmp.config.sources({
    { name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'luasnip', group_index = 2, keyword_length = 2 },
  }, {
    { name = 'buffer', keyword_length = 3 },
    { name = 'path' },
  }),
  sorting = {
    priority_weight = 2,
    comparators = {
      require('copilot_cmp.comparators').prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  experimental = {
    ghost_text = true,
  },
})

vim.diagnostic.config({
  virtual_text = true,
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'cssls',
    'html',
    'jsonls',
    'lua_ls',
    'rust_analyzer',
    'taplo',
    'tsserver',
  },
})

local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
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
    b.formatting.rustfmt,
    b.formatting.prettier,
  },
})

require('mason-null-ls').setup({
  ensure_installed = { 'stylua' },
  automatic_installation = true,
  automatic_setup = false,
})
