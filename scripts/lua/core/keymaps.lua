vim.g.mapleader = " "

local Mode = {
    NORMAL = 'n',
    INSERT = 'i',
    VISUAL = 'v',
    VISUAL_BLOCK = 'x',
    TERM = 't',
    COMMAND = 'c',
}

local keymap = vim.keymap

-- local function map(mode, lhs, rhs, opts)
--     local options = { noremap = true, silent = true }
--     if opts then options = vim.tbl_extend('force', options, opts) end
--     vim.keymap(mode, lhs, rhs, options)
-- end

-- use ctrl+hjkl to move between split/vsplit panels
keymap.set(Mode.NORMAL, '<A-h>', '<C-w>h',  { noremap=true, silent=true, desc = "Jump to the right panel" })
keymap.set(Mode.NORMAL, '<A-j>', '<C-w>j',  { noremap=true, silent=true, desc = "Jump to the left panel" })
keymap.set(Mode.NORMAL, '<A-k>', '<C-w>k',  { noremap=true, silent=true, desc = "Jump to the top panel"     })
keymap.set(Mode.NORMAL, '<A-l>', '<C-w>l',  { noremap=true, silent=true, desc = "Jump to the bottom panel" })
keymap.set(Mode.TERM, '<A-h>', '<C-\\><C-n><C-w>h',  { noremap=true, silent=true, desc = "Jump to the right panel" })
keymap.set(Mode.TERM, '<A-j>', '<C-\\><C-n><C-w>j',  { noremap=true, silent=true, desc = "Jump to the left panel"  })
keymap.set(Mode.TERM, '<A-k>', '<C-\\><C-n><C-w>k',  { noremap=true, silent=true, desc = "Jump to the top panel"     })
keymap.set(Mode.TERM, '<A-l>', '<C-\\><C-n><C-w>l',  { noremap=true, silent=true, desc = "Jump to the bottom panel"  })

-- adjust panel's size using arrow keys
keymap.set(Mode.NORMAL, '<up>', '10<C-W>+',  { noremap=true, silent=true, desc = "Motion - 10 times up" })
keymap.set(Mode.NORMAL, '<down>', '10<C-W>-',  { noremap=true, silent=true, desc = "Motion - 10 times down" })
keymap.set(Mode.NORMAL, '<left>', '3<C-W>>',  { noremap=true, silent=true, desc = "Motion - 3 times left" })
keymap.set(Mode.NORMAL, '<right>', '3<C-W><',  { noremap=true, silent=true, desc = "Motion - 3 times right" })

-- clipboard
keymap.set(Mode.NORMAL, '<leader>y', '\"+y<CR>',  { noremap=true, silent=true, desc = "yank to the OS in normal mode" })
keymap.set(Mode.VISUAL, '<leader>y', '\"+y<CR>',  { noremap=true, silent=true, desc = "yank to the OS in visual mode" })
keymap.set(Mode.VISUAL_BLOCK, '<leader>y', '\"+y<CR>',  { noremap=true, silent=true, desc = "yank to the OS in visual mode" })
keymap.set(Mode.NORMAL, '<leader>P', '\"+P<CR>',  { noremap=true, silent=true, desc = "paste from the OS in normal mode" })
keymap.set(Mode.VISUAL, '<leader>P', '\"+P<CR>',  { noremap=true, silent=true, desc = "paste from the OS in visual mode" })
keymap.set(Mode.VISUAL_BLOCK, '<leader>P', '\"+P<CR>',  { noremap=true, silent=true, desc = "paste from the OS in visual mode" })

-- native
keymap.set(Mode.NORMAL, '<esc>', ':noh<return><esc>',  { noremap=true, silent=true, desc = "Hides the hightlight selection" })
keymap.set(Mode.NORMAL, '<leader>sp', '<leader>sp :set spell!<cr>',  { noremap=true, silent=true, desc = "Enable the native check spelling" })
keymap.set(Mode.NORMAL, '<leader><tab>', ':buffers<CR>:buffer<Space>',  { noremap=true, silent=true, desc = "Switch between buffers natively" })
keymap.set(Mode.NORMAL, '<leader>sv', ':ls<cr>:vsp<space>\\|<space>b<space>',  { noremap=true, silent=true, desc = "Duplicates the panel vertically" })
keymap.set(Mode.NORMAL, '<leader>sh', ':ls<cr>:sp<space>\\|<space>b<space>',  { noremap=true, silent=true, desc = "Duplicates the panel horizontally" })

-- use alt + (q/x/w) to quit, quit saving or just save
keymap.set(Mode.NORMAL, '<A-q>', ':q<CR>',  { noremap=true, silent=true, desc = "quits file" })
keymap.set(Mode.NORMAL, '<A-x>', ':x<CR>',  { noremap=true, silent=true, desc = "quits saving the file" })
keymap.set(Mode.NORMAL, '<A-w>', ':w<CR>',  { noremap=true, silent=true, desc = "saves file" })
keymap.set(Mode.INSERT, '<A-q>', '<ESC>:q<CR>',  { noremap=true, silent=true, desc = "quits file" })
keymap.set(Mode.INSERT, '<A-x>', '<ESC>:x<CR>',  { noremap=true, silent=true, desc = "quits saving the file " })
keymap.set(Mode.INSERT, '<A-w>', '<ESC>:w<CR>',  { noremap=true, silent=true, desc = "saves file" })

