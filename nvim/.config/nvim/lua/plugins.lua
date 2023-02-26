local packer = require('packer')

vim.cmd('packadd packer.nvim')

return packer.startup(function(use)
  use('wbthomason/packer.nvim')

  local config = function(name)
    return string.format([[require('config.%s')]], name)
  end
  local use_with_config = function(path, name)
    use({ path, config = config(name) })
  end

  -- theme
  use('norcalli/nvim-base16.lua')
  use('norcalli/nvim-colorizer.lua')

  -- icons
  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ default = true })
    end,
  })

  use({
    'akinsho/bufferline.nvim',
    event = 'BufReadPre',
    config = config('bufferline'),
  })
  use({
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    config = config('lualine'),
  })

  use({
    'RRethy/vim-illuminate',
    config = function()
      vim.api.nvim_command('hi illuminatedWord cterm=underline gui=underline')
      --vim.api.nvim_command('hi link illuminatedCurWord Search')
    end,
  })
  use_with_config('justinmk/vim-sneak', 'vim_sneak')
  use('mg979/vim-visual-multi')

  -- lsp
  use({
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'jay-babu/mason-null-ls.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
  })

  -- lang
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    opt = true,
    event = 'BufRead',
    requires = {
      'p00f/nvim-ts-rainbow',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
    },
    config = config('treesitter'),
  })
  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  })
  use('alvan/vim-closetag')

  -- lua
  use('folke/lua-dev.nvim')

  use({
    'folke/trouble.nvim',
    event = 'BufReadPre',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = function()
      require('trouble').setup({
        auto_open = false,
        use_diagnostic_signs = true,
      })
    end,
  })

  -- comment
  use({
    'terrortylor/nvim-comment',
    opt = false,
    config = function()
      require('nvim_comment').setup({
        create_mappings = false,
      })
    end,
  })

  -- rust
  --use('simrat39/rust-tools.nvim')
  -- ts
  --use('jose-elias-alvarez/nvim-lsp-ts-utils')

  use_with_config('kyazdani42/nvim-tree.lua', 'nvim_tree')
  use_with_config('lewis6991/gitsigns.nvim', 'gitsigns')
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'nvim-telescope/telescope-ui-select.nvim' })
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })
  use_with_config('glepnir/dashboard-nvim', 'dashboard')
  use('folke/which-key.nvim')
  use({
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = config('indent_blankline'),
  })
  use_with_config('akinsho/toggleterm.nvim', 'terminal')

  -- misc
  use('tweekmonster/startuptime.vim')
  use('nvim-lua/popup.nvim')
  use('nvim-lua/plenary.nvim')
end)
