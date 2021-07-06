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
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 2000, -- Do not enable for files with more than 1000 lines, int
    colors = {
      '#e06c75',
      '#98c379',
      '#e5c07b',
      '#61afef',
      '#c678dd',
      '#56b6c2',
      '#c8ccd4',
    },
    termcolors = {
      'Red',
      'Green',
      'Yellow',
      'Blue',
      'Magenta',
      'Cyan',
      'White',
    },
  },
})
