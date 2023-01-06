local navic = require "nvim-navic"

-- This module needs to be loaded before the lsp autocompletion definition
require("plugins.autocompletion").setup()

-- mason.lua module reads the mason_plugins_name property to install the depentend plugins
local servers = {
  ["lsp-name-for-js-debug-adapter?"] = {
    -- https://github.com/mxsdev/nvim-dap-vscode-js
    mason_plugins_name = "js-debug-adapter",
  },
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
    mason_plugins_name = "typescript-language-server",
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

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float,  { noremap=true, silent=true, desc = "Show diagnostics" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,  { noremap=true, silent=true, desc="Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,  { noremap=true, silent=true, desc="Go to next diagnostic"})
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist,  { noremap=true, silent=true, desc="Set diagnostic list"})

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap=true, silent=true, buffer=bufnr, desc = "Go to declaration" })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition,  { noremap=true, silent=true, buffer=bufnr, desc = "Go to definition" })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover,  { noremap=true, silent=true, buffer=bufnr, desc = "Show hover" })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,  { noremap=true, silent=true, buffer=bufnr, desc = "Go to implementation" })
  vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help,  { noremap=true, silent=true, buffer=bufnr, desc = "Show signature help" })
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,  { noremap=true, silent=true, buffer=bufnr, desc = "Add workspace folder" })
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,  { noremap=true, silent=true, buffer=bufnr, desc = "Remove workspace folder"})
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end,  { noremap=true, silent=true, buffer=bufnr, desc = "List workspace folders" })
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition,  { noremap=true, silent=true, buffer=bufnr, desc="Go to type definition" })
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename,  { noremap=true, silent=true, buffer=bufnr, desc="Rename"})
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action,  { noremap=true, silent=true, buffer=bufnr, desc="Code action" })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references,  { noremap=true, silent=true, buffer=bufnr, desc="References" })
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting,  { noremap=true, silent=true, buffer=bufnr, desc="Format" })
  
  -- shortcut for tsserver lsp
  vim.keymap.set('n', '<space>toi', ':TSServerOrganizeImports<CR>', { noremap=true, silent=true, buffer=bufnr, desc="Organize typescript imports" })
  -- telescope integration
  vim.keymap.set('n', '<space>ws', function()
    require('telescope.builtin').lsp_workspace_symbols()
  end,  { noremap=true, silent=true, buffer=bufnr, desc="Workspace symbols" })
  vim.keymap.set('n', '<space>ds', function()
    require('telescope.builtin').lsp_document_symbols()
  end, { noremap=true, silent=true, buffer=bufnr, desc="Document symbols" })

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  -- require("config.lsp.keymaps").setup(client, bufnr)

  -- Configure highlighting
  -- require("config.lsp.highlighter").setup(client, bufnr)

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
  require("plugins.mason").setup(servers, opts)
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
