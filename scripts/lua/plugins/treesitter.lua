return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter-context" },
        build = ":TSUpdate",
        -- lazy = false,
    },
}
