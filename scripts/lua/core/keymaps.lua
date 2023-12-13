vim.g.mapleader = " "

local Mode = {
  NORMAL = "n",
  INSERT = "i",
  VISUAL = "v",
  VISUAL_BLOCK = "x",
  TERM = "t",
  COMMAND = "c",
}

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- local function test()
--     local a = require('nvim-json2ts').setup()
--     require("notify")(vim.fn.printf("nvim-json2ts: %s", vim.inspect(a)))
--     -- vim.cmd("let @+='" .. file .. "'")
-- end
-- map(
--   Mode.NORMAL,
--   "<space>M",
--   test,
--   { noremap = true, silent = true, desc = "TEST" }
-- )

-- use ctrl+hjkl to move between split/vsplit panels
map(Mode.NORMAL, "<A-h>", "<C-w>h", { noremap = true, silent = true, desc = "Jump to the right panel" })
map(Mode.NORMAL, "<A-j>", "<C-w>j", { noremap = true, silent = true, desc = "Jump to the left panel" })
map(Mode.NORMAL, "<A-k>", "<C-w>k", { noremap = true, silent = true, desc = "Jump to the top panel" })
map(Mode.NORMAL, "<A-l>", "<C-w>l", { noremap = true, silent = true, desc = "Jump to the bottom panel" })
map(Mode.TERM, "<A-h>", "<C-\\><C-n><C-w>h", { noremap = true, silent = true, desc = "Jump to the right panel" })
map(Mode.TERM, "<A-j>", "<C-\\><C-n><C-w>j", { noremap = true, silent = true, desc = "Jump to the left panel" })
map(Mode.TERM, "<A-k>", "<C-\\><C-n><C-w>k", { noremap = true, silent = true, desc = "Jump to the top panel" })
map(Mode.TERM, "<A-l>", "<C-\\><C-n><C-w>l", { noremap = true, silent = true, desc = "Jump to the bottom panel" })

-- resizing with arrow keys
for _, mode in ipairs({ Mode.COMMAND, Mode.NORMAL }) do
  map(mode, "<up>", "10<C-W>+", { noremap = true, silent = true, desc = "Motion - 10 times up" })
  map(mode, "<down>", "10<C-W>-", { noremap = true, silent = true, desc = "Motion - 10 times down" })
  map(mode, "<left>", "3<C-W>>", { noremap = true, silent = true, desc = "Motion - 3 times left" })
  map(mode, "<right>", "3<C-W><", { noremap = true, silent = true, desc = "Motion - 3 times right" })
end

for _, mode in ipairs({ Mode.NORMAL, Mode.VISUAL, Mode.VISUAL_BLOCK, Mode.COMMAND }) do
  -- clipboard
  map(mode, "<leader>y", '"+y<CR>', { noremap = true, silent = true, desc = "yank to the OS in visual mode" })

  map(mode, "<leader>P", '"+P<CR>', { noremap = true, silent = true, desc = "paste from the OS in normal mode" })
end

-- native
map(
  Mode.NORMAL,
  "<esc>",
  ":noh<return><esc>",
  { noremap = true, silent = true, desc = "Hides the hightlight selection" }
)
map(
  Mode.NORMAL,
  "<leader>sp",
  "<leader>sp :set spell!<cr>",
  { noremap = true, silent = true, desc = "Enable the native check spelling" }
)
map(
  Mode.NORMAL,
  "<leader><tab>",
  ":buffers<CR>:buffer<Space>",
  { noremap = true, silent = true, desc = "Switch between buffers natively" }
)
map(
  Mode.NORMAL,
  "<leader>sv",
  ":ls<cr>:vsp<space>\\|<space>b<space>",
  { noremap = true, silent = true, desc = "Duplicates the panel vertically" }
)
map(
  Mode.NORMAL,
  "<leader>sh",
  ":ls<cr>:sp<space>\\|<space>b<space>",
  { noremap = true, silent = true, desc = "Duplicates the panel horizontally" }
)

