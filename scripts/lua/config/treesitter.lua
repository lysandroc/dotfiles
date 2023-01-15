local M = {}

M.setup = function()
  require("nvim-treesitter.configs").setup({
    auto_install = true,
    sync_install = false,
    -- ensure_installed = 'all',
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "lua",
      "python",
      "rust",
      "tsx",
      "latex",
      "bash",
      "dot",
      "dockerfile",
      "graphql",
      "json",
      "markdown",
      "typescript",
      "javascript",
      "html",
      "help",
      "query",
    },
    indent = { enable = true, disable = { "python" } },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<c-backspace>",
      },
    },
    autotag = {
      enable = true,
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
    -- It enables AST-based code folding
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    -- textsubjects = { SETUP HERE }
    -- swap = { SETUP HERE }
    -- move = { SETUP HERE }
    -- textobjects = {
    --   select = {
    --     enable = true,
    --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    --     keymaps = {
    --       -- You can use the capture groups defined in textobjects.scm
    --       ['aa'] = '@parameter.outer',
    --       ['ia'] = '@parameter.inner',
    --       ['af'] = '@function.outer',
    --       ['if'] = '@function.inner',
    --       ['ac'] = '@class.outer',
    --       ['ic'] = '@class.inner',
    --     },
    --   },
    --   move = {
    --     enable = true,
    --     set_jumps = true, -- whether to set jumps in the jumplist
    --     goto_next_start = {
    --       [']m'] = '@function.outer',
    --       [']]'] = '@class.outer',
    --     },
    --     goto_next_end = {
    --       [']M'] = '@function.outer',
    --       [']['] = '@class.outer',
    --     },
    --     goto_previous_start = {
    --       ['[m'] = '@function.outer',
    --       ['[['] = '@class.outer',
    --     },
    --     goto_previous_end = {
    --       ['[M'] = '@function.outer',
    --       ['[]'] = '@class.outer',
    --     },
    --   },
    --   swap = {
    --     enable = true,
    --     swap_next = {
    --       ['<leader>swp'] = '@parameter.inner',
    --     },
    --     swap_previous = {
    --       ['<leader>swP'] = '@parameter.inner',
    --     },
    --   },
    -- },
  })
end

return M
