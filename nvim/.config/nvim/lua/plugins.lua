local packer = require('packer')
local use = packer.use

return packer.startup(function()
  use('wbthomason/packer.nvim')

  use('siduck76/nvim-base16.lua')
  use('norcalli/nvim-colorizer.lua')

  use('akinsho/nvim-bufferline.lua')
  use('hoob3rt/lualine.nvim')

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
  use('neovim/nvim-lspconfig')
  use('kabouzeid/nvim-lspinstall')
  use('hrsh7th/nvim-compe')
  use({ 'tzachar/compe-tabnine', run = './install.sh' })
  use('glepnir/lspsaga.nvim')
  -- lang
  use('nvim-treesitter/nvim-treesitter')
  use('p00f/nvim-ts-rainbow')
  use('windwp/nvim-autopairs')
  use('alvan/vim-closetag')
  use('hrsh7th/vim-vsnip')
  use('rafamadriz/friendly-snippets')
  use('folke/trouble.nvim')

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

  use('kyazdani42/nvim-tree.lua')
  use('kyazdani42/nvim-web-devicons')
  use('lewis6991/gitsigns.nvim')
  use('nvim-telescope/telescope.nvim')
  use('glepnir/dashboard-nvim')
  use('folke/which-key.nvim')
  use('lukas-reineke/indent-blankline.nvim')
  use('akinsho/nvim-toggleterm.lua')

  -- misc
  use('tweekmonster/startuptime.vim')
  use('nvim-lua/popup.nvim')
  use('nvim-lua/plenary.nvim')
end)
