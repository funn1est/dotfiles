local util = require('theme.utils')
local c = require('colors')

local base16 = require('base16')
base16(base16.themes.onedark, true)

-- local theme = {}
-- theme.base = {
--   SpellBad = { sp = c.error, style = 'undercurl' }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
--   SpellCap = { sp = c.warning, style = 'undercurl' }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
--   SpellLocal = { sp = c.info, style = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
--   SpellRare = { sp = c.hint, style = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
--   -- These groups are for the native LSP client. Some other LSP clients may
--   -- use these groups, or use their own. Consult your LSP client's
--   -- documentation.
--   LspReferenceText = { bg = c.fg_gutter }, -- used for highlighting "text" references
--   LspReferenceRead = { bg = c.fg_gutter }, -- used for highlighting "read" references
--   LspReferenceWrite = { bg = c.fg_gutter }, -- used for highlighting "write" references
--
--   DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
--   DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
--   DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
--   DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
--
--   DiagnosticVirtualTextError = { bg = util.darken(c.error, 0.1), fg = c.error }, -- Used for "Error" diagnostic virtual text
--   DiagnosticVirtualTextWarn = { bg = util.darken(c.warning, 0.1), fg = c.warning }, -- Used for "Warning" diagnostic virtual text
--   DiagnosticVirtualTextInfo = { bg = util.darken(c.info, 0.1), fg = c.info }, -- Used for "Information" diagnostic virtual text
--   DiagnosticVirtualTextHint = { bg = util.darken(c.hint, 0.1), fg = c.hint }, -- Used for "Hint" diagnostic virtual text
--
--   DiagnosticUnderlineError = { style = 'undercurl', sp = c.error }, -- Used to underline "Error" diagnostics
--   DiagnosticUnderlineWarn = { style = 'undercurl', sp = c.warning }, -- Used to underline "Warning" diagnostics
--   DiagnosticUnderlineInfo = { style = 'undercurl', sp = c.info }, -- Used to underline "Information" diagnostics
--   DiagnosticUnderlineHint = { style = 'undercurl', sp = c.hint }, -- Used to underline "Hint" diagnostics
--
--   LspSignatureActiveParameter = { fg = c.orange },
--   LspCodeLens = { fg = c.comment },
-- }
--
-- util.syntax(theme.base)