-- use alt + (q/x/w) to quit, quit saving or just save
map(Mode.NORMAL, "<A-Q>", ":qa!<CR>", { noremap = true, silent = true, desc = "force quit" })
map(Mode.NORMAL, "<A-q>", ":q<CR>", { noremap = true, silent = true, desc = "quits file" })
map(Mode.NORMAL, "<A-x>", ":x<CR>", { noremap = true, silent = true, desc = "quits saving the file" })
map(Mode.NORMAL, "<A-w>", ":w<CR>", { noremap = true, silent = true, desc = "saves file" })
map(Mode.INSERT, "<A-Q>", "<ESC>:qa!<CR>", { noremap = true, silent = true, desc = "force quit" })
map(Mode.INSERT, "<A-q>", "<ESC>:q<CR>", { noremap = true, silent = true, desc = "quits file" })
map(Mode.INSERT, "<A-x>", "<ESC>:x<CR>", { noremap = true, silent = true, desc = "quits saving the file " })
map(Mode.INSERT, "<A-w>", "<ESC>:w<CR>", { noremap = true, silent = true, desc = "saves file" })

-- shortcut for git plugins
map(
  Mode.NORMAL,
  "<leader>hl",
  ":GitGutterLineNrHighlightsToggle<cr>",
  { noremap = true, silent = true, desc = "Toogles git line hightlight " }
)
map(Mode.NORMAL, "<leader>gs", ":G<CR>", { noremap = true, silent = true, desc = "Shows git untracking/staged files" })
map(Mode.NORMAL, "<leader>gp", "<ESC>:G push<CR>", { noremap = true, silent = true, desc = "Git push" })
map(
  Mode.NORMAL,
  "<leader>gB",
  "<ESC>:GBrowse<CR>",
  { noremap = true, silent = true, desc = "Opens github page's file" }
)
map(
  Mode.NORMAL,
  "<leader>gb",
  "<ESC>:GBranches<CR>",
  { noremap = true, silent = true, desc = "Checkouts to another branch" }
)
map(Mode.NORMAL, "<leader>gd", ":Gvdiffsplit<CR>", { noremap = true, silent = true, desc = "Shows git diff" })
map(
  Mode.NORMAL,
  "<leader>gl",
  ":diffget //3<CR>",
  { noremap = true, silent = true, desc = "Adds on stage(tracking) the current line from the right side file" }
)
map(
  Mode.NORMAL,
  "<leader>gh",
  ":diffget //2<CR>",
  { noremap = true, silent = true, desc = "Adds on stage(tracking) the current line from the left side file" }
)

