local gl = require('galaxyline')
local gls = gl.section
local condition = require('galaxyline.condition')
local fileinfo = require('galaxyline.provider_fileinfo')

gl.short_line_list = { 'NvimTree' }

local theme = {
  base00 = '#282c34',
  base01 = '#353b45',
  base02 = '#3e4451',
  base03 = '#545862',
  base04 = '#565c64',
  base05 = '#abb2bf',
  base06 = '#b6bdca',
  base07 = '#c8ccd4',
  base08 = '#e06c75',
  base09 = '#d19a66',
  base0A = '#e5c07b',
  base0B = '#98c379',
  base0C = '#56b6c2',
  base0D = '#61afef',
  base0E = '#c678dd',
  base0F = '#be5046',
}

local colors = {
  bg = theme.base00,
  fg = theme.base05,
  lighter_bg = theme.base01,
  selection_bg = theme.base02,
  dark_fg = theme.base04,
  light_fg = theme.base06,
  light_bg = theme.base07,
  red1 = theme.base08,
  red2 = theme.base0F,
  orange = theme.base09,
  yellow = theme.base0A,
  green = theme.base0B,
  cyan = theme.base0C,
  blue = theme.base0D,
  magenta = theme.base0E,
}

local mode_map = {
  ['n'] = 'NORMAL',
  ['no'] = 'O-PENDING',
  ['nov'] = 'O-PENDING',
  ['noV'] = 'O-PENDING',
  ['no'] = 'O-PENDING',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['V'] = 'V-LINE',
  [''] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  [''] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rx'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'REPLACE',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

function get_mode()
  local mode = vim.api.nvim_get_mode().mode
  if mode_map[mode] == nil then
    return mode
  end
  return mode_map[mode]
end

function get_mode_color(mode)
  local mode_colors = {
    ['NORMAL'] = colors.green,
    ['INSERT'] = colors.blue,
    ['COMMAND'] = colors.orange,
    ['VISUAL'] = colors.magenta,
    ['V-LINE'] = colors.magenta,
    ['V-BLOCK'] = colors.magenta,
    ['REPLACE'] = colors.red1,
    ['V-REPLACE'] = colors.red1,
  }

  local color = mode_colors[mode]

  if color == nil then
    color = colors.red2
  end

  return color
end

gls.left[1] = {
  ViMode = {
    provider = function()
      local mode = get_mode()
      vim.api.nvim_command('hi GalaxyViMode guibg=' .. get_mode_color(mode))
      return '  ' .. mode .. ' '
    end,
    highlight = { colors.bg, colors.bg, 'bold' },
    separator_highlight = { colors.bg, colors.bg },
  },
}

gls.left[2] = {
  FileIcon = {
    provider = function()
      local icon = fileinfo.get_file_icon()
      return '  ' .. icon
    end,
    condition = condition.buffer_not_empty,
    highlight = { fileinfo.get_file_icon_color, colors.lighter_bg },
  },
}

gls.left[3] = {
  FileName = {
    provider = { 'FileName' },
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.lighter_bg },
    separator_highlight = { colors.lightbg, colors.lightbg2 },
  },
}

gls.left[5] = {
  current_dir = {
    provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      return '  ' .. dir_name .. ' '
    end,
    highlight = { colors.grey, colors.lightbg2 },
    separator_highlight = { colors.lightbg2, colors.bg },
  },
}

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 30 then
    return true
  end
  return false
end

gls.left[6] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = '  ',
    highlight = { colors.fg, colors.bg },
  },
}

gls.left[7] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '   ',
    highlight = { colors.grey, colors.bg },
  },
}

gls.left[8] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '  ',
    highlight = { colors.grey, colors.bg },
  },
}

gls.left[9] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = { colors.red, colors.bg },
  },
}

gls.left[10] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = { colors.yellow, colors.bg },
  },
}

gls.right[1] = {
  ShowLspClient = {
    provider = function()
      local client = require('galaxyline.provider_lsp').get_lsp_client()
      return client .. ' '
    end,
    condition = function()
      local tbl = { ['dashboard'] = true, [''] = true }
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = '  ',
    highlight = { colors.blue, colors.bg },
  },
}

gls.right[2] = {
  GitIcon = {
    provider = function()
      return ' '
    end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = { colors.grey, colors.lightbg },
    separator_highlight = { colors.lightbg, colors.bg },
  },
}

gls.right[3] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = { colors.grey, colors.lightbg },
  },
}

gls.right[6] = {
  some_icon = {
    provider = function()
      return ' '
    end,
    separator_highlight = { colors.green, colors.lightbg },
    highlight = { colors.lightbg, colors.green },
  },
}

gls.right[7] = {
  line_percentage = {
    provider = function()
      local current_line = vim.fn.line('.')
      local total_line = vim.fn.line('$')

      if current_line == 1 then
        return '  Top '
      elseif current_line == vim.fn.line('$') then
        return '  Bot '
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return '  ' .. result .. '% '
    end,
    highlight = { colors.green, colors.lightbg },
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = { 'NONE', colors.bg },
    highlight = { colors.blue, colors.bg, 'bold' },
  },
}

gls.short_line_left[2] = {
  SFileName = {
    provider = 'SFileName',
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg, 'bold' },
  },
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = 'BufferIcon',
    highlight = { colors.fg, colors.bg },
  },
}
