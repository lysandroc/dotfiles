vim.g.mapleader = " "

local Mode = {
  NORMAL = "n",
  INSERT = "i",
  VISUAL = "v",
  VISUAL_BLOCK = "x",
  TERM = "t",
  COMMAND = "c",
}

local keymap = vim.keymap

-- local function map(mode, lhs, rhs, opts)
--     local options = { noremap = true, silent = true }
--     if opts then options = vim.tbl_extend('force', options, opts) end vim.keymap(mode, lhs, rhs, options)
-- end

-- local function test()
--     local a = require('nvim-json2ts').setup()
--     print(vim.fn.printf("nvim-json2ts: %s", vim.inspect(a)))
-- end
--
-- keymap.set(
--   Mode.NORMAL,
--   "<space>M",
--   test,
--   { noremap = true, silent = true, desc = "TEST" }
-- )

-- use ctrl+hjkl to move between split/vsplit panels
keymap.set(Mode.NORMAL, "<A-h>", "<C-w>h", { noremap = true, silent = true, desc = "Jump to the right panel" })
keymap.set(Mode.NORMAL, "<A-j>", "<C-w>j", { noremap = true, silent = true, desc = "Jump to the left panel" })
keymap.set(Mode.NORMAL, "<A-k>", "<C-w>k", { noremap = true, silent = true, desc = "Jump to the top panel" })
keymap.set(Mode.NORMAL, "<A-l>", "<C-w>l", { noremap = true, silent = true, desc = "Jump to the bottom panel" })
keymap.set(Mode.TERM, "<A-h>", "<C-\\><C-n><C-w>h", { noremap = true, silent = true, desc = "Jump to the right panel" })
keymap.set(Mode.TERM, "<A-j>", "<C-\\><C-n><C-w>j", { noremap = true, silent = true, desc = "Jump to the left panel" })
keymap.set(Mode.TERM, "<A-k>", "<C-\\><C-n><C-w>k", { noremap = true, silent = true, desc = "Jump to the top panel" })
keymap.set(
  Mode.TERM,
  "<A-l>",
  "<C-\\><C-n><C-w>l",
  { noremap = true, silent = true, desc = "Jump to the bottom panel" }
)

-- resizing with arrow keys
for _, mode in ipairs({ Mode.COMMAND, Mode.NORMAL }) do
  keymap.set(mode, "<up>", "10<C-W>+", { noremap = true, silent = true, desc = "Motion - 10 times up" })
  keymap.set(mode, "<down>", "10<C-W>-", { noremap = true, silent = true, desc = "Motion - 10 times down" })
  keymap.set(mode, "<left>", "3<C-W>>", { noremap = true, silent = true, desc = "Motion - 3 times left" })
  keymap.set(mode, "<right>", "3<C-W><", { noremap = true, silent = true, desc = "Motion - 3 times right" })
end

for _, mode in ipairs({ Mode.NORMAL, Mode.VISUAL, Mode.VISUAL_BLOCK, Mode.COMMAND }) do
  -- clipboard
  keymap.set(mode, "<leader>y", '"+y<CR>', { noremap = true, silent = true, desc = "yank to the OS in visual mode" })

  keymap.set(
    mode,
    "<leader>P",
    '"+P<CR>',
    { noremap = true, silent = true, desc = "paste from the OS in normal mode" }
  )
end

-- native
keymap.set(
  Mode.NORMAL,
  "<esc>",
  ":noh<return><esc>",
  { noremap = true, silent = true, desc = "Hides the hightlight selection" }
)
keymap.set(
  Mode.NORMAL,
  "<leader>sp",
  "<leader>sp :set spell!<cr>",
  { noremap = true, silent = true, desc = "Enable the native check spelling" }
)
keymap.set(
  Mode.NORMAL,
  "<leader><tab>",
  ":buffers<CR>:buffer<Space>",
  { noremap = true, silent = true, desc = "Switch between buffers natively" }
)
keymap.set(
  Mode.NORMAL,
  "<leader>sv",
  ":ls<cr>:vsp<space>\\|<space>b<space>",
  { noremap = true, silent = true, desc = "Duplicates the panel vertically" }
)
keymap.set(
  Mode.NORMAL,
  "<leader>sh",
  ":ls<cr>:sp<space>\\|<space>b<space>",
  { noremap = true, silent = true, desc = "Duplicates the panel horizontally" }
)

