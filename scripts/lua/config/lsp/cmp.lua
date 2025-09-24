local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local M = {}

M.setup = function()
  require("luasnip.loaders.from_vscode").lazy_load()
  --My custom snippets written in lua
  --require("luasnip.loaders.from_lua").load({ paths = root .. "/lua/core/snippets/" })


  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        symbol_map = {},
        mode = "symbol_text",
        maxwidth = 30, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(entry, vim_item)
          return vim_item
        end,
      }),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
      ["<C-l>"] = cmp.mapping({
        i = function(fallback)
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          else
            fallback()
          end
        end,
      }),
      ["<C-u>"] = cmp.mapping({
        i = function(fallback)
          if luasnip.choice_active() then
            require("luasnip.extras.select_choice")()
          else
            fallback()
          end
        end,
      }),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs( -4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      -- ["<TAB>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      --     --   elseif luasnip.expand_or_jumpable() then
      --     --     luasnip.expand_or_jump()
      --     --   -- elseif has_words_before() then
      --     --   --   cmp.complete()
      --   else
      --     fallback()
      --   end
      -- end, { "i", "c", "s" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace, select = false })
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        -- "c",
        "i",
        "s",
      }),
      ["<CR>"] = cmp.mapping({
        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        -- s = cmp.mapping.confirm({ select = false })
        s = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end,
      }),
      -- ['<CR>'] = cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }, { "i", "c" }), -- cmp.mapping.confirm({ select = false }),
      -- ['<TAB>'] = cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }, { "i", "c"}), --cmp.mapping.confirm({ select = false }),
      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
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
        elseif luasnip.jumpable( -1) then
          luasnip.jump( -1)
          -- elseif has_words_before() then
        else
          cmp.complete()
          -- else
          --   fallback()
        end
      end, {
        "i",
        "s",
        "c",
      }),
      ["<C-y>"] = {
        i = cmp.mapping.confirm({ select = false }),
      },
      ["<C-p>"] = {
        i = function(fallback)
          if cmp.visible() then
            return cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          end
          fallback()
        end,
      },
      ["<C-n>"] = {
        i = function()
          if cmp.visible() then
            return cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            return vim.schedule_wrap(cmp.complete())
          end
        end,
      },
    }),
    sources = {
      { name = "crates" },
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "treesitter" },
      { name = "rg" },
      { name = "path" },
      { name = "buffer" },
      -- { name = "crates" },
      -- { name = "spell" },
      { name =  "vsnip" }
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        -- Below is the default comparitor list and order for nvim-cmp
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    completion = {
      completeopt = "menu,menuone,noinsert",
      keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
      keyword_length = 0,
    },
  })

  -- -- -- Autocomplete when using search "/"
  -- cmp.setup.cmdline("/", {
  --   -- mapping = cmp.mapping.preset.cmdline(),
  --   sources = {
  --     { name = "buffer" },
  --   },
  -- })

  -- -- Autocomplete when using search ":"
  cmp.setup.cmdline(":", {
    -- mapping = cmp.mapping.preset.cmdline(),
    -- view = { entries = "wildmenu" },
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

end

return M
