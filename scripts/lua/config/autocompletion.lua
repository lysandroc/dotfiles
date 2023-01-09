-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

local M = {}

M.setup = function()
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
      ["<CR>"] = cmp.mapping {
        i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
          else
            fallback()
          end
        end,
      },
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
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "luasnip" },
      { name = "treesitter" },
      { name = "rg" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "crates" },
      { name = "spell" },
    },
  }
end

return M
