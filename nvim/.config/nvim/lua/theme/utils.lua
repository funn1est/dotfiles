local c = require('colors')
local util = {}

util.bg = c.bg
util.fg = c.fg
util.day_brightness = 0.3

util.colorsUsed = {}
util.colorCache = {}

local function hexToRgb(hex_str)
  local hex = '[abcdef0-9][abcdef0-9]'
  local pat = '^#(' .. hex .. ')(' .. hex .. ')(' .. hex .. ')$'
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, 'hex_to_rgb: invalid hex_str: ' .. tostring(hex_str))

  local r, g, b = string.match(hex_str, pat)
  return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function util.blend(fg, bg, alpha)
  bg = hexToRgb(bg)
  fg = hexToRgb(fg)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format('#%02X%02X%02X', blendChannel(1), blendChannel(2), blendChannel(3))
end

function util.darken(hex, amount, bg)
  return util.blend(hex, bg or util.bg, math.abs(amount))
end
function util.lighten(hex, amount, fg)
  return util.blend(hex, fg or util.fg, math.abs(amount))
end

function util.getColor(color)
  if vim.o.background == 'dark' then
    return color
  end
  if not util.colorCache[color] then
    util.colorCache[color] = util.invertColor(color)
  end
  return util.colorCache[color]
end

function util.highlight(group, color)
  if color.fg then
    util.colorsUsed[color.fg] = true
  end
  if color.bg then
    util.colorsUsed[color.bg] = true
  end
  if color.sp then
    util.colorsUsed[color.sp] = true
  end

  local style = color.style and 'gui=' .. color.style or 'gui=NONE'
  local fg = color.fg and 'guifg=' .. util.getColor(color.fg) or 'guifg=NONE'
  local bg = color.bg and 'guibg=' .. util.getColor(color.bg) or 'guibg=NONE'
  local sp = color.sp and 'guisp=' .. util.getColor(color.sp) or ''

  local hl = 'highlight ' .. group .. ' ' .. style .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp

  if color.link then
    vim.cmd('highlight! link ' .. group .. ' ' .. color.link)
  else
    -- local data = {}
    -- if color.fg then data.foreground = color.fg end
    -- if color.bg then data.background = color.bg end
    -- if color.sp then data.special = color.sp end
    -- if color.style then data[color.style] = true end
    -- vim.api.nvim_set_hl(ns, group, data)
    vim.cmd(hl)
  end
end

function util.syntax(syntax)
  for group, colors in pairs(syntax) do
    util.highlight(group, colors)
  end
end

return util
