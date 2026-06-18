return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "kyazdani42/nvim-web-devicons",
    },
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {
        -- Render in normal/command mode; un-render the line you're editing
        -- so insert mode shows the raw markdown.
        render_modes = { "n", "c", "t" },
        anti_conceal = { enabled = true },
        heading = {
            -- Use the same width as the heading text instead of full-width bars.
            width = "block",
            position = "inline",
        },
        code = {
            -- Tint the code block background and show the language + icon.
            width = "block",
            border = "thin",
            language_name = true,
        },
        checkbox = {
            checked = { icon = "󰄲 " },
            unchecked = { icon = "󰄱 " },
        },
    },
}