map(
  Mode.VISUAL,
  "J",
  ":m '>+1<CR>gv=gv",
  { noremap = true, silent = true, desc = "Moves the hightlighted lines to the bottom" }
)
map(
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
--   map(
--     Mode.INSERT,
--     "<CTRL-S>",
--     copilot_suggestion.next,
--     { noremap = true, silent = true, desc = "Next Copilot Suggestion" }
--   )
-- end

function M.git_blame()
  map(
    Mode.NORMAL,
    "<space>gbb", --git blame brwoser
    ":GitBlameOpenCommitURL<CR>",
    { noremap = true, silent = true, desc = "Opens the commit under the cursor in the browser" }
  )
end

function M.jester_keymaps()
  local jester = require("jester")
  map(Mode.NORMAL, "<leader>jjr", jester.run, { noremap = true, silent = true, desc = "Run jest" })
  map(Mode.NORMAL, "<leader>jjf", jester.run_file, { noremap = true, silent = true, desc = "Run jest" })
  map(Mode.NORMAL, "<leader>jjd", jester.debug, { noremap = true, silent = true, desc = "Run jest" })
end

-- Attach these keymaps in the LSP plugin
function M.LSP_buf_keymaps(client, bufnr)
  local buf = vim.lsp.buf
  map(
    Mode.NORMAL,
    "gD",
    buf.declaration,
    { noremap = true, silent = true, buffer = bufnr, desc = "Go to declaration" }
  )
  map(Mode.NORMAL, "gd", buf.definition, { noremap = true, silent = true, buffer = bufnr, desc = "Go to definition" })
  map(Mode.NORMAL, "K", buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = "Show hover" })
  map(
    Mode.NORMAL,
    "gi",
    buf.implementation,
    { noremap = true, silent = true, buffer = bufnr, desc = "Go to implementation" }
  )
  map(
    Mode.NORMAL,
    "<c-k>",
    buf.signature_help,
    { noremap = true, silent = true, buffer = bufnr, desc = "Show signature help" }
  )
  map(
    Mode.NORMAL,
    "<space>wa",
    buf.add_workspace_folder,
    { noremap = true, silent = true, buffer = bufnr, desc = "Add workspace folder" }
  )
  map(
    Mode.NORMAL,
    "<space>wr",
    buf.remove_workspace_folder,
    { noremap = true, silent = true, buffer = bufnr, desc = "Remove workspace folder" }
  )
  map(Mode.NORMAL, "<space>wl", function()
    print(vim.inspect(buf.list_workspace_folders()))
  end, { noremap = true, silent = true, buffer = bufnr, desc = "List workspace folders" })
  map(
    Mode.NORMAL,
    "<space>D",
    buf.type_definition,
    { noremap = true, silent = true, buffer = bufnr, desc = "Go to type definition" }
  )
  map(Mode.NORMAL, "<space>rn", buf.rename, { noremap = true, silent = true, buffer = bufnr, desc = "Rename" })
  map(
    Mode.NORMAL,
    "<space>ca",
    buf.code_action,
    { noremap = true, silent = true, buffer = bufnr, desc = "Code action" }
  )
  map(Mode.NORMAL, "gr", buf.references, { noremap = true, silent = true, buffer = bufnr, desc = "References" })
  map(Mode.NORMAL, "<space>f", function()
    buf.format({ async = true })
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Format" })
  -- shortcut for tsserver lsp
  -- telescope integration
  map(Mode.NORMAL, "<space>ws", function()
    require("telescope.builtin").lsp_workspace_symbols()
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Workspace symbols" })
  map(Mode.NORMAL, "<space>ds", function()
    require("telescope.builtin").lsp_document_symbols()
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Document symbols" })

  if client.name == "tsserver" then
    map(
      Mode.NORMAL,
      "<space>tsff",
      ":TSLspFixCurrent<CR>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Fix current" }
    )
    map(
      Mode.NORMAL,
      "<space>tsrf",
      ":TSLspRenameFile<CR>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Rename file" }
    )
    map(
      Mode.NORMAL,
      "<space>tsoi",
      ":TSLspOrganize<CR>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Organize imports" }
    )
    map(
      Mode.NORMAL,
      "<space>tscoi",
      ":TSServerOrganizeImports<CR>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Customized organize imports" }
    )
  end
end

-- Used to enable keymaps for diagnostics
function M.LSP_diagnostic_keymaps()
  map(
    Mode.NORMAL,
    "<space>e",
    vim.diagnostic.open_float,
    { noremap = true, silent = true, desc = "Show diagnostics" }
  )
  map(
    Mode.NORMAL,
    "[d",
    vim.diagnostic.goto_prev,
    { noremap = true, silent = true, desc = "Go to previous diagnostic" }
  )
  map(Mode.NORMAL, "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Go to next diagnostic" })
  map(
    Mode.NORMAL,
    "<space>q",
    vim.diagnostic.setloclist,
    { noremap = true, silent = true, desc = "Set diagnostic list" }
  )
end

