require('dap.ext.vscode').load_launchjs()

require('telescope').load_extension('dap')
require('nvim-dap-virtual-text').setup()

vim.g.dap_virtual_text = true
vim.fn.sign_define("DapBreakpoint", { text = "👋", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })

local dap = require("dap")

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
  {
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

dap.configurations.typescript = {
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
