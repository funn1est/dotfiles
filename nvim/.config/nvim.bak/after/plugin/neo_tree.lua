require('neo-tree').setup({
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = 'open_current',
  },
})