-- use alt + (q/x/w) to quit, quit saving or just save
keymap.set(Mode.NORMAL, "<A-Q>", ":qa!<CR>", { noremap = true, silent = true, desc = "force quit" })
keymap.set(Mode.NORMAL, "<A-q>", ":q<CR>", { noremap = true, silent = true, desc = "quits file" })
keymap.set(Mode.NORMAL, "<A-x>", ":x<CR>", { noremap = true, silent = true, desc = "quits saving the file" })
keymap.set(Mode.NORMAL, "<A-w>", ":w<CR>", { noremap = true, silent = true, desc = "saves file" })
keymap.set(Mode.INSERT, "<A-Q>", "<ESC>:qa!<CR>", { noremap = true, silent = true, desc = "force quit" })
keymap.set(Mode.INSERT, "<A-q>", "<ESC>:q<CR>", { noremap = true, silent = true, desc = "quits file" })
keymap.set(Mode.INSERT, "<A-x>", "<ESC>:x<CR>", { noremap = true, silent = true, desc = "quits saving the file " })
keymap.set(Mode.INSERT, "<A-w>", "<ESC>:w<CR>", { noremap = true, silent = true, desc = "saves file" })

-- shortcut for git plugins
keymap.set(
  Mode.NORMAL,
  "<leader>hl",
  ":GitGutterLineNrHighlightsToggle<cr>",
  { noremap = true, silent = true, desc = "Toogles git line hightlight " }
)
keymap.set(
  Mode.NORMAL,
  "<leader>gs",
  ":G<CR>",
  { noremap = true, silent = true, desc = "Shows git untracking/staged files" }
)
keymap.set(Mode.NORMAL, "<leader>gp", "<ESC>:G push<CR>", { noremap = true, silent = true, desc = "Git push" })
keymap.set(
  Mode.NORMAL,
  "<leader>gB",
  "<ESC>:GBrowse<CR>",
  { noremap = true, silent = true, desc = "Opens github page's file" }
)
keymap.set(
  Mode.NORMAL,
  "<leader>gb",
  "<ESC>:GBranches<CR>",
  { noremap = true, silent = true, desc = "Checkouts to another branch" }
)
keymap.set(Mode.NORMAL, "<leader>gd", ":Gvdiffsplit<CR>", { noremap = true, silent = true, desc = "Shows git diff" })
keymap.set(
  Mode.NORMAL,
  "<leader>gl",
  ":diffget //3<CR>",
  { noremap = true, silent = true, desc = "Adds on stage(tracking) the current line from the right side file" }
)
keymap.set(
  Mode.NORMAL,
  "<leader>gh",
  ":diffget //2<CR>",
  { noremap = true, silent = true, desc = "Adds on stage(tracking) the current line from the left side file" }
)

keymap.set(
  Mode.VISUAL,
  "J",
  ":m '>+1<CR>gv=gv",
  { noremap = true, silent = true, desc = "Moves the hightlighted lines to the bottom" }
)
keymap.set(
  Mode.VISUAL,
  "K",
  ":m '<-2<CR>gv=gv",
  { noremap = true, silent = true, desc = "Moves the hightlighted lines to the top" }
)

local M = {}

-- TEMPORARY DISABLED
-- function M.copilot_keymaps()
--   local copilot_suggestion = require("copilot.suggestion")
--
--   keymap.set(
--     Mode.INSERT,
--     "<CTRL-S>",
--     copilot_suggestion.next,
--     { noremap = true, silent = true, desc = "Next Copilot Suggestion" }
--   )
-- end

function M.git_blame()
  keymap.set(
    Mode.NORMAL,
    "<space>gbb", --git blame brwoser
    ":GitBlameOpenCommitURL<CR>",
    { noremap = true, silent = true, desc = "Opens the commit under the cursor in the browser" }
  )
end

function M.jester_keymaps()
  local jester = require("jester")
  keymap.set(Mode.NORMAL, "<leader>jjr", jester.run, { noremap = true, silent = true, desc = "Run jest" })
  keymap.set(Mode.NORMAL, "<leader>jjf", jester.run_file, { noremap = true, silent = true, desc = "Run jest" })
  keymap.set(Mode.NORMAL, "<leader>jjd", jester.debug, { noremap = true, silent = true, desc = "Run jest" })
end

