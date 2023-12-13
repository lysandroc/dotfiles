local M = {}
local actions = require("telescope.actions")
local fb_actions = require ("telescope").extensions.file_browser.actions

function M.setup()
  require("telescope").setup({
    defaults = {
      file_ignore_patterns = { "node_modules", "vendor", "assets" },
      layout_config = {
        prompt_position = "top",
        horizontal = { width = 0.8, width_padding = 1000 },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      set_env = { ["COLORTERM"] = "truecolor" },
      prompt_prefix = "🔍 ",
      selection_caret = "> ",
      entry_prefix = "  ",
      sorting_strategy = "ascending",
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          -- keybinding conflict
          ["<A-q>"] = false,
          ["<C-q>"] = actions.send_to_qflist,
        },
        n = {
          ["<esc>"] = actions.close,
          -- keybinding conflict
          ["q"] = actions.close,
          ["<A-q>"] = actions.close,
          ["<C-q>"] = actions.send_to_qflist,
        }
      },
    },
    extensions = {
      fzf = {
        -- use the defaults one
      },
      file_browser = {
        hidden = true,
        grouped = true,
        previewer = false,
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        initial_browser = "tree",
        auto_depth = true,
        depth = 1,
        initial_mode = "normal",
        respect_gitignore = false,
        layout_config = { height = 50 },

        mappings = {
          i = {
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.move_selection_next,
            ["<esc>"] = function()
              -- dont close window, instead go back to normal mode
              vim.cmd("stopinsert")
            end,
            ["<C-c>"] = function()
              local file = require("telescope.actions.state").get_selected_entry().value
              require("notify")("Copied " .. file)
              vim.cmd("let @+='" .. file .. "'")
            end,
          },
          n = {
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.move_selection_next,
            ["n"] = fb_actions.create,
            ["<leader>"] = actions.toggle_selection,
            ["<C-c>"] = function()
              local file = require("telescope.actions.state").get_selected_entry().value
              require("notify")("Copied " .. file)
              vim.cmd("let @+='" .. file .. "'")
            end,
          },
        },
      },
    },
    pickers = {
      -- Your special builtin config goes in here
      buffers = {
        sort_lastused = true,
        -- theme = "dropdown",
        -- previewer = false,
        mappings = {
          i = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          },
          n = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          },
        },
      },
      -- find_files = {
      --   theme = "dropdown",
      --   layout_strategy='vertical',
      --   layout_config={width=0.8}
      -- }
    },
  })
  require("telescope").load_extension("fzy_native")
  require("telescope").load_extension("file_browser")
end

return M
