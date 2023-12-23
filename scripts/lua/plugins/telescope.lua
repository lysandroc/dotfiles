local keymaps = require("core.keymaps")

return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            keymaps.telescope_keymaps()
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    -- {
        -- 	"lysandroc/nvim-telescope-chat",
        -- 	dev = true,
    -- },
}
