local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local tabnine_status_ok, _ = pcall(require, "user.tabnine")
if not tabnine_status_ok then
  return
end

local buffer_fts = {
  "markdown",
  "toml",
  "yaml",
  "json",
}

local function contains(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

local compare = require "cmp.config.compare"

luasnip.filetype_extend("dart", { "flutter" })
luasnip.filetype_extend("go", { "go" })
require("luasnip/loaders/from_vscode").load()
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.config/nvim/vscodesnips" } })

-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

local check_backspace = function()
  ---@diagnostic disable-next-line: deprecated
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local icons = require "user.icons"

local kind_icons = icons.kind

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })

vim.g.cmp_active = true

cmp.setup {
  enabled = function()
    local buftype = vim.api.nvim_buf_get_option(0, "buftype")
    if buftype == "prompt" then
      return false
    end
    return vim.g.cmp_active
  end,
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<m-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-c>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<m-j>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<m-k>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<m-c>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<S-CR>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    -- ["<Right>"] = cmp.mapping.confirm { select = true },
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<C-CR>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif check_backspace() then
        -- cmp.complete()
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = kind_icons[vim_item.kind]

      if entry.source.name == "cmp_tabnine" then
        vim_item.kind = icons.misc.Robot
        vim_item.kind_hl_group = "CmpItemKindTabnine"
      end
      if entry.source.name == "copilot" then
        vim_item.kind = icons.git.Octoface
        vim_item.kind_hl_group = "CmpItemKindCopilot"
      end

      if entry.source.name == "emoji" then
        vim_item.kind = icons.misc.Smiley
        vim_item.kind_hl_group = "CmpItemKindEmoji"
      end

      if entry.source.name == "crates" then
        vim_item.kind = icons.misc.Package
        vim_item.kind_hl_group = "CmpItemKindCrate"
      end

      if entry.source.name == "lab.quick_data" then
        vim_item.kind = icons.misc.CircuitBoard
        vim_item.kind_hl_group = "CmpItemKindConstant"
      end

      -- NOTE: order matters
      vim_item.menu = ({
        nvim_lsp = "LSP",
        cmp_tabnine = "TN",
        nvim_lua = "LSP",
        luasnip = "SNIP",
        buffer = "BUF",
        path = "PATH",
        emoji = "E",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "crates", group_index = 1 },
    -- {
    --   name = "copilot",
    --   -- keyword_length = 0,
    --   max_item_count = 3,
    --   trigger_characters = {
    --     {
    --       ".",
    --       ":",
    --       "(",
    --       "'",
    --       '"',
    --       "[",
    --       ",",
    --       "#",
    --       "*",
    --       "@",
    --       "|",
    --       "=",
    --       "-",
    --       "{",
    --       "/",
    --       "\\",
    --       "+",
    --       "?",
    --       " ",
    --       -- "\t",
    --       -- "\n",
    --     },
    --   },
    --   group_index = 2,
    -- },
    {
      name = "nvim_lsp",
      filter = function(entry, ctx)
        local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
        if kind == "Snippet" and ctx.prev_context.filetype == "java" then
          return true
        end

        if kind == "Text" then
          return true
        end
      end,
      group_index = 2,
    },
    { name = "nvim_lua", group_index = 2 },
    { name = "luasnip", group_index = 2 },
    {
      name = "buffer",
      group_index = 2,
      ---@diagnostic disable-next-line: unused-local
      filter = function(entry, ctx)
        if not contains(buffer_fts, ctx.prev_context.filetype) then
          return true
        end
      end,
    },
    { name = "cmp_tabnine", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = "emoji", group_index = 2 },
    { name = "lab.quick_data", keyword_length = 4, group_index = 2 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      -- require("copilot_cmp.comparators").prioritize,
      -- require("copilot_cmp.comparators").score,
      compare.offset,
      compare.exact,
      -- compare.scopes,
      compare.score,
      compare.recently_used,
      compare.locality,
      require('cmp_tabnine.compare'),
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
      -- require("copilot_cmp.comparators").prioritize,
      -- require("copilot_cmp.comparators").score,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    --[[ documentation = false, ]]
    documentation = {
      border = "rounded",
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
    completion = {
      border = "rounded",
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
  },
  experimental = {
    ghost_text = true,
  },
}

-- prefetch Dart files
local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })

vim.api.nvim_create_autocmd('BufRead', {
  group = prefetch,
  pattern = '*.dart',
  callback = function()
    require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
  end
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

--    format = lspkind.cmp_format({
--      -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
--      mode = 'symbol_text', -- show only symbol annotations
--      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
--      before = function(entry, vim_item)
--        vim_item.menu = source_mapping[entry.source.name]
--        if entry.source.name == "cmp_tabnine" then
--          local detail = (entry.completion_item.data or {}).detail
--          vim_item.kind = ""
--          if detail and detail:find('.*%%.*') then
--            vim_item.kind = vim_item.kind .. ' ' .. detail
--          end
--
--          if (entry.completion_item.data or {}).multiline then
--            vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
--          end
--        end
--
--        -- Get the full snippet (and only keep first line)
--        local word = entry:get_insert_text()
--        if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
--          word = vim.lsp.util.parse_snippet(word)
--        end
--        word = str.oneline(word)
--
--        -- concatenates the string
--        -- local max = 50
--        -- if string.len(word) >= max then
--        -- 	local before = string.sub(word, 1, math.floor((max - 3) / 2))
--        -- 	word = before .. "..."
--        -- end
--
--        if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
--            and string.sub(vim_item.abbr, -1, -1) == "~"
--        then
--          word = word .. "~"
--        end
--        vim_item.abbr = word
--        --[[ local maxwidth = 80 ]]
--        --[[ vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth) ]]
--        return vim_item
--      end
--    }),
