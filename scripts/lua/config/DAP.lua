require("telescope").load_extension("dap")
require("codicons").setup()
require("dapui").setup()
require("nvim-dap-virtual-text").setup()

-- https://github.com/mxsdev/nvim-dap-vscode-js
vim.g.dap_virtual_text = true

local M = {}

M.setup = function()
    require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        debugger_cmd = { "js-debug-adapter" },
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        -- log_file_path = "~/dap_vscode_js.log", -- Path for file logging
        -- log_file_level = true, -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })

    local dap = require("dap")

    -- custom adapter for running tasks before starting debug
    local custom_adapter = "pwa-node-custom"
    dap.adapters[custom_adapter] = function(cb, config)
        if config.preLaunchTask then
            local async = require("plenary.async")
            local notify = require("notify").async

            async.run(function()
                ---@diagnostic disable-next-line: missing-parameter
                notify("Running [" .. config.preLaunchTask .. "]").events.close()
            end, function()
                vim.fn.system(config.preLaunchTask)
                config.type = "pwa-node"
                dap.run(config)
            end)
        end
    end

    -- language config
    for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
            {
                name = "Launch",
                type = "pwa-node",
                request = "launch",
                program = "${file}",
                rootPath = "${workspaceFolder}",
                cwd = "${workspaceFolder}",
                sourceMaps = true,
                skipFiles = { "<node_internals>/**" },
                protocol = "inspector",
                console = "integratedTerminal",
            },
            {
                name = "Attach to node process",
                type = "pwa-node",
                request = "attach",
                rootPath = "${workspaceFolder}",
                processId = require("dap.utils").pick_process,
            },
            {
                name = "Debug Main Process (Electron)",
                type = "pwa-node",
                request = "launch",
                program = "${workspaceFolder}/node_modules/.bin/electron",
                args = {
                    "${workspaceFolder}/dist/index.js",
                },
                outFiles = {
                    "${workspaceFolder}/dist/*.js",
                },
                resolveSourceMapLocations = {
                    "${workspaceFolder}/dist/**/*.js",
                    "${workspaceFolder}/dist/*.js",
                },
                rootPath = "${workspaceFolder}",
                cwd = "${workspaceFolder}",
                sourceMaps = true,
                skipFiles = { "<node_internals>/**" },
                protocol = "inspector",
                console = "integratedTerminal",
            },
            {
                name = "Compile & Debug Main Process (Electron)",
                type = custom_adapter,
                request = "launch",
                preLaunchTask = "npm run build-ts",
                program = "${workspaceFolder}/node_modules/.bin/electron",
                args = {
                    "${workspaceFolder}/dist/index.js",
                },
                outFiles = {
                    "${workspaceFolder}/dist/*.js",
                },
                resolveSourceMapLocations = {
                    "${workspaceFolder}/dist/**/*.js",
                    "${workspaceFolder}/dist/*.js",
                },
                rootPath = "${workspaceFolder}",
                cwd = "${workspaceFolder}",
                sourceMaps = true,
                skipFiles = { "<node_internals>/**" },
                protocol = "inspector",
                console = "integratedTerminal",
            },
            {
                type = "pwa-node",
                request = "launch",
                name = "Debug Jest Tests",
                -- trace = true, -- include debugger info
                runtimeExecutable = "node",
                runtimeArgs = {
                    "./node_modules/jest/bin/jest.js",
                    "--runInBand",
                },
                rootPath = "${workspaceFolder}",
                cwd = "${workspaceFolder}",
                console = "integratedTerminal",
                internalConsoleOptions = "neverOpen",
            },
            {
                type = "pwa-chrome",
                name = "Attach - Remote Debugging",
                request = "attach",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = 9222,
                webRoot = "${workspaceFolder}",
            },
            {
                type = "pwa-chrome",
                name = "Launch Chrome",
                request = "launch",
                url = "http://localhost:3000",
            },
            -- {
            --     type= "node-terminal",
            --     request= "attach",
            --     name = "attach FRONTEND to process",
            --     port= 9229,
            --     restart= true,
            --     stopOnEntry= false,
            --     sourceMaps = true,
            --     skipFiles = { '<node_internals>/**' },
            -- }
            -- {
            --     name = 'Custom launch: npm run dev',
            --     type = 'node-terminal',
            --     request = 'launch',
            --     -- program = '${file}',
            --     command = 'echo npm run dev',
            --     rootPath = '${workspaceFolder}',
            --     cwd = '${workspaceFolder}',
            --     sourceMaps = true,
            --     skipFiles = { '<node_internals>/**' },
            --     protocol = 'inspector',
            --     console = 'integratedTerminal',
            -- },
            {
                type = "pwa-chrome",
                name = "Attach - Remote Debugging",
                request = "attach",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = 9222,
                webRoot = "${workspaceFolder}",
            },
            {
                type = "pwa-chrome",
                name = "fronend Launch Chrome",
                request = "launch",
                url = "http://localhost:1337",
            },
        }
    end

    -- local api = vim.api
    -- local widgets = require("dap.ui.widgets")
    -- local view = {}
    --
    -- widgets.show_view = function()
    --     view = widgets.hover()
    -- end
    -- widgets.hide_view = function()
    --     if view.close then
    --         view.close()
    --     end
    -- end
    -- -- TODO: use K for keybindings and ESC to close the view
    -- api.nvim_set_keymap('n', '<F4>', '<Cmd>lua require("dap.ui.widgets").show_view()<CR>', { silent = true })
    -- local keymap_restore = {}
    -- dap.listeners.after['event_initialized']['me'] = function()
    --     for _, buf in pairs(api.nvim_list_bufs()) do
    --         local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    --         for _, keymap in pairs(keymaps) do
    --             if keymap.lhs == "<ESC>" then
    --                 table.insert(keymap_restore, keymap)
    --                 api.nvim_buf_del_keymap(buf, 'n', '<ESC>')
    --             end
    --             if keymap.lhs == "K" then
    --                 table.insert(keymap_restore, keymap)
    --                 api.nvim_buf_del_keymap(buf, 'n', 'K')
    --             end
    --
    --             api.nvim_buf_set_keymap(buf, 'n', 'K', '<Cmd>lua require("dap.ui.widgets").show_view()<CR>', { silent = true })
    --             api.nvim_buf_set_keymap(buf, 'n', '<ESC>', '<Cmd>lua require("dap.ui.widgets").hide_view()<CR>', { silent = true })
    --         end
    --     end
    -- end
    --
    -- dap.listeners.after['event_exited']['me'] = function()
    --     for _, keymap in pairs(keymap_restore) do
    --         local isBufLoaded = api.nvim_buf_is_loaded(keymap.buffer)
    --         if isBufLoaded then
    --             api.nvim_buf_set_keymap(
    --                 keymap.buffer,
    --                 keymap.mode,
    --                 keymap.lhs,
    --                 keymap.rhs,
    --                 { silent = keymap.silent == 1 }
    --             )
    --         end
    --     end
    --     keymap_restore = {}
    -- end
end

return M
