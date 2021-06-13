require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'javascript',
    'typescript',
    'html',
    'css',
    'bash',
    'lua',
    'rust',
    'json'
  },
  highlight = {
    enable = true,
    use_languagetree = true
  }
}