local cmp = require 'cmp'
local luasnip = require 'luasnip'

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local M = {}

M.setup = function()
  -- https://github.com/rafamadriz/friendly-snippets/issues/105
	-- Have to do this before loading snippets
  luasnip.filetype_extend("javascript", { "javascriptreact" })
	luasnip.filetype_extend("typescript", { "javascript" })

  require("luasnip.loaders.from_vscode").lazy_load()
  --My custom snippets written in lua
  --require("luasnip.loaders.from_lua").load({ paths = root .. "/lua/core/snippets/" })
  
  local confirming_choice = {
    i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
    c = function(fallback)
      if cmp.visible() then
        cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
      else
        fallback()
      end
    end,
  }

  -- require("copilot_cmp").setup {
  --   method = "getCompletionsCycling",
  -- }

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ["<C-l>"] = cmp.mapping {
        i = function(fallback)
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          else
            fallback()
          end
        end,
      },
      ["<C-u>"] = cmp.mapping {
        i = function(fallback)
          if luasnip.choice_active() then
            require "luasnip.extras.select_choice"()
          else
            fallback()
          end
        end,
      },
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping { i = cmp.mapping.close(), c = cmp.mapping.close() },
      ["<tab>"] = cmp.mapping(confirming_choice),
      ["<CR>"] = cmp.mapping(confirming_choice),
      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        -- elseif neogen.jumpable() then
        --   neogen.jump_next()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        "i",
        "s",
        "c",
      }),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        -- elseif neogen.jumpable(true) then
        --   neogen.jump_prev()
        else
          fallback()
        end
      end, {
        "i",
        "s",
        "c",
      }),
      ["<C-y>"] = {
        i = cmp.mapping.confirm { select = false },
      },
      ["<C-n>"] = {
        i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      },
      ["<C-p>"] = {
        i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      },
    },
    sources = {
      -- { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "treesitter" },
      { name = "rg" },
      { name = "buffer" },
      { name = "path" },
      { name = "crates" },
      { name = "spell" },
      { name =  "vsnip" }
    },
  }
end

return M
