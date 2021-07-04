local g = vim.g
g.indent_blankline_use_treesitter = true
g.indent_blankline_show_current_context = true
g.indentLine_faster = 1
g.indentLine_fileTypeExclude = { 'tex', 'markdown', 'txt', 'startify', 'packer', 'trouble' }
g.indent_blankline_show_first_indent_level = false
g.indent_blankline_show_trailing_blankline_indent = false

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = '99999'
