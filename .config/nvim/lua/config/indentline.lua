local g = vim.g
g.indent_blankline_use_treesitter = true
g.indent_blankline_show_current_context = true
g.indentLine_faster = 1
g.indentLine_fileTypeExclude = { 'tex', 'markdown', 'txt', 'startify', 'packer', 'trouble' }
g.indent_blankline_show_first_indent_level = false
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_context_patterns = {
  'class',
  'return',
  'function',
  'method',
  '^if',
  '^while',
  'jsx_element',
  '^for',
  '^object',
  '^table',
  'block',
  'arguments',
  'if_statement',
  'else_clause',
  'jsx_element',
  'jsx_self_closing_element',
  'try_statement',
  'catch_clause',
  'import_statement',
  'operation_type',
  'let_declaration',
}

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = '99999'
