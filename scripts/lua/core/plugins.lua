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

local keymaps = require("core.keymaps")

local plugins = {
  {
    "David-Kunz/jester",
    config = function()
      require("jester").setup({
        path_to_jest_run = "~/.asdf/shims/node node_modules/.bin/jest",
        terminal_cmd = ":split | terminal", -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
      })
      require("core.keymaps").jester_keymaps()
    end,
  },
  "sheerun/vim-polyglot",
  "tpope/vim-surround",
  "b0o/schemastore.nvim",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  "mattn/emmet-vim",
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
      "airblade/vim-gitgutter",
    },
  },
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_message_when_not_committed = ""
      keymaps.git_blame()
    end,
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
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("solarized-osaka").setup({
        transparent = false,
      })
      vim.cmd[[colorscheme solarized-osaka]]
    end,
  },
  {
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = {
			highlighters = {
				hsl_color = {
					pattern = "hsl%(%d+,? %d+,? %d+%)",
					group = function(_, match)
						local utils = require("solarized-osaka.hsl")
						local h, s, l = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
						h, s, l = tonumber(h), tonumber(s), tonumber(l)
						local hex_color = utils.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		},
	},
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "SmiteshP/nvim-navic", "kyazdani42/nvim-web-devicons" },
    config = function()
      require("config.lualine").setup()
    end,
    event = "VeryLazy"
  },
  { "rcarriga/nvim-notify", config = function() require("notify").setup() end },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim",
        }
      },
      {
        "lysandroc/nvim-telescope-chat",
        dev=true,
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
      },
      { "nvim-treesitter/nvim-treesitter"},
    },
    config = function()
      keymaps.telescope_keymaps()
    end,
    lazy = false,
  },
  {
    "zbirenbaum/copilot-cmp",
    -- local modified version
    -- "lysandroc/copilot-cmp",
    -- dev = true,
    event = "VeryLazy",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        lazy = false,
        dev = true,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({
            suggestion = {
              enabled = true,
              auto_trigger = true,
              -- debounce = 75,
            },
            config = function()
              keymaps.copilot_keymaps()
            end,
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
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
      },
      "williamboman/mason.nvim", -- Mason is a plugin manager for Neovim
      "williamboman/mason-lspconfig.nvim", -- Setup the integration between mason and lspconfig
      "jay-babu/mason-null-ls.nvim", -- Setup available null-ls settings automatically
      "nvimtools/none-ls.nvim", -- sources of diagnostics, code actions, and other code manipulation functions.
      "jose-elias-alvarez/typescript.nvim", -- TypeScript support for null-ls
      { "onsails/lspkind.nvim", dependencies = { "mortepau/codicons.nvim" } }, -- vscode-like pictograms for neovim lsp completion items
    },
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    }
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   config = function()
  --     require("typescript-tools").setup {}
  --   end,
  -- },
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
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      src = {
        cmp = { enabled = true },
      },
    },
  },
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    opts = function()
      local ok, mason_registry = pcall(require, "mason-registry")
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = ""
        if vim.loop.os_uname().sysname:find("Windows") then
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        elseif vim.fn.has("mac") == 1 then
          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        else
          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        end
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      end
      return {
        dap = {
          adapter = adapter,
        },
        tools = {
          on_initialized = function()
            vim.cmd([[
                augroup RustLSP
                autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                augroup END
                ]])
          end,
        },
      }
    end,
    config = function() end,
  },
  {
    "rouge8/neotest-rust",
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        ["neotest-rust"] = {},
      },
    },
  }
  -- {
  --   "lysandroc/nvim-json2ts",
  --   dev=true,
  --   lazy=false,
  --   config = function()
  --     require("notify")("plugin loaded")
  --     -- print(vim.fn.printf('Loading %s', '- nvim-json2ts'))
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
  -- plugins are versioned, to know more read setup.sh
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    -- { import = "plugins" },
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})