return {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    cmd = { "TableModeToggle", "TableModeEnable", "TableModeDisable", "Tableize" },
    keys = {
        { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle table mode" },
        { "<leader>tt", "<cmd>Tableize<cr>", desc = "Tableize selection", mode = { "n", "v" } },
    },
    init = function()
        -- GitHub-flavored markdown corners/fillers instead of vim's default `+`.
        vim.g.table_mode_corner = "|"
        vim.g.table_mode_corner_corner = "|"
        vim.g.table_mode_header_fillchar = "-"
    end,
}
