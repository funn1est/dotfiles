local packer = require('packer')

vim.cmd('packadd packer.nvim')

return packer.startup(function(use)
  use('wbthomason/packer.nvim')

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

  use('akinsho/bufferline.nvim')
  use('nvim-lualine/lualine.nvim')

  use({
    'RRethy/vim-illuminate',
    config = function()
      vim.api.nvim_command('hi illuminatedWord cterm=underline gui=underline')
      --vim.api.nvim_command('hi link illuminatedCurWord Search')
    end,
  })
  use('justinmk/vim-sneak')
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
    -- opt = true,
    requires = {
      'p00f/nvim-ts-rainbow',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
    },
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

  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'nvim-telescope/telescope-ui-select.nvim' })
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })
  use('glepnir/dashboard-nvim')
  use('folke/which-key.nvim')
  use('lukas-reineke/indent-blankline.nvim')

  -- misc
  use('tweekmonster/startuptime.vim')
  use('nvim-lua/popup.nvim')
  use('nvim-lua/plenary.nvim')
end)
