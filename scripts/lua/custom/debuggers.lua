require('dap.ext.vscode').load_launchjs()

require('telescope').load_extension('dap')
require('nvim-dap-virtual-text').setup()

vim.g.dap_virtual_text = true
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "", linehl = "", numhl = "" })

local dap = require("dap")
local api = vim.api

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/projects/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.adapters.stayGraphQL = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/projects/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  -- {
  --   type = 'node2',
  --   request = 'launch',
  --   program = '${file}',
  --   cwd = vim.fn.getcwd(),
  --   sourceMaps = true,
  --   protocol = 'inspector',
  --   console = 'integratedTerminal',
  -- },
  {
    types = 'node2',
    requrest = 'launch',
    program = '${workspaceFolder}/${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    type = 'node2',
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
    type= "node2",
    request= "attach",
    name= "OG - attach to process",
    port= 9229,
    restart= true,
    stopOnEntry= false
  },
  {
    type = "stayGraphQL";
    request = "launch";
    program = "${workspaceFolder}/index.js";
    cwd = vim.fn.getcwd();
    sourceMaps = true;
    protocol = "inspector";
    console = "integratedTerminal";
  }
}

local widgets = require("dap.ui.widgets")

local view = {}

widgets.show_view = function()
  view = widgets.hover()
end

widgets.hide_view = function()
  if view.close then
    view.close()
  end
end

-- TODO: use K for keybindings and ESC to close the view
api.nvim_set_keymap('n', '<F4>', '<Cmd>lua require("dap.ui.widgets").show_view()<CR>', { silent = true })

local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == "<ESC>" then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', '<ESC>')
      end
      if keymap.lhs == "K" then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', 'K')
      end

      api.nvim_buf_set_keymap(buf, 'n', 'K', '<Cmd>lua require("dap.ui.widgets").show_view()<CR>', { silent = true })
      api.nvim_buf_set_keymap(buf, 'n', '<ESC>', '<Cmd>lua require("dap.ui.widgets").hide_view()<CR>', { silent = true })
    end
  end
end

dap.listeners.after['event_exited']['me'] = function()
  for _, keymap in pairs(keymap_restore) do
    local isBufLoaded = api.nvim_buf_is_loaded(keymap.buffer)
    if isBufLoaded then
      api.nvim_buf_set_keymap(
        keymap.buffer,
        keymap.mode,
        keymap.lhs,
        keymap.rhs,
        { silent = keymap.silent == 1 }
      )
    end
  end
  keymap_restore = {}
end
