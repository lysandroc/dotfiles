local navic = require "nvim-navic"

local keymaps = require('core.keymaps')

-- This module needs to be loaded before the lsp autocompletion definition
require("config.autocompletion").setup()

-- mason.lua module reads the mason_plugins_name property to install the depentend plugins
local servers = {
  jsonls = {
    mason_plugins_name = "jsonlint json-lsp",
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        -- validate = { enable = true }, -- I should enable this 
      },
    },
  },
  ---- pylsp = {}, -- Integration with rope for refactoring - https://github.com/python-rope/pylsp-rope
  pyright = {
    mason_plugins_name = "pyright",
    analysis = {
      typeCheckingMode = "off", },
  },
  sumneko_lua = {
    mason_plugins_name = "stylua lua-language-server",
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "Lua 5.4.4",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" },
          -- disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
        },
        -- workspace = {
        --   -- Make the server aware of Neovim runtime files
        --   library = {
        --     [vim.fn.expand "$VIMRUNTIME/lua"] = true,
        --     [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        --   },
        --   -- library = vim.api.nvim_get_runtime_file("", true),
        --   maxPreload = 2000,
        --   preloadFileSize = 50000,
        -- },
        completion = { callSnippet = "Both" },
        telemetry = { enable = false },
      },
    },
  },
  -- eslint = {
    -- mason_plugins_name = "eslint",
  --   filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  --   rootPatterns = { ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc", "package.json" },
  --   settings = {
  --     languages = {
  --       javascript = { eslint = { enable = true} },
  --       javascriptreact = { eslint = { enable = true } },
  --       typescript = { eslint = { enable = true } },
  --       typescriptreact = { eslint = { enable = true } },
  --     },
  --   },
  -- },
  tsserver = {
    mason_plugins_name = "typescript-language-server js-debug-adapter",
    disable_formatting = true,
    commands = {
      TSServerOrganizeImports = {
        function()
          vim.lsp.buf.execute_command { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) } }
        end,
        description = "Organize Imports",
      },
    },
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  },
  yamlls = {
    mason_plugins_name = "yaml-language-server",
    schemastore = {
      enable = true,
    },
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  vimls = {
    mason_plugins_name = "vim-language-server"
  },
  -- gopls = {
  --   mason_plugins_name = "gopls",
  -- },
  -- rust_analyzer = {
    -- mason_plugins_name = "rust_analyzer",
  --   settings = {
  --     ["rust-analyzer"] = {
  --       cargo = { allFeatures = true },
  --       checkOnSave = {
  --         command = "clippy",
  --         extraArgs = { "--no-deps" },
  --       },
  --     },
  --   },
  -- },
  -- tailwindcss = {},
  -- html = {},
  -- jdtls = {},
  -- dockerls = {},
  -- graphql = {},
  -- bashls = {},
  -- omnisharp = {},
  -- emmet_ls = {},
  -- marksman = {},
  -- angularls = {},
  -- prettierd = {},
  -- ["eslint-lsp"] = {},
  -- ["json-lsp"] = {},
  -- ["css-lsp"] = {},
}

keymaps.LSP_diagnostic_keymaps()

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  keymaps.LSP_buf_keymaps(bufnr)

  -- Configure formatting
  -- require("config.lsp.null-ls.formatters").setup(client, bufnr)
  
  -- nvim-navic
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  -- tagfunc
  if client.server_capabilities.definitionProvider then
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
M.capabilities = capabilities

local opts = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Setup LSP handlers
-- require("config.lsp.handlers").setup()

function M.setup()
  -- null-ls
  -- require("config.lsp.null-ls").setup(opts)

  -- Installer
  require("config.mason").setup(servers, opts)
end

local diagnostics_active = true

function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

return M