-- Attach these keymaps in the LSP plugin
function M.LSP_buf_keymaps(client, bufnr)
  local buf = vim.lsp.buf
  keymap.set(
    Mode.NORMAL,
    "gD",
    buf.declaration,
    { noremap = true, silent = true, buffer = bufnr, desc = "Go to declaration" }
  )
  keymap.set(
    Mode.NORMAL,
    "gd",
    buf.definition,
    { noremap = true, silent = true, buffer = bufnr, desc = "Go to definition" }
  )
  keymap.set(Mode.NORMAL, "K", buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = "Show hover" })
  keymap.set(
    Mode.NORMAL,
    "gi",
    buf.implementation,
    { noremap = true, silent = true, buffer = bufnr, desc = "Go to implementation" }
  )
  keymap.set(
    Mode.NORMAL,
    "<c-k>",
    buf.signature_help,
    { noremap = true, silent = true, buffer = bufnr, desc = "Show signature help" }
  )
  keymap.set(
    Mode.NORMAL,
    "<space>wa",
    buf.add_workspace_folder,
    { noremap = true, silent = true, buffer = bufnr, desc = "Add workspace folder" }
  )
  keymap.set(
    Mode.NORMAL,
    "<space>wr",
    buf.remove_workspace_folder,
    { noremap = true, silent = true, buffer = bufnr, desc = "Remove workspace folder" }
  )
  keymap.set(Mode.NORMAL, "<space>wl", function()
    print(vim.inspect(buf.list_workspace_folders()))
  end, { noremap = true, silent = true, buffer = bufnr, desc = "List workspace folders" })
  keymap.set(
    Mode.NORMAL,
    "<space>D",
    buf.type_definition,
    { noremap = true, silent = true, buffer = bufnr, desc = "Go to type definition" }
  )
  keymap.set(Mode.NORMAL, "<space>rn", buf.rename, { noremap = true, silent = true, buffer = bufnr, desc = "Rename" })
  keymap.set(
    Mode.NORMAL,
    "<space>ca",
    buf.code_action,
    { noremap = true, silent = true, buffer = bufnr, desc = "Code action" }
  )
  keymap.set(
    Mode.NORMAL,
    "gr",
    buf.references,
    { noremap = true, silent = true, buffer = bufnr, desc = "References" }
  )
  keymap.set(Mode.NORMAL, "<space>f", function()
    buf.format({ async = true })
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Format" })
  -- shortcut for tsserver lsp
  -- telescope integration
  keymap.set(Mode.NORMAL, "<space>ws", function()
    require("telescope.builtin").lsp_workspace_symbols()
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Workspace symbols" })
  keymap.set(Mode.NORMAL, "<space>ds", function()
    require("telescope.builtin").lsp_document_symbols()
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Document symbols" })

  if client.name == "tsserver" then
    keymap.set(
      Mode.NORMAL,
      "<space>tsff",
      ":TSLspFixCurrent<CR>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Fix current" }
    )
    keymap.set(
      Mode.NORMAL,
      "<space>tsrf",
      ":TSLspRenameFile<CR>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Rename file" }
    )
    keymap.set(
      Mode.NORMAL,
      "<space>tsoi",
      ":TSLspOrganize<CR>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Organize imports" }
    )
    keymap.set(
      Mode.NORMAL,
      "<space>tscoi",
      ":TSServerOrganizeImports<CR>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Customized organize imports" }
    )
  end
end

-- Used to enable keymaps for diagnostics
function M.LSP_diagnostic_keymaps()
  keymap.set(
    Mode.NORMAL,
    "<space>e",
    vim.diagnostic.open_float,
    { noremap = true, silent = true, desc = "Show diagnostics" }
  )
  keymap.set(
    Mode.NORMAL,
    "[d",
    vim.diagnostic.goto_prev,
    { noremap = true, silent = true, desc = "Go to previous diagnostic" }
  )
  keymap.set(
    Mode.NORMAL,
    "]d",
    vim.diagnostic.goto_next,
    { noremap = true, silent = true, desc = "Go to next diagnostic" }
  )
  keymap.set(
    Mode.NORMAL,
    "<space>q",
    vim.diagnostic.setloclist,
    { noremap = true, silent = true, desc = "Set diagnostic list" }
  )
end

