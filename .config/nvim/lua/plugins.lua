local packer = require("packer")
local use = packer.use

return packer.startup(function ()
  use 'wbthomason/packer.nvim'

  use 'siduck76/nvim-base16.lua'
  use 'norcalli/nvim-colorizer.lua'

  use 'akinsho/nvim-bufferline.lua'
  use 'glepnir/galaxyline.nvim'

  use 'itchyny/vim-cursorword'
  use 'justinmk/vim-sneak'

  -- lang
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use 'hrsh7th/nvim-compe'
  use 'nvim-treesitter/nvim-treesitter'
  use 'onsails/lspkind-nvim'
  use 'windwp/nvim-autopairs'
  use 'alvan/vim-closetag'

  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- misc
  use 'tweekmonster/startuptime.vim'
  use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }
end)
