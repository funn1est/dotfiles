local lspconfig = require('lspconfig')
local autocmd = require('utils').autocmd

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
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
            augroup format_on_save
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  }
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

local lua_fmt = {
  formatCommand = 'stylua --config-path ~/.config/stylua.toml -',
  formatStdin = true,
}
local rust_fmt = {
  formatCommand = 'rustfmt',
  formatStdin = true,
  lintCommand = 'cargo clippy',
  lintSource = 'cargo',
  lintFormats = { '%f:%l:%c: %m' },
}

local eslint_d = {
  lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintSource = 'eslint_d',
  lintStdin = true,
  lintFormats = { '%f(%l,%c): %tarning %m', '%f(%l,%c): %rror %m' },
  lintIgnoreExitCode = true,
  formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}',
  formatStdin = true,
}

local prettierd = {
  formatCommand = 'prettier_d_slim --config-precedence prefer-file --stdin --stdin-filepath ${INPUT}',
  formatStdin = true,
}

local languages = {
  lua = { lua_fmt },
  --rust = { rust_fmt},
  javascript = { prettierd, eslint_d },
  typescript = { prettierd, eslint_d },
  javascriptreact = { prettierd, eslint_d },
  typescriptreact = { prettierd, eslint_d },
}

local setups = {
  efm = {
    on_attach = on_attach,
    init_options = { documentFormatting = true, codeAction = false },
    filetypes = vim.tbl_keys(languages),
    settings = {
      rootMarkers = { '.git/' },
      languages = languages,
    },
  },
  typescript = {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      require('nvim-lsp-ts-utils').setup({
        -- formatting
        enable_formatting = false,
        formatter = 'prettier_d_slim',
        formatter_config_fallback = 'eslint_d',
      })
      on_attach(client)
    end,
    capabilities = make_config().capabilities,
  },
}

local settings = {
  lua = {
    Lua = {
      runtime = {
        -- LuaJIT in the case of Neovim
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

local function setup_servers()
  require('lspinstall').setup()

  local lspconf = require('lspconfig')
  local servers = require('lspinstall').installed_servers()

  for _, server in pairs(servers) do
    local config = make_config()
    if setups[server] ~= nil then
      config = setups[server]
    elseif settings[server] ~= nil then
      config.settings = settings[server]
    end
    lspconf[server].setup(config)
  end
end

setup_servers()

require('rust-tools').setup({
  server = {
    on_attach = on_attach,
    capabilities = make_config().capabilities,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            'cargo',
            'clippy',
            '--workspace',
            '--message-format=json',
            '--all-targets',
            '--all-features',
          },
        },
      },
    },
  },
})

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require('lspinstall').post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd('bufdo e')
end

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define('LspDiagnosticsSignError', { text = '', numhl = 'LspDiagnosticsDefaultError' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = '', numhl = 'LspDiagnosticsDefaultWarning' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = '', numhl = 'LspDiagnosticsDefaultInformation' })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = '', numhl = 'LspDiagnosticsDefaultHint' })