function M.telescope_keymaps()
  local telescope = require("telescope.builtin")

  for _, mode in ipairs({ Mode.NORMAL, Mode.VISUAL_BLOCK, Mode.VISUAL }) do
    keymap.set(mode, "<leader>sd", function()
      -- Open dotfiles repository in the current window
      telescope.find_files({
        -- order by name 
        sorting_strategy = "ascending",
        prompt_title = "< dotfiles repository >",
        cwd = "$HOME/dotfiles",
        find_command = {
          "rg",
          "--smart-case",
          "--files",
          "--hidden",
          "--follow",
          "-g",
          "!.git/*",
        },
      })
    end, { noremap = true, silent = true, desc = "Search dotfiles" })

    keymap.set(mode, "<C-p>", function()
      local opts = {} -- custom options
      -- use git_files when the current directory is a git repository
      local ok = pcall(telescope.git_files, opts)
      if not ok then
        telescope.find_files(opts)
      end
    end, { noremap = true, silent = true, desc = "Search files" })

    keymap.set(mode, "<leader>sf", function()
      -- Custom parameters using RG for find_files
      require("telescope.builtin").find_files({
        find_command = {
          "rg",
          "--ignore",
          "--hidden",
          "--files",
          "--glob=!**/.git/*",
          "--glob=!**/node_modules/*",
        },
      })
    end, { noremap = true, silent = true, desc = "Find files" })

    keymap.set(mode, "<leader><Tab>", telescope.buffers, { noremap = true, silent = true, desc = "Switch Buffers" })
    keymap.set(mode, "<leader>sw", function()
      telescope.grep_string({ search = vim.fn.expand("<cword>") })
    end, { noremap = true, silent = true, desc = "Grep string" })
    keymap.set(mode, "<leader>sg", function()
      telescope.grep_string({ search = vim.fn.input("Grep for > ") })
    end, { noremap = true, silent = true, desc = "Grep string" })
    keymap.set(mode, "<leader>sh", telescope.help_tags, { noremap = true, silent = true, desc = "Help tags" })
    keymap.set(mode, "<leader>sc", telescope.colorscheme, { noremap = true, silent = true, desc = "Color scheme" })
    keymap.set(mode, "<leader>sb", telescope.builtin, { noremap = true, silent = true, desc = "Built in" })

    keymap.set(mode, "<leader>se", function()
      local function telescope_buffer_dir()
        return vim.fn.expand("%:p:h")
      end

      require("telescope").extensions.file_browser.file_browser({
        cwd = telescope_buffer_dir(),
      })
    end, { noremap = true, silent = true, desc = "File Browser" })
  end
end

function M.DAP_keymaps()
  local dap = require("dap")

  for _, mode in ipairs({ Mode.COMMAND, Mode.NORMAL, Mode.VISUAL_BLOCK, Mode.VISUAL }) do
    keymap.set(mode, "<F5>", dap.continue, { noremap = true, silent = true, desc = "Continue" })
    keymap.set(mode, "<F10>", dap.step_over, { noremap = true, silent = true, desc = "Step over" })
    keymap.set(mode, "<F11>", dap.step_into, { noremap = true, silent = true, desc = "Step into" })
    keymap.set(mode, "<S-F11>", dap.step_out, { noremap = true, silent = true, desc = "Step out" })
    keymap.set(mode, "<F9>", dap.toggle_breakpoint, { noremap = true, silent = true, desc = "Toggle breakpoint" })
    keymap.set(mode, "<S-F9>", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { noremap = true, silent = true, desc = "Set breakpoint" })
    --
    --ADVANCED
    keymap.set(mode, "<leader>lp", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { noremap = true, silent = true, desc = "Log point message" })
    keymap.set(mode, "<leader>dr", function()
      dap.repl.open({}, "vsplit")
    end, { noremap = true, silent = true, desc = "Open REPL" })
    keymap.set(mode, "<leader>dl", dap.run_last, { noremap = true, silent = true, desc = "Run last" })
    keymap.set(mode, "<leader>de", function()
      dap.set_exception_breakpoints({ "all" })
    end, { noremap = true, silent = true, desc = "Set exception breakpoints" })
  end
end

function M.DAP_UI_keymaps()
  local dapUI = require("dapui")
  local dapUI_variables_mod = require("dap.ui.variables")

  for _, mode in ipairs({ Mode.COMMAND, Mode.NORMAL, Mode.VISUAL_BLOCK, Mode.VISUAL }) do
    keymap.set(mode, "<leader>dapo", dapUI.open, { noremap = true, silent = true, desc = "Open DAP UI" })
    keymap.set(mode, "<leader>dapc", dapUI.close, { noremap = true, silent = true, desc = "Close DAP UI" })
    keymap.set(mode, "<leader>dapt", dapUI.toggle, { noremap = true, silent = true, desc = "Toggle DAP UI" })

    -- TO BE TESTED
    keymap.set(mode, "<leader>d?", dapUI_variables_mod.scopes, { noremap = true, silent = true, desc = "Scopes" })
    keymap.set(
      mode,
      "<leader>da",
      require("debugHelper").attach,
      { noremap = true, silent = true, desc = "Attach" }
    )

    keymap.set(mode, "<leader>di", function()
      dapUI_variables_mod.hover(function()
        return vim.fn.expand("<cexpr>")
      end)
    end, { noremap = true, silent = true, desc = "Hover" })
  end

  -- TO BE TESTED
  keymap.set(
    Mode.INSERT,
    "<leader>di",
    dapUI_variables_mod.visual_hover,
    { noremap = true, silent = true, desc = "Hover" }
  )
end

return M
