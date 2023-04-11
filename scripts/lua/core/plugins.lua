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
  { "David-Kunz/jester",
    config = function()
      require("jester").setup({
        path_to_jest_run = "~/.asdf/shims/node node_modules/.bin/jest",
      })
      require("core.keymaps").jester_keymaps()
    end,
  },
  {
    "scrooloose/nerdtree",
    config = function()
      require("core.keymaps").nerdtree_keymaps()
    end,
    lazy = false,
  },
  "sheerun/vim-polyglot",
  "tpope/vim-surround",
  "b0o/schemastore.nvim",
  "mattn/emmet-vim",
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
      "airblade/vim-gitgutter",
    },
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter-context" },
    build = ":TSUpdate",
    -- lazy = false,
  },
  {
    "ellisonleao/gruvbox.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("gruvbox").setup()
      vim.cmd([[colorscheme gruvbox]])
    end,
    lazy = false,
    priority = 999,
  },
  { "p00f/nvim-ts-rainbow" },
  {
    "junegunn/fzf",
    dependencies = { "junegunn/fzf.vim" },
    lazy = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "SmiteshP/nvim-navic", "kyazdani42/nvim-web-devicons" },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
  },
  {
    -- "zbirenbaum/copilot-cmp",
    "lysandroc/copilot-cmp",
    dev = true,
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        dev = true,
        cmd = "Copilot",
        event='InsertEnter',
        config = function()
          require("copilot").setup({
            suggestion = {
              enabled = false, -- enabling it causes delay when typing
              keymap = {
                accept = "<leader>C",
              },
            },
            panel = { enable = false },
            server_opts_overrides = {
              trace = "verbose",
              settings = {
                advanced = {
                  inlineSuggestCount = 4, -- #completions for getCompletions
                },
              },
            },
          })
        end,
      },
    },
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      --'nvim-lua/lsp-status.nvim',
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "ray-x/cmp-treesitter",
      -- this can be interesting to migrate my resume to neovim
      -- https://github.com/kdheepak/cmp-latex-symbols
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
      },
      "williamboman/mason.nvim", -- Mason is a plugin manager for Neovim
      "williamboman/mason-lspconfig.nvim", -- Setup the integration between mason and lspconfig
      "jay-babu/mason-null-ls.nvim", -- Setup available null-ls settings automatically
      "jose-elias-alvarez/null-ls.nvim", -- sources of diagnostics, code actions, and other code manipulation functions.
      "jose-elias-alvarez/typescript.nvim", -- TypeScript support for null-ls
      { "onsails/lspkind.nvim", dependencies = { "mortepau/codicons.nvim" } }, -- vscode-like pictograms for neovim lsp completion items
    },
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
      "mortepau/codicons.nvim",
      "folke/neodev.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-dap.nvim",
    },
  },
  -- {
  --   "lysandroc/nvim-json2ts",
  --   dev=true,
  --   lazy=false,
  --   config = function()
  --     print(vim.fn.printf('Loading %s', '- nvim-json2ts'))
  --     -- local a = require("nvim-json2ts")
  --     -- print(vim.fn.printf("nvim-json2ts: %s", vim.inspect(a)))
  --   end
  -- },
}

require("lazy").setup(plugins, {
  dev = {
    -- directory where you store your local plugin projects
    path = "~/projects",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
})
