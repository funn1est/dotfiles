local gl = require('galaxyline')
local gls = gl.section
local condition = require('galaxyline.condition')

gl.short_line_list = { 'NvimTree' }

local colors = {
  bg = '#282c34',
  fg = '#abb2bf',
  green = '#97C378',
  red = '#e06c75',
  lightbg = '#353b45',
  lightbg2 = '#c8ccd4',
  blue = '#61afef',
  yellow = '#e5c07b',
  grey = '#545862',
}

local mode_map = {
  n = 'NORMAL',
  i = 'INSERT',
  R = 'REPLACE',
  v = 'VISUAL',
  V = 'V-LINE',
  [''] = 'V-BLOCK',
  c = 'COMMAND',
  s = 'SELECT',
  S = 'S-LINE',
  [''] = 'S-BLOCK',
  t = 'TERMINAL',
}

gls.left[2] = {
  statusIcon = {
    provider = function()
      return '   '
    end,
    highlight = { colors.bg, colors.blue },
    separator = '  ',
    separator_highlight = { colors.blue, colors.lightbg },
  },
}

gls.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.lightbg },
  },
}

gls.left[4] = {
  FileName = {
    provider = { 'FileName' },
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.lightbg },
    separator = ' ',
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
    separator = ' ',
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
    separator = '',
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

gls.right[4] = {
  viMode_icon = {
    provider = function()
      return ' '
    end,
    highlight = { colors.bg, colors.red },
    separator = ' ',
    separator_highlight = { colors.red, colors.lightbg },
  },
}

gls.right[5] = {
  ViMode = {
    provider = function()
      local current_Mode = mode_map[vim.fn.mode()]

      if current_Mode == nil then
        return '  Terminal '
      else
        return '  ' .. current_Mode .. ' '
      end
    end,
    highlight = { colors.red, colors.lightbg },
  },
}

gls.right[6] = {
  some_icon = {
    provider = function()
      return ' '
    end,
    separator = '',
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
