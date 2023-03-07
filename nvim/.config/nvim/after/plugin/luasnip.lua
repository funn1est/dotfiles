local ls = require('luasnip')
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local types = require('luasnip.util.types')
local conds = require('luasnip.extras.expand_conditions')

ls.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = 'TextChanged,TextChangedI',
  ext_opts = {
    -- [types.choiceNode] = {
    --   active = {
    --     virt_text = { { 'choiceNode', 'Comment' } },
    --   },
    -- },
    -- [types.choiceNode] = {
    --   active = {
    --     virt_text = { { '●', 'GruvboxOrange' } },
    --   },
    -- },
    -- [types.insertNode] = {
    --   active = {
    --     virt_text = { { '●', 'GruvboxBlue' } },
    --   },
    -- },
  },
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 300,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = false,
})

ls.add_snippets(nil, {
  all = {
    s('fn', fmt('({}) => {lb}{}{rb}', { i(1), i(2), lb = t('{'), rb = t('}') })),
  },
  lua = {
    s('M', {
      t({ 'local M = {}', '', '' }),
      i(0),
      t({ '', '', 'return M' }),
    }),
  },
})

require('luasnip.loaders.from_vscode').lazy_load()
