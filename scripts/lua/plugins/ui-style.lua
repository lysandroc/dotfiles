return {
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("solarized-osaka").setup({
                transparent = false,
            })
            vim.cmd([[colorscheme solarized-osaka]])
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
        event = "VeryLazy",
    },
}
