local M = {}

local mason_nullls = require("mason-null-ls")
local nullls = require("null-ls")
local nls_utils = require("null-ls.utils")

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

local formatting = nullls.builtins.formatting
local diagnostics = nullls.builtins.diagnostics
local code_actions = nullls.builtins.code_actions
local hover = nullls.builtins.hover

local sources = {
  require("typescript.extensions.null-ls.code-actions"), -- https://github.com/jose-elias-alvarez/typescript.nvim

  -- formatting
  formatting.prettier,
  formatting.shfmt,
  formatting.fixjson,
  formatting.black.with { extra_args = { "--fast" } },
  formatting.isort,
  with_root_file(formatting.stylua, "stylua.toml"),

  -- diagnostics
  diagnostics.eslint_d,
  --diagnostics.write_good,
  --diagnostics.markdownlint,
  --diagnostics.flake8,
  --diagnostics.tsc,
  with_root_file(diagnostics.selene, "selene.toml"),
  with_diagnostics_code(diagnostics.shellcheck),

  -- code actions
  code_actions.eslint_d,

  -- hover
  hover.dictionary,

  -- Additional formatters and litters will automatically be added by mason-null-ls plugin
}

function M.setup(opts)
  -- Installs all available null-ls plugins available on Mason registry
  mason_nullls.setup({
    ensure_installed = nil, -- resolve with all available plugins
    automatic_installation = true,
    automatic_setup = true, -- Recommended, but optional
})

  nullls.setup {
    -- debug = true,
    debounce = 150,
    save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern ".git",
  }

  -- Appends available builtin functionalities on top of the existents "sources" defined manually 
  mason_nullls.setup_handlers() 
end

return M
