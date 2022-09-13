local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.api.nvim_err_writeln "Failed to load cmp"
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  vim.api.nvim_err_writeln "Failed to load cmp luasnip"
  return
end


luasnip.filetype_extend("dart", { "flutter" })
require("luasnip/loaders/from_vscode").load()
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.config/nvim/vscodesnips" } })

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- local icons = require "user.icons"
-- local kind_icons = icons.kind

local compare = require('cmp.config.compare')
local lspkind = require('lspkind')
--[[ local types = require("cmp.types") ]]
--[[ local str = require("cmp.utils.str") ]]

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
  luasnip = "",
  emoji = "",

}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
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
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        --[[ -- Get the full snippet (and only keep first line) ]]
        --[[ local word = entry:get_insert_text() ]]
        --[[ if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then ]]
        --[[   word = vim.lsp.util.parse_snippet(word) ]]
        --[[ end ]]
        --[[ word = str.oneline(word) ]]
        --[[]]
        --[[ -- concatenates the string ]]
        --[[ -- local max = 50 ]]
        --[[ -- if string.len(word) >= max then ]]
        --[[ -- 	local before = string.sub(word, 1, math.floor((max - 3) / 2)) ]]
        --[[ -- 	word = before .. "..." ]]
        --[[ -- end ]]
        --[[]]
        --[[ if ]]
        --[[   entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet ]]
        --[[   and string.sub(vim_item.abbr, -1, -1) == "~" ]]
        --[[ then ]]
        --[[   word = word .. "~" ]]
        --[[ end ]]
        --[[ vim_item.abbr = word ]]
        --[[ return vim_item ]]
        vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
        vim_item.menu = source_mapping[entry.source.name]
        if entry.source.name == "cmp_tabnine" then
          local detail = (entry.completion_item.data or {}).detail
          vim_item.kind = ""
          if detail and detail:find('.*%%.*') then
            vim_item.kind = vim_item.kind .. ' ' .. detail
          end

          if (entry.completion_item.data or {}).multiline then
            vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
          end
        end
        local maxwidth = 80
        vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
        return vim_item
      end
    }),
    -- format = function(entry, vim_item)
    --   vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    --   vim_item.menu = ({
    --     nvim_lsp = "",
    --     nvim_lua = "",
    --     luasnip = "",
    --     buffer = "",
    --     path = "",
    --     emoji = "",
    --     cmp_tabnine = "[T9]",
    --   })[entry.source.name]
    --   return vim_item
    -- end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    -- { name = "buffer" },
    { name = "buffer",
      options = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end
      }
    },
    { name = 'cmp_tabnine' },
    { name = "path" },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.score,
      compare.exact,
      compare.kind,
      compare.offset,
      require('cmp_tabnine.compare'),
      compare.recently_used,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
  },
  experimental = {
    ghost_text = true,
  },
}

-- prefetch Dart files
local prefetch = vim.api.nvim_create_augroup("prefetch", {clear = true})

vim.api.nvim_create_autocmd('BufRead', {
  group = prefetch,
  pattern = '*.dart',
  callback = function()
    require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
  end
})
