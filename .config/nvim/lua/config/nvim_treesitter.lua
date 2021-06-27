require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'javascript',
    'typescript',
    'html',
    'css',
    'bash',
    'lua',
    'json',
    'toml',
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
})
