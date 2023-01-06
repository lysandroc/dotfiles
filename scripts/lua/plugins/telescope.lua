local M = {}
local actions = require('telescope.actions')

function M.setup()
  require('telescope').setup{
    defaults = {
      file_ignore_patterns = { "node_modules", "vendor" },
      layout_config = {
        prompt_position = "top",
        horizontal = { width = 0.8, width_padding = 1000 },
      },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      },
      set_env = { ['COLORTERM'] = 'truecolor' },
      prompt_prefix = "🔍 ",
      selection_caret = "> ",
      entry_prefix = "  ",
      sorting_strategy = "ascending",
      generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-q>"] = actions.send_to_qflist,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        }
      }
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
          }
        }
      },
      -- find_files = {
      --   theme = "dropdown",
      --   layout_strategy='vertical',
      --   layout_config={width=0.8}
      -- }
    },
  }
  require('telescope').load_extension('fzy_native')
end

M.find_files = function()
  local opts = {}
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
      prompt_title = "< dotfiles repository >",
      cwd = "$HOME/dotfiles",
      find_command = {
        "rg",
        "--smart-case",
        "--files",
        "--hidden",
        "--follow",
        "-g",
        "!.git/*"
      }
    })
end

return M
