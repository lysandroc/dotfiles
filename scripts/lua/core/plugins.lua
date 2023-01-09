local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- 'scrooloose/nerdtree'
  'sheerun/vim-polyglot'
  , 'tpope/vim-surround'
  , 'b0o/schemastore.nvim'
  , 'mattn/emmet-vim'
  , { 'github/copilot.vim', lazy = false }
  , {
      'tpope/vim-fugitive',
      dependencies = {
        'tpope/vim-rhubarb',
        'airblade/vim-gitgutter'
      }
    }
  , {
      'numToStr/Comment.nvim',
      config = function() require("Comment").setup() end
    }
  , {
      'ellisonleao/gruvbox.nvim', 
      dependencies = {
        'rktjmp/lush.nvim',
        'nvim-treesitter/nvim-treesitter'
      },
      config = function()
        require("gruvbox").setup()
        vim.cmd([[colorscheme gruvbox]])
      end,
      lazy=false,
      priority=999,
    }
  , {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      lazy = false
    }
  , { 'p00f/nvim-ts-rainbow' }
  , {
      'junegunn/fzf',
      dependencies = { 'junegunn/fzf.vim' },
      lazy = false
    }
  , {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'SmiteshP/nvim-navic', 'kyazdani42/nvim-web-devicons' }
    }
  , {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzy-native.nvim',
        'nvim-treesitter/nvim-treesitter'
      },
      lazy=false
    }
  , { 'williamboman/mason.nvim' }
  , {
      'neovim/nvim-lspconfig',
      dependencies = {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jose-elias-alvarez/typescript.nvim'
      },
      lazy=false
    }
  , {
      'mfussenegger/nvim-dap',
      dependencies = {
        'rcarriga/nvim-dap-ui',
        'mxsdev/nvim-dap-vscode-js',
        'mortepau/codicons.nvim',
        'folke/neodev.nvim',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-telescope/telescope.nvim',
        'nvim-telescope/telescope-dap.nvim'
      }
    }
  , {
      'nvim-tree/nvim-tree.lua',
      config = function()
        require('nvim-tree').setup({
          view = {
            adaptive_size = true
          }
        })
        require('core.keymaps').tree_keymaps()
      end,
      tag = 'nightly',
    }
}

 return require("lazy").setup(plugins)
