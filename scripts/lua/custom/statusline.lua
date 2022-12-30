local lualine = require('lualine')
local theme = require('lualine.themes.gruvbox-material')

local navic = require('nvim-navic')

-- mimic the exact green color from my gruvbox theme
local colors = {
  green = "#98971a",
  yellow = "#d79921"
}

local M = {}

M.setup = function ()
  lualine.setup {
    options = {
      icons_enabled = false,
      theme = 'gruvbox-material',
      always_divide_middle = true,
      globalstatus = true,
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
    },
    extensions = { "nvim-tree", "toggleterm", "quickfix", "fugitive", "nvim-dap-ui" },
    sections = {
      -- always use the bg from the theme to define the color's mode
      lualine_a = { { "mode", color = { bg = theme.insert.a.bg } } },
      lualine_b = {
        "branch",
        "diff",
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
          -- colored = true,
        },
      },
      lualine_c = {
        {
          function (opt)
            opt.icons = {}
            opt.highlight = false
            opt.separator = " > "
            opt.depth_limit = 5
            opt.depth_limit_indicator = "(...)"
            return navic.get_location(opt)
          end,
          -- navic.get_location,
          cond = navic.is_available,
          color = { gui = "bold", fg = colors.yellow },
        },
        -- { function() return "%=" end },
        -- { lsp_client, color = { fg = "#a9a1e1", gui = "bold" } },
        -- { lsp_progress },
      },
      lualine_x = {
        { "filename", "encoding" }
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path= 1, shorting_target = 20 } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path= 1, shorting_target = 20, color =  { gui = "bold", fg =  colors.green } } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }
end

return M
