return {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    -- Downloads the prebuilt preview server into the plugin dir.
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    keys = {
        { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown preview (browser)" },
    },
    init = function()
        -- Don't auto-open the browser on entering a markdown buffer.
        vim.g.mkdp_auto_start = 0
        -- Keep the preview open when switching to a non-markdown buffer.
        vim.g.mkdp_auto_close = 0
        -- Render even while in insert mode / without saving.
        vim.g.mkdp_combine_preview = 1
    end,
}
