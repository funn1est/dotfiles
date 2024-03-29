-- local coq = require('coq')
local null_ls = require('config.lsp.null_ls')
local lsp_installer = require('nvim-lsp-installer')

require('config.lsp.diagnostics')
require('config.lsp.handlers')
require('config.lsp.kind')

-- keymaps
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    vim.cmd([[
            augroup format_on_save
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.server_capabilities.document_range_formatting then
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
      false
    )
  end
end

-- config that activates keymaps and enables snippet support
local function make_config()
  --local capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

local setups = {
  typescript = {
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
      local ts_utils = require('nvim-lsp-ts-utils')
      ts_utils.setup({
        eslint_bin = 'eslint_d',
        eslint_enable_diagnostics = true,
        eslint_show_rule_id = true,
        eslint_disable_if_no_config = true,
        enable_formatting = true,
        formatter = 'prettier',
        formatter_config_fallback = 'eslint',
        update_imports_on_move = true,
      })
      ts_utils.setup_client(client)
    end,
    capabilities = make_config().capabilities,
  },
}

local server_opts = {}

server_opts['sumneko_lua'] = vim.tbl_deep_extend('force', require('lua-dev').setup({}), {
  settings = {
    Lua = {
      completion = { callSnippet = 'Disable' },
      workspace = { maxPreload = 2000 },
    },
  },
})

lsp_installer.on_server_ready(function(server)
  local opts = make_config()

  opts = vim.tbl_deep_extend('error', opts, server_opts[server.name] or {})
  -- opts = coq.lsp_ensure_capabilities(opts)

  if server.name == 'rust_analyzer' then
    -- Initialize the LSP via rust-tools instead
    require('rust-tools').setup({
      -- The "server" property provided in rust-tools setup function are the
      -- settings rust-tools will provide to lspconfig during init.            --
      -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
      -- with the user's own settings (opts).
      server = vim.tbl_deep_extend('force', server:get_default_options(), opts),
    })
    server:attach_buffers()
  elseif server.name == 'tsserver' then
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)

      local ts_utils = require('nvim-lsp-ts-utils')

      -- defaults
      ts_utils.setup({
        debug = false,
        disable_commands = false,
        enable_import_on_completion = false,
        enable_formatting = false,

        -- import all
        import_all_timeout = 5000, -- ms
        -- lower numbers = higher priority
        import_all_priorities = {
          same_file = 1, -- add to existing import statement
          local_files = 2, -- git files or files with relative path markers
          buffer_content = 3, -- loaded buffer content
          buffers = 4, -- loaded buffer names
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,
        -- if false will avoid organizing imports
        always_organize_imports = true,

        -- filter diagnostics
        filter_out_diagnostics_by_severity = {},
        filter_out_diagnostics_by_code = {},

        -- inlay hints
        auto_inlay_hints = true,
        inlay_hints_highlight = 'Comment',
        inlay_hints_priority = 200, -- priority of the hint extmarks
        inlay_hints_throttle = 150, -- throttle the inlay hint request
        inlay_hints_format = { -- format options for individual hint kind
          Type = {},
          Parameter = {},
          Enum = {},
          -- Example format customization for `Type` kind:
          -- Type = {
          --     highlight = "Comment",
          --     text = function(text)
          --         return "->" .. text:sub(2)
          --     end,
          -- },
        },

        -- update imports on file move
        update_imports_on_move = false,
        require_confirmation_on_move = false,
        watch_dir = nil,
      })

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)
    end
    server:setup(opts)
  else
    server:setup(opts)
  end
  vim.cmd([[ do User LspAttachBuffers ]])
end)

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define('DiagnosticSignError', { text = '', numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', numhl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', numhl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', numhl = 'DiagnosticSignHint' })

null_ls.setup(on_attach)
