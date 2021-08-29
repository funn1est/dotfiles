local null_ls = require('null-ls')
local b = null_ls.builtins

local sources = {
  --b.formatting.prettierd.with({
  --  filetypes = { 'html', 'json', 'yaml', 'markdown' },
  --}),
  b.formatting.stylua.with({
    args = { '--config-path', vim.fn.expand('~/.config/stylua.toml'), '--stdin-filepath', '$FILENAME', '-' },
  }),
  b.formatting.trim_whitespace.with({ filetypes = { 'tmux', 'teal', 'zsh' } }),
  b.diagnostics.write_good,
  b.diagnostics.teal,
  b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
}

local M = {}
M.setup = function(on_attach)
  null_ls.config({
    --debug = true,
    sources = sources,
  })
  require('lspconfig')['null-ls'].setup({ on_attach = on_attach })
end

return M
