local colors = {}

colors = {
  none = 'NONE',
  bg = '#282c34',
  bg2 = '#21252b',
  bg_visual = '#393f4a',
  border = '#646e82',
  bg_highlight = '#242b38',
  fg = '#abb2bf',
  fg_light = '#adbac7',
  fg_dark = '#798294',
  fg_gutter = '#5c6370',
  dark5 = '#abb2bf',
  blue = '#61afef',
  cyan = '#56b6c2',
  purple = '#c678dd',
  orange = '#d19a66',
  yellow = '#e0af68',
  yellow2 = '#e2c08d',
  bg_yellow = '#ebd09c',
  green = '#98c379',
  red = '#e86671',
  red1 = '#f65866',
  git = { change = '#e0af68', add = '#109868', delete = '#9A353D', conflict = '#bb7a61' },
  gitSigns = { change = '#e0af68', add = '#109868', delete = '#9A353D' },
}

colors.error = colors.red
colors.warning = colors.yellow
colors.info = colors.blue
colors.hint = colors.cyan

return colors
