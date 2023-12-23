local keymaps = require("core.keymaps")

return {
    {
        "zbirenbaum/copilot.lua",
        lazy = false,
        -- dev = true,
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
    {
        "zbirenbaum/copilot-cmp",
        -- "lysandroc/copilot-cmp",
        -- dev = true,
        event = "VeryLazy",
        dependencies = {
            "zbirenbaum/copilot.lua",
        },
        lazy = false,
    },
}
