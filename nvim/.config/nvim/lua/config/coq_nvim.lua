vim.g.coq_settings = {
  keymap = {
    recommended = false,
  },
  auto_start = 'shut-up',
  clients = {
    tabnine = {
      enabled = true,
    },
  },
}

vim.api.nvim_set_keymap('i', '<Esc>', [[pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<C-c>', [[pumvisible() ? "\<C-e>\<C-c>" : "\<C-c>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<BS>', [[pumvisible() ? "\<C-e>\<BS>" : "\<BS>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<BS>"]], { expr = true, noremap = true })

function _G.CR()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info().selected ~= -1 then
      return vim.api.nvim_replace_termcodes('<C-y>', true, true, true)
    else
      return vim.api.nvim_replace_termcodes('<C-e>', true, true, true) .. require('nvim-autopairs').autopairs_cr()
    end
  else
    return require('nvim-autopairs').autopairs_cr()
  end
end
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.CR()', { expr = true, noremap = true })