function M.telescope_keymaps()
  local telescope = require("telescope.builtin")

  for _, mode in ipairs({ Mode.NORMAL, Mode.VISUAL_BLOCK, Mode.VISUAL }) do
    map(mode, "<leader>sd", function()
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

    map(mode, "<C-p>", function()
      local opts = {} -- custom options
      -- use git_files when the current directory is a git repository
      local ok = pcall(telescope.git_files, opts)
      if not ok then
        telescope.find_files(opts)
      end
    end, { noremap = true, silent = true, desc = "Search files" })

    map(mode, "<leader>sf", function()
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

    map(mode, "<leader><Tab>", telescope.buffers, { noremap = true, silent = true, desc = "Switch Buffers" })
    map(mode, "<leader>sw", function()
      telescope.grep_string({ search = vim.fn.expand("<cword>") })
    end, { noremap = true, silent = true, desc = "Grep string" })
    map(mode, "<leader>sg", function()
      telescope.grep_string({ search = vim.fn.input("Grep for > ") })
    end, { noremap = true, silent = true, desc = "Grep string" })
    map(mode, "<leader>sh", telescope.help_tags, { noremap = true, silent = true, desc = "Help tags" })
    map(mode, "<leader>sc", telescope.colorscheme, { noremap = true, silent = true, desc = "Color scheme" })
    map(mode, "<leader>sb", telescope.builtin, { noremap = true, silent = true, desc = "Built in" })

    map(mode, "<leader>se", function()
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
    map(mode, "<F5>", dap.continue, { noremap = true, silent = true, desc = "Continue" })
    map(mode, "<F10>", dap.step_over, { noremap = true, silent = true, desc = "Step over" })
    map(mode, "<F11>", dap.step_into, { noremap = true, silent = true, desc = "Step into" })
    map(mode, "<S-F11>", dap.step_out, { noremap = true, silent = true, desc = "Step out" })
    map(mode, "<F9>", dap.toggle_breakpoint, { noremap = true, silent = true, desc = "Toggle breakpoint" })
    map(mode, "<S-F9>", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { noremap = true, silent = true, desc = "Set breakpoint" })
    --
    --ADVANCED
    map(mode, "<leader>lp", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { noremap = true, silent = true, desc = "Log point message" })
    map(mode, "<leader>dr", function()
      dap.repl.open({}, "vsplit")
    end, { noremap = true, silent = true, desc = "Open REPL" })
    map(mode, "<leader>dl", dap.run_last, { noremap = true, silent = true, desc = "Run last" })
    map(mode, "<leader>de", function()
      dap.set_exception_breakpoints({ "all" })
    end, { noremap = true, silent = true, desc = "Set exception breakpoints" })
  end
end

function M.DAP_UI_keymaps()
  local dapUI = require("dapui")
  local dapUI_variables_mod = require("dap.ui.variables")

  for _, mode in ipairs({ Mode.COMMAND, Mode.NORMAL, Mode.VISUAL_BLOCK, Mode.VISUAL }) do
    map(mode, "<leader>dapo", dapUI.open, { noremap = true, silent = true, desc = "Open DAP UI" })
    map(mode, "<leader>dapc", dapUI.close, { noremap = true, silent = true, desc = "Close DAP UI" })
    map(mode, "<leader>dapt", dapUI.toggle, { noremap = true, silent = true, desc = "Toggle DAP UI" })

    -- TO BE TESTED
    map(mode, "<leader>d?", dapUI_variables_mod.scopes, { noremap = true, silent = true, desc = "Scopes" })
    map(mode, "<leader>da", require("debugHelper").attach, { noremap = true, silent = true, desc = "Attach" })

    map(mode, "<leader>di", function()
      dapUI_variables_mod.hover(function()
        return vim.fn.expand("<cexpr>")
      end)
    end, { noremap = true, silent = true, desc = "Hover" })
  end

  -- TO BE TESTED
  map(Mode.INSERT, "<leader>di", dapUI_variables_mod.visual_hover, { noremap = true, silent = true, desc = "Hover" })
end

return M
