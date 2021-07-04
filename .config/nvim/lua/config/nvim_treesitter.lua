require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'javascript',
    'tsx',
    'typescript',
    'html',
    'css',
    'bash',
    'lua',
    'json',
    'toml',
    'rust',
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
})
