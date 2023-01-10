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
  'github/copilot.vim'
  , 'sheerun/vim-polyglot'
  , 'tpope/vim-surround'
  , 'b0o/schemastore.nvim'
  , 'mattn/emmet-vim'
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
      'nvim-treesitter/nvim-treesitter',
      dependencies = { 'nvim-treesitter/playground' },
      build = ':TSUpdate',
      lazy = false
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
        { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
        'nvim-treesitter/nvim-treesitter'
      },
      lazy=false
    }
  , { 'williamboman/mason.nvim' }
  , {
      'neovim/nvim-lspconfig',
      dependencies = {
        --'nvim-lua/lsp-status.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'ray-x/cmp-treesitter',
        -- this can be interesting to migrate my resume to neovim 
        -- https://github.com/kdheepak/cmp-latex-symbols
        {
          'L3MON4D3/LuaSnip',
          dependencies = { 'rafamadriz/friendly-snippets', 'saadparwaiz1/cmp_luasnip' }
        },
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jose-elias-alvarez/null-ls.nvim',
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
  -- , { 'zbirenbaum/copilot-cmp', dependencies = {
  --     {
  --       'zbirenbaum/copilot.lua',
  --       cmd='Copilot',
  --       lazy = false,
  --       event='InsertEnter',
  --       config = function()
  --         vim.schedule(function()
  --           require('copilot').setup({
  --             suggestion = { enabled = true },
  --             panel = { enabled = true }
  --           })
  --         end)
  --       end
  --     },
  --   }, lazy=false}
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
