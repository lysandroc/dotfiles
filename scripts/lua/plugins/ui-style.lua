return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup({
                style = "night",
            })
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
    {
        "echasnovski/mini.hipatterns",
        event = "BufReadPre",
        config = function()
            require("mini.hipatterns").setup({
                highlighters = {
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "SmiteshP/nvim-navic", "kyazdani42/nvim-web-devicons" },
        config = function()
            require("config.lualine").setup()
        end,
        event = "VeryLazy",
    },
}
