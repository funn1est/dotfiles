local tree_cb = require('nvim-tree.config').nvim_tree_callback

require('nvim-tree').setup({
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    width = 30,
    height = 30,
    side = 'left',
    mappings = {
      list = {
        { key = { 'l', '<CR>', 'o' }, cb = tree_cb('edit') },
        { key = 'h', cb = tree_cb('close_node') },
        { key = 'v', cb = tree_cb('vsplit') },
      },
    },
  },
  filters = {
    custom = {
      '^.git$',
      '^.idea$',
    },
  },
})

-- Mappings for nvimtree

vim.api.nvim_set_keymap('n', '<f2>', ':NvimTreeToggle<CR>', {
  noremap = true,
  silent = true,
})
