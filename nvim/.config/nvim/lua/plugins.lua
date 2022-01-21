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
  use('siduck76/nvim-base16.lua')
  use('norcalli/nvim-colorizer.lua')

  -- icons
  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ default = true })
    end,
  })

  use({
    'akinsho/nvim-bufferline.lua',
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
  use('williamboman/nvim-lsp-installer')
  use({
    'neovim/nvim-lspconfig',
    config = config('lsp'),
    --after = 'nvim-cmp',
  })
  use('jose-elias-alvarez/null-ls.nvim')

  -- use({
  --   'hrsh7th/nvim-cmp',
  --   config = config('nvim_cmp'),
  --   requires = {
  --     {
  --       'L3MON4D3/LuaSnip',
  --       config = function()
  --         -- require('cosmic.plugins.luasnip')
  --       end,
  --       requires = {
  --         'rafamadriz/friendly-snippets',
  --       },
  --     },
  --     { 'hrsh7th/cmp-nvim-lsp' },
  --     { 'hrsh7th/cmp-buffer' },
  --     { 'hrsh7th/cmp-nvim-lua' },
  --     { 'hrsh7th/cmp-path' },
  --     { 'tzachar/cmp-tabnine', run = './install.sh' },
  --     { 'saadparwaiz1/cmp_luasnip' },
  --   },
  -- })
  --use('hrsh7th/vim-vsnip')
  --use('hrsh7th/cmp-vsnip')

  use({ 'ms-jpq/coq_nvim', branch = 'coq', config = config('coq_nvim') })
  use({ 'ms-jpq/coq.artifacts', branch = 'artifacts' })

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
  use('windwp/nvim-autopairs')
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
  use('simrat39/rust-tools.nvim')
  -- ts
  use('jose-elias-alvarez/nvim-lsp-ts-utils')

  use_with_config('kyazdani42/nvim-tree.lua', 'nvim_tree')
  use_with_config('lewis6991/gitsigns.nvim', 'gitsigns')
  use_with_config('nvim-telescope/telescope.nvim', 'telescope')
  use_with_config('glepnir/dashboard-nvim', 'dashboard')
  use('folke/which-key.nvim')
  use({
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = config('indent_blankline'),
  })
  use_with_config('akinsho/nvim-toggleterm.lua', 'terminal')

  -- misc
  use('tweekmonster/startuptime.vim')
  use('nvim-lua/popup.nvim')
  use('nvim-lua/plenary.nvim')
end)
