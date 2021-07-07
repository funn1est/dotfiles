local o = vim.o
local cmd = vim.cmd
local map_key = vim.api.nvim_set_keymap

local M = {}

function M.opt(k, v, scopes)
  scopes = scopes or { o }
  for _, s in ipairs(scopes) do
    s[k] = v
  end
end

function M.autocmd(group, cmds, clear)
  clear = clear == nil and false or clear
  if type(cmds) == 'string' then
    cmds = { cmds }
  end
  cmd('augroup ' .. group)
  if clear then
    cmd([[au!]])
  end
  for _, c in ipairs(cmds) do
    cmd('autocmd ' .. c)
  end
  cmd([[augroup END]])
end

function M.map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    map_key(mode, lhs, rhs, opts)
  end
end

function M.has(x)
  return vim.fn.has(x) == 1
end

return M
