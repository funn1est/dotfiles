local g = vim.g

g.nvim_tree_side = 'left'
g.nvim_tree_width = 30
g.nvim_tree_ignore = { '.git', '.cache', '.idea' }
g.nvim_tree_quit_on_open = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ':t'
g.nvim_tree_allow_resize = 1
g.nvim_tree_icons = {
  git = {
    unstaged = '',
    staged = 'S',
    untracked = 'U',
  },
}

g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
}

require('nvim-tree').setup({
  update_focused_file = {
    enable = true,
  },
})

-- Mappings for nvimtree

vim.api.nvim_set_keymap('n', '<f2>', ':NvimTreeToggle<CR>', {
  noremap = true,
  silent = true,
})
