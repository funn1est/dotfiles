-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    opts.noremap = opts.noremap ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("i", "jj", "<esc>")
map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "$")
map("n", "<leader>ij", "o<esc>k")
map("n", "<leader>ik", "O<esc>j")

map("n", "U", "<C-r>")
-- keep J cursor position
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

--map("n", "gp", "%")

map("x", "<leader>p", '"_dP')
map({ "n", "v" }, "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')
map({ "n", "v" }, "<leader>d", '"_d')

map("t", "jj", [[<C-\><C-n>]])
