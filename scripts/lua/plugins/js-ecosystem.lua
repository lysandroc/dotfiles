return {
    "nvim-ts-autotag",
    {
        "David-Kunz/jester",
        config = function()
            require("jester").setup({
                path_to_jest_run = "~/.asdf/shims/node node_modules/.bin/jest",
                terminal_cmd = ":split | terminal", -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
            })
            require("core.keymaps").jester_keymaps()
        end,
    }, -- {
    --   "pmizio/typescript-tools.nvim",
    --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    --   config = function()
    --     require("typescript-tools").setup {}
    --   end,
    -- },,
}
