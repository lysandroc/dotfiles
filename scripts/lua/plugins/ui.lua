return {
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                level = vim.log.levels.ERROR,
                minimum_width = 50,
                render = "minimal",
                stages = "fade_in_slide_out",
                timeout = 3000,
                top_down = true
            })
        end,
    },
    -- {
    --     "stevearc/dressing.nvim",
    --     event = "VeryLazy",
    --     opts = {}
    -- },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }
}