-- shortcut for git plugins
keymap.set(Mode.NORMAL, '<leader>hl', ':GitGutterLineNrHighlightsToggle<cr>',  { noremap=true, silent=true, desc = "Toogles git line hightlight " })
keymap.set(Mode.NORMAL, '<leader>gs', ':G<CR>',  { noremap=true, silent=true, desc = "Shows git untracking/staged files" })
keymap.set(Mode.NORMAL, '<leader>gp', '<ESC>:G push<CR>',  { noremap=true, silent=true, desc = "Git push" })
keymap.set(Mode.NORMAL, '<leader>gB', '<ESC>:GBrowse<CR>',  { noremap=true, silent=true, desc = "Opens github page's file" })
keymap.set(Mode.NORMAL, '<leader>gb', '<ESC>:GBranches<CR>',  { noremap=true, silent=true, desc = "Checkouts to another branch" })
keymap.set(Mode.NORMAL, '<leader>gd', ':Gvdiffsplit<CR>',  { noremap=true, silent=true, desc = "Shows git diff" })
keymap.set(Mode.NORMAL, '<leader>gl', ':diffget //3<CR>',  { noremap=true, silent=true, desc = "Adds on stage(tracking) the current line from the right side file" })
keymap.set(Mode.NORMAL, '<leader>gh', ':diffget //2<CR>',  { noremap=true, silent=true, desc = "Adds on stage(tracking) the current line from the left side file" })

keymap.set(Mode.VISUAL, 'J',  ":m '>+1<CR>gv=gv",  { noremap=true, silent=true, desc = "Moves the hightlighted lines to the bottom" })
keymap.set(Mode.VISUAL, 'K', ":m '<-2<CR>gv=gv",  { noremap=true, silent=true, desc = "Moves the hightlighted lines to the top" })

local M = {}

-- Attach these keymaps after tree(sidemenu) is initialized
function M.tree_keymaps()
  keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>',  { noremap=true, silent=true, desc = "Open or close the tree. Takes an optional path argument" })
  keymap.set('n', '<leader>N', ':NvimTreeFindFile<CR>',  { noremap=true, silent=true, desc = "Move the cursor in the tree for the current buffer, opening folders if needed" })
end

-- Attach these keymaps in the LSP plugin
function M.LSP_buf_keymaps(client, bufnr)
  local buf = vim.lsp.buf
  keymap.set('n', 'gD', buf.declaration, { noremap=true, silent=true, buffer=bufnr, desc = "Go to declaration" })
  keymap.set('n', 'gd', buf.definition,  { noremap=true, silent=true, buffer=bufnr, desc = "Go to definition" })
  keymap.set('n', 'K', buf.hover,  { noremap=true, silent=true, buffer=bufnr, desc = "Show hover" })
  keymap.set('n', 'gi', buf.implementation,  { noremap=true, silent=true, buffer=bufnr, desc = "Go to implementation" })
  keymap.set('n', '<c-k>', buf.signature_help,  { noremap=true, silent=true, buffer=bufnr, desc = "Show signature help" })
  keymap.set('n', '<space>wa', buf.add_workspace_folder,  { noremap=true, silent=true, buffer=bufnr, desc = "Add workspace folder" })
  keymap.set('n', '<space>wr', buf.remove_workspace_folder,  { noremap=true, silent=true, buffer=bufnr, desc = "Remove workspace folder"})
  keymap.set('n', '<space>wl', function()
    print(vim.inspect(buf.list_workspace_folders()))
  end,  { noremap=true, silent=true, buffer=bufnr, desc = "List workspace folders" })
  keymap.set('n', '<space>D', buf.type_definition,  { noremap=true, silent=true, buffer=bufnr, desc="Go to type definition" })
  keymap.set('n', '<space>rn', buf.rename,  { noremap=true, silent=true, buffer=bufnr, desc="Rename"})
  keymap.set('n', '<space>ca', buf.code_action,  { noremap=true, silent=true, buffer=bufnr, desc="Code action" })
  keymap.set('n', 'gr', buf.references,  { noremap=true, silent=true, buffer=bufnr, desc="References" })
  keymap.set('n', '<space>f', function() buf.format { async = true } end, { noremap=true, silent=true, buffer=bufnr, desc="Format" })
  -- shortcut for tsserver lsp
  -- telescope integration
  keymap.set('n', '<space>ws', function()
    require('telescope.builtin').lsp_workspace_symbols()
  end,  { noremap=true, silent=true, buffer=bufnr, desc="Workspace symbols" })
  keymap.set('n', '<space>ds', function()
    require('telescope.builtin').lsp_document_symbols()
  end, { noremap=true, silent=true, buffer=bufnr, desc="Document symbols" })

  if client.name == 'tsserver' then
    keymap.set('n', '<space>tsff', ':TSLspFixCurrent<CR>', { noremap=true, silent=true, buffer=bufnr, desc="Fix current" })
    keymap.set('n', '<space>tsrf', ':TSLspRenameFile<CR>', { noremap=true, silent=true, buffer=bufnr, desc="Rename file" })
    keymap.set('n', '<space>tsoi', ':TSLspOrganize<CR>', { noremap=true, silent=true, buffer=bufnr, desc="Organize imports" })
    keymap.set('n', '<space>tscoi', ':TSServerOrganizeImports<CR>', { noremap=true, silent=true, buffer=bufnr, desc="Customized organize imports" })
  end
end

-- Used to enable keymaps for diagnostics
function M.LSP_diagnostic_keymaps()
  keymap.set('n', '<space>e', vim.diagnostic.open_float,  { noremap=true, silent=true, desc = "Show diagnostics" })
  keymap.set('n', '[d', vim.diagnostic.goto_prev,  { noremap=true, silent=true, desc="Go to previous diagnostic" })
  keymap.set('n', ']d', vim.diagnostic.goto_next,  { noremap=true, silent=true, desc="Go to next diagnostic"})
  keymap.set('n', '<space>q', vim.diagnostic.setloclist,  { noremap=true, silent=true, desc="Set diagnostic list"})
end

return M
