local fn = vim.fn
local package_root = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local ensure_packer = function()
  if fn.empty(fn.glob(package_root)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', package_root})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use.
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have Packer use a popup window.
-- packer.init {
--   package_root = package_root,
--   display = {
--     open_fn = function()
--       return require("packer.util").float { border = "rounded" }
--     end,
--   },
-- }

return require('packer').startup(function(use)
  -- Keep packer up to date
  use 'wbthomason/packer.nvim'

  use 'nvim-treesitter/nvim-treesitter'
  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', event= 'BufReadPost' }
  -- use { 'p00f/nvim-ts-rainbow', run = ':TSUpdate' }
  -- General packages

  use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim", 'nvim-treesitter/nvim-treesitter' }, 
    config = function() 
      print("1 Installing gruvbox")
      -- require'gruvbox'.setup()
      -- vim.o.background = "dark"
      -- vim.cmd("colorscheme gruvbox")
    end,  
    run = function()
      print("2 Installing gruvbox")
      -- require'gruvbox'.setup()
      -- vim.o.background = "dark"
      -- vim.cmd("colorscheme gruvbox")
    end
  }
  -- Previous theming
  -- use { 'morhetz/gruvbox', config = function()
  --   vim.g.gruvbox_contrast_dark='hard'
  --   vim.cmd [[colorscheme gruvbox]]
  -- end }
  use 'scrooloose/nerdtree'
  use 'sheerun/vim-polyglot'
  use 'tpope/vim-surround'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'numToStr/Comment.nvim'
  use 'mattn/emmet-vim'
  use  'github/copilot.vim' -- github copilot
  -- use { 'junegunn/fzf', requires = { 'junegunn/fzf.vim' }, run = function() vim.fn['fzf#install']() end } -- fuzzyfinder
  -- use { 'junegunn/fzf', requires = { 'junegunn/fzf.vim' }, run = ':fzf#install' } -- fuzzyfinder
  use { 'junegunn/fzf', requires = { 'junegunn/fzf.vim' } } -- fuzzyfinder
  use { 'nvim-lualine/lualine.nvim', requires = { 'SmiteshP/nvim-navic'} } -- statusline
  -- use 'kyazdani42/nvim-web-devicons'

  use 'b0o/schemastore.nvim'
  --telescope stuffs
  use { 'nvim-telescope/telescope.nvim', requires = { 
      { 'nvim-lua/popup.nvim', opt=false } , 
      { 'nvim-lua/plenary.nvim', opt=false },
      { 'nvim-telescope/telescope-fzy-native.nvim', opt=false },
      { 'nvim-treesitter/nvim-treesitter', opt=false }
    } 
  }

--cmp/lsp/mason/dap
  -- use({ 'hrsh7th/nvim-cmp', requires = {
  --    'hrsh7th/cmp-nvim-lsp'                 -- CMP LSP
  --    'hrsh7th/cmp-buffer'                   -- CMP Buffer
  --    'hrsh7th/nvim-cmp'                     -- Nvim CMP completion plugin
  --    'hrsh7th/cmp-vsnip'                    -- CMP vsnip plugin for CMP
  --    'hrsh7th/vim-vsnip'                    -- Vim Vsnip needed for nvim-cmp
  --    'hrsh7th/vim-vsnip-integ'
  --    'hrsh7th/cmp-path'                     -- File path plugin for nvim-cmp
  --    'hrsh7th/cmp-cmdline'                  -- Command line completion
  --    'ray-x/cmp-treesitter'                 -- Treesitter plugin for nvim-cmp
  --    'tamago324/cmp-zsh'                    -- zsh plugin for nvim-cmp
  -- }})

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'mfussenegger/nvim-dap'
  use 'mxsdev/nvim-dap-vscode-js'
  use 'mortepau/codicons.nvim'
  use 'rcarriga/nvim-dap-ui'
  use 'jose-elias-alvarez/typescript.nvim' --extends tsserver lsp with more commands
  use 'folke/neodev.nvim'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'

  -- read more about this package later
  -- use {
  --   'ojroques/nvim-lspfuzzy',
  --   requires = {
  --     {'junegunn/fzf'},
  --     {'junegunn/fzf.vim'},  -- to enable preview (optional)
  --   },
  -- }
  
  use 'MunifTanjim/nui.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
