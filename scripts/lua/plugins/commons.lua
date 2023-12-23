
return {
    "sheerun/vim-polyglot",
    "tpope/vim-surround",
    "windwp/nvim-autopairs",
    "mattn/emmet-vim",
    -- "octo.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "airblade/vim-gitgutter",
    "numToStr/Comment.nvim",
    {
        "f-person/git-blame.nvim",
        config = function()
            local keymaps = require("core.keymaps")

            vim.g.gitblame_message_when_not_committed = ""
            keymaps.git_blame()
        end,
    },
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
