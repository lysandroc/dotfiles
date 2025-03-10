return {
    "epwalsh/obsidian.nvim",
    -- lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        vim.opt.conceallevel=1
        require("obsidian").setup({
            workspaces = {
                {
                    name = "notes",
                    path = "/Users/lysandroc/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes",
                },
            },
            follow_url_func = function(url)
                -- opens external url in a browser
                vim.fn.jobstart({"open", url})  -- Mac OS
            end,
            -- mappings = {
            --     ["<leader>ob"] = {
            --         action = function()
            --             return require("obsidian").open_workspace("notes")
            --         end,
            --         opts = { noremap = false, expr = true, buffer = true },
            --     }
            -- },
        })
    end,
}
