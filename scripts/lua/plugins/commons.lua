local keymaps = require("core.keymaps")

return {{
    "David-Kunz/jester",
    config = function()
        require("jester").setup({
            path_to_jest_run = "~/.asdf/shims/node node_modules/.bin/jest",
            terminal_cmd = ":split | terminal" -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
        })
        require("core.keymaps").jester_keymaps()
    end
}, "sheerun/vim-polyglot", "tpope/vim-surround",
-- deprecate this plugin since we will use lazyvim, lazyvim has builtin for json
-- "b0o/schemastore.nvim",
        {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
}, "mattn/emmet-vim", {
    "tpope/vim-fugitive",
    dependencies = {"tpope/vim-rhubarb", "airblade/vim-gitgutter"}
}, {
    "f-person/git-blame.nvim",
    config = function()
        vim.g.gitblame_message_when_not_committed = ""
        keymaps.git_blame()
    end
}, {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end
}, {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {"nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter-context"},
    build = ":TSUpdate"
    -- lazy = false,
}, {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require("solarized-osaka").setup({
            transparent = false
        })
        vim.cmd([[colorscheme solarized-osaka]])
    end
}, {
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
                end
            }
        }
    }
}, {
    "nvim-lualine/lualine.nvim",
    dependencies = {"SmiteshP/nvim-navic", "kyazdani42/nvim-web-devicons"},
    config = function()
        require("config.lualine").setup()
    end,
    event = "VeryLazy"
}, {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup()
    end
}, {
    "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim", -- {
    -- 	"lysandroc/nvim-telescope-chat",
    -- 	dev = true,
    -- 	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    -- },
    {"nvim-treesitter/nvim-treesitter"}},
    config = function()
        keymaps.telescope_keymaps()
    end,
    lazy = false
}, {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
}, {
    "zbirenbaum/copilot-cmp",
    -- local modified version
    -- "lysandroc/copilot-cmp",
    -- dev = true,
    event = "VeryLazy",
    dependencies = {{
        "zbirenbaum/copilot.lua",
        lazy = false,
        dev = true,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true
                    -- debounce = 75,
                },
                config = function()
                    keymaps.copilot_keymaps()
                end
            })
        end
    }},
    lazy = false
}, {
    "neovim/nvim-lspconfig",
    dependencies = { -- 'nvim-lua/lsp-status.nvim',
    "b0o/schemastore.nvim", "hrsh7th/nvim-cmp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua", "ray-x/cmp-treesitter", -- this can be interesting to migrate my resume to neovim
    -- https://github.com/kdheepak/cmp-latex-symbols
    {
        "L3MON4D3/LuaSnip",
        dependencies = {"rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip"},
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    }, {
        "williamboman/mason.nvim",
        dependencies = {"folke/neodev.nvim"}
    }, -- Mason is a plugin manager for Neovim
    "williamboman/mason-lspconfig.nvim", -- Setup the integration between mason and lspconfig
    "jay-babu/mason-null-ls.nvim", -- Setup available null-ls settings automatically
    "nvimtools/none-ls.nvim", -- sources of diagnostics, code actions, and other code manipulation functions.
    "jose-elias-alvarez/typescript.nvim", -- TypeScript support for null-ls
    {
        "onsails/lspkind.nvim",
        dependencies = {"mortepau/codicons.nvim"}
    } -- vscode-like pictograms for neovim lsp completion items
    },
    lazy = false
}, {
    "hrsh7th/nvim-cmp",
    dependencies = {"hrsh7th/cmp-emoji"}
}, -- {
--   "pmizio/typescript-tools.nvim",
--   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
--   config = function()
--     require("typescript-tools").setup {}
--   end,
-- },
-- temporary disable since we will set it up through lazyvim
-- {
-- 	"mfussenegger/nvim-dap",
-- 	dependencies = {
-- 		"rcarriga/nvim-dap-ui",
-- 		"mxsdev/nvim-dap-vscode-js",
-- 		"mortepau/codicons.nvim",
-- 		"folke/neodev.nvim",
-- 		"theHamsta/nvim-dap-virtual-text",
-- 		"nvim-telescope/telescope.nvim",
-- 		"nvim-telescope/telescope-dap.nvim",
-- 	},
-- },
{
    "Saecki/crates.nvim",
    event = {"BufRead Cargo.toml"},
    opts = {
        src = {
            cmp = {
                enabled = true
            }
        }
    }
}, {
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
                adapter = adapter
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
                end
            }
        }
    end,
    config = function()
    end
}, {"rouge8/neotest-rust"}, {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {"rouge8/neotest-rust"},
    opts = {
        adapters = {
            ["neotest-rust"] = {}
        }
    }
} -- {
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

