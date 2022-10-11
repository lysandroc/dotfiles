require('telescope').load_extension('dap')
require("dapui").setup()
-- vim.g.dap_virtual_text = true

local dap = require("dap")
local api = vim.api

dap.adapters.vsCodeDebugger = {
  type = 'executable',
  command = 'node',
  -- https://github.com/mfussenegger/nvim-dap/issues/82
  -- args = {os.getenv('HOME') .. '/projects/vscode-node-debug2/out/src/nodeDebug.js'},
  args = {os.getenv('HOME') .. '/projects/vscode-js-debug/out/src/debugServerMain.js'},
}

dap.configurations.javascript = {
  {
    type = 'vsCodeDebugger',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
   types = 'vsCodeDebugger',
   request = 'launch',
   program = '${workspaceFolder}/${file}',
   cwd = vim.fn.getcwd(),
   sourceMaps = true,
   protocol = 'inspector',
   console = 'integratedTerminal',
 },
 {
   type = 'vsCodeDebugger',
   request = 'attach',
   cwd = vim.fn.getcwd(),
   sourceMaps = true,
   protocol = 'inspector',
   skipFiles = {'<node_internals>/**/*.js'},
 },
}

dap.configurations.typescript = {
  {
    -- OG frontend
    type= "vsCodeDebugger",
    request= "attach",
    name= "OG - attach to process",
    port= 9229,
    restart= true,
    stopOnEntry= false
  },
  {
    type = "vsCodeDebugger";
    request = "launch";
    program = "${workspaceFolder}/index.js";
    cwd = vim.fn.getcwd();
    sourceMaps = true;
    protocol = "inspector";
    console = "integratedTerminal";
  }
}

-- local widgets = require("dap.ui.widgets")

-- local view = {}

-- widgets.show_view = function()
--   view = widgets.hover()
-- end
--
-- widgets.hide_view = function()
--   if view.close then
--     view.close()
--   end
-- end

-- TODO: use K for keybindings and ESC to close the view
-- api.nvim_set_keymap('n', '<F4>', '<Cmd>lua require("dap.ui.widgets").show_view()<CR>', { silent = true })

-- local keymap_restore = {}
-- dap.listeners.after['event_initialized']['me'] = function()
--   for _, buf in pairs(api.nvim_list_bufs()) do
--     local keymaps = api.nvim_buf_get_keymap(buf, 'n')
--     for _, keymap in pairs(keymaps) do
--       if keymap.lhs == "<ESC>" then
--         table.insert(keymap_restore, keymap)
--         api.nvim_buf_del_keymap(buf, 'n', '<ESC>')
--       end
--       if keymap.lhs == "K" then
--         table.insert(keymap_restore, keymap)
--         api.nvim_buf_del_keymap(buf, 'n', 'K')
--       end
-- 
--       api.nvim_buf_set_keymap(buf, 'n', 'K', '<Cmd>lua require("dap.ui.widgets").show_view()<CR>', { silent = true })
--       api.nvim_buf_set_keymap(buf, 'n', '<ESC>', '<Cmd>lua require("dap.ui.widgets").hide_view()<CR>', { silent = true })
--     end
--   end
-- end

-- dap.listeners.after['event_exited']['me'] = function()
--   for _, keymap in pairs(keymap_restore) do
--     local isBufLoaded = api.nvim_buf_is_loaded(keymap.buffer)
--     if isBufLoaded then
--       api.nvim_buf_set_keymap(
--         keymap.buffer,
--         keymap.mode,
--         keymap.lhs,
--         keymap.rhs,
--         { silent = keymap.silent == 1 }
--       )
--     end
--   end
--   keymap_restore = {}
-- end
