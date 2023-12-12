local lualine = require("lualine")
local navic = require("nvim-navic")

local M = {}

M.setup = function()
  lualine.setup({
    options = {
      icons_enabled = true,
      -- theme = "gruvbox",
      theme = "solarized_dark",
      always_divide_middle = true,
      globalstatus = true,
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
    },
    extensions = {
      "nerdtree",
      "fzf",
      "symbols-outline",
      "nvim-tree",
      "toggleterm",
      "quickfix",
      "fugitive",
      "nvim-dap-ui",
    },
    sections = {
      lualine_a = { { "mode" } },
      lualine_b = {
        "branch",
        "diff",
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = "E", warn = "W", info = "I", hint = "H" },
          -- colored = true,
          on_click = function()
            vim.diagnostic.setloclist()
          end,
        },
      },
      lualine_c = {
        -- { function() return "%=" end },
        -- { lsp_client, color = { fg = "#a9a1e1", gui = "bold" } },
        -- { lsp_progress },
      },
      lualine_x = {
        { "filename" },
        { "encoding" },
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
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          navic.get_location,
          -- function (opt)
          --   -- opt.icons = {}
          --   opt.highlight = false
          --   opt.separator = " > "
          --   -- opt.depth_limit = 5
          --   opt.depth_limit_indicator = "(...)"
          --   return navic.get_location(opt)
          -- end,
          cond = navic.is_available,
          -- //
          -- color = { gui = "bold", fg = colors.yellow },
        },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    -- https://github.com/kdheepak/tabline.nvim
    tabline = {
      lualine_c = {
        {
          "buffers",
          show_filename_only = false, -- show shortened relative path
          mode = 4, -- Show buf name+number
          max_length = vim.o.columns * 4 / 5,
        },
      },
      -- lualine_x = {
      --   {
      --     'tabs',
      --     mode=1, -- show only buf name
      --     max_length = vim.o.columns / 5,
      --     tabs_color = {
      --       active = 'lualine_c_normal',     -- Color for active buffer.
      --       inactive = 'lualine_c_inactive', -- Color for inactive buffer.
      --     }
      --   },
      -- },
    },
  })
end

return M
