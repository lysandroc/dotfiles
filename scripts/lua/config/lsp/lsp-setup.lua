local navic = require("nvim-navic")

local keymaps = require("core.keymaps")

-- This module needs to be loaded before the lsp autocompletion definition
require("config.lsp.cmp").setup()

-- The object key name will be used as the server's name and the value as configuration
-- Mason config reads the additional_mason_plugins property to install the LSP servers plugins available on it
-- :help lspconfig-all
local servers = {
  html = {
    -- additional_mason_plugins = "html-lsp",
  },
  cssls = {
    -- additional_mason_plugins = "stylelint-lsp css-lsp",
  },
  ["cssmodules_ls"] = {
    -- additional_mason_plugins = "",
  },
  tailwindcss = {
    -- additional_mason_plugins = 'tailwindcss-language-server',
  },
  jsonls = {
    -- additional_mason_plugins = "jsonlint json-lsp",
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        -- validate = { enable = true }, -- I should enable this
      },
    },
  },
  pyright = {
    --additional_mason_plugins = "pyright",
    analysis = {
      typeCheckingMode = "off",
    },
  },
  sumneko_lua = {
    -- additional_mason_plugins = "stylua lua-language-server",
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
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
          -- library = vim.api.nvim_get_runtime_file("", true),
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
        completion = { callSnippet = "Both" },
        telemetry = { enable = false },
      },
    },
  },
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
  eslint = {
    -- additional_mason_plugins = "eslint-lsp eslint_d",
    additional_mason_plugins = "eslint-lsp",
    -- filetypes ={ "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
    -- root_dir = function(startpath)
    --     local matcher = {}
    --     return M.search_ancestors(startpath, matcher)
    --   end,
    -- on_new_config = function(config, new_root_dir)
    --   -- The "workspaceFolder" is a VSCode concept. It limits how far the
    --   -- server will traverse the file system when locating the ESLint config
    --   -- file (e.g., .eslintrc).
    --   config.settings.workspaceFolder = {
    --     uri = new_root_dir,
    --     name = vim.fn.fnamemodify(new_root_dir, ':t'),
    --   }
    -- end,
    settings = {
      -- codeAction = {
      --   disableRuleComment = {
      --     enable = true,
      --     location = "separateLine"
      --   },
      --   showDocumentation = {
      --     enable = true
      --   }
      -- },
      -- codeActionOnSave = {
      --   enable = false,
      --   mode = "all"
      -- },
      -- experimental = {
      --   useFlatConfig = false
      -- },
      -- format = true,
      -- nodePath = "",
      -- onIgnoredFiles = "off",
      -- packageManager = "npm",
      -- problems = {
      --   shortenToSingleLine = false
      -- },
      -- quiet = false,
      -- rulesCustomizations = {},
      -- run = "onType",
      -- useESLintClass = false,
      -- validate = "on",
      -- workingDirectory = {
      --   mode = "location"
      -- }
    },
  },
  tsserver = {
    -- additional_mason_plugins = "typescript-language-server js-debug-adapter prettier",
    disable_formatting = true,
    commands = {
      -- Experimenting how to create a custom command
      TSServerOrganizeImports = {
        function()
          vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
          })
        end,
        description = "Organize Imports",
      },
    },
    settings = {
      format = { enable = false },
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
    -- additional_mason_plugins = "yaml-language-server",
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
    -- additional_mason_plugins = "vim-language-server"
  },
  -- grammarly = {
  --   additional_mason_plugins = "grammarly-languageserver",
  --   settings = {
  --     clientId = ""
  --   }
  -- }
  -- gopls = {
  --   additional_mason_plugins = "gopls",
  -- },
  -- rust_analyzer = {
  -- additional_mason_plugins = "rust_analyzer",
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
  -- pylsp = {},
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
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  keymaps.LSP_buf_keymaps(client, bufnr)

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

local new_capabilities = require("cmp_nvim_lsp").default_capabilities()
new_capabilities.textDocument.completion.completionItem.snippetSupport = true
new_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
new_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local opts = {
  on_attach = M.on_attach,
  capabilities = new_capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

function M.setup()
  require("config.lsp.null-ls").setup(opts)
  -- Send servers will enable to Mason config to read the additional_mason_plugins and install them
  -- and also, moreover, mason will setup lsp servers using mason-lspconfig
  require("config.lsp.mason").setup(servers, opts)
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
