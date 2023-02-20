local M = {}

function M.setup(servers, options)
  local lspconfig = require("lspconfig")

  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  -- It will install mason plugins defined in the servers.additional_mason_plugins obj from LSP servers definition
  local Package = require("mason-core.package")
  local registry = require("mason-registry")
  for _, value in pairs(servers) do
    if value.additional_mason_plugins ~= nil and value.additional_mason_plugins ~= "" then
      local regular_exp_split_by_space = "([^%s]+)"
      -- get the plugins required for each LSP server
      for server in string.gmatch(value.additional_mason_plugins, regular_exp_split_by_space) do
        -- check if whether is installed or not
        if server ~= nil and not registry.is_installed(server) then
          local package_name, version = Package.Parse(server)
          local pkg = registry.get_package(package_name)
          -- It will install plugin
          pkg:install({ version = version, debug = true })
        end
      end
    end
  end

  -- https://github.com/williamboman/mason-lspconfig.nvim#default-configuration
  require("mason-lspconfig").setup({
    -- get the LSP's servers name
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
    auto_update = false,
  })

  -- Package installation folder
  local install_root_dir = vim.fn.stdpath("data") .. "/mason"

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})
      -- already has the capabilities and on_attach from the mason.lua file
      lspconfig[server_name].setup({ opts })
    end,
    ["tsserver"] = function()
      local opts = vim.tbl_deep_extend("force", options, servers["tsserver"] or {})
      -- https://github.com/jose-elias-alvarez/typescript.nvim
      require("typescript").setup({
        disable_commands = false,
        debug = false,
        go_to_source_definition = {
          fallback = true, -- fall back to standard LSP definition on failure
        },
        server = opts,
      })
    end,
    ["lua_ls"] = function()
      local opts = vim.tbl_deep_extend("force", options, servers["lua_ls"] or {})
      lspconfig.lua_ls.setup(require("neodev").setup({ opts }))
    end,
    -- ["rust_analyzer"] = function()
    --   local opts = vim.tbl_deep_extend("force", options, servers["rust_analyzer"] or {})
    --
    --   -- DAP settings - https://github.com/simrat39/rust-tools.nvim#a-better-debugging-experience
    --   local extension_path = install_root_dir .. "/packages/codelldb/extension/"
    --   local codelldb_path = extension_path .. "adapter/codelldb"
    --   local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    --   require("rust-tools").setup {
    --     tools = {
    --       autoSetHints = false,
    --       executor = require("rust-tools/executors").toggleterm,
    --       hover_actions = { border = "solid" },
    --       on_initialized = function()
    --         vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
    --           pattern = { "*.rs" },
    --           callback = function()
    --             vim.lsp.codelens.refresh()
    --           end,
    --         })
    --       end,
    --     },
    --     server = opts,
    --     dap = {
    --       adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    --     },
    --   }
    -- end,
  })
end

return M
