return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { -- 'nvim-lua/lsp-status.nvim',
            "b0o/schemastore.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "ray-x/cmp-treesitter", -- this can be interesting to migrate my resume to neovim
            -- https://github.com/kdheepak/cmp-latex-symbols
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp",
            },
            {
                "williamboman/mason.nvim",
                dependencies = { "folke/neodev.nvim" },
            }, -- Mason is a plugin manager for Neovim
            "williamboman/mason-lspconfig.nvim", -- Setup the integration between mason and lspconfig
            "jay-babu/mason-null-ls.nvim", -- Setup available null-ls settings automatically
            -- null-ls will be deprecated use this in favor, or migrate it to conform.nvim and nvim-lint
            -- mason-tools-installer: https://github.com/WhoIsSethDaniel/ma...
            -- conform.nvim: https://github.com/stevearc/conform.nvim
            -- nvim-lint: https://github.com/mfussenegger/nvim-...
            -- https://www.youtube.com/watch?v=ybUE4D80XSk
            "nvimtools/none-ls.nvim", -- sources of diagnostics, code actions, and other code manipulation functions.
            "jose-elias-alvarez/typescript.nvim", -- TypeScript support for null-ls
            {
                "onsails/lspkind.nvim",
                dependencies = { "mortepau/codicons.nvim" },
            }, -- vscode-like pictograms for neovim lsp completion items
        },
        lazy = false,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-emoji" },
    }
}
