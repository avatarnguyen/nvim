local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

-- local tabnine_status_ok, _ = pcall(require, "user.tabnine")
-- if not tabnine_status_ok then
--   return
-- end

local has_words_before = function()
  ---@diagnostic disable-next-line: deprecated
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local winhighlight = {
  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
}

-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
--   ---@diagnostic disable-next-line: deprecated
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
-- end

-- M.methods.has_words_before = has_words_before

local function jumpable(dir)
  local win_get_cursor = vim.api.nvim_win_get_cursor
  local get_current_buf = vim.api.nvim_get_current_buf

  ---sets the current buffer's luasnip to the one nearest the cursor
  ---@return boolean true if a node is found, false otherwise
  local function seek_luasnip_cursor_node()
    -- TODO(kylo252): upstream this
    -- for outdated versions of luasnip
    if not luasnip.session.current_nodes then
      return false
    end

    local node = luasnip.session.current_nodes[get_current_buf()]
    if not node then
      return false
    end

    local snippet = node.parent.snippet
    local exit_node = snippet.insert_nodes[0]

    local pos = win_get_cursor(0)
    pos[1] = pos[1] - 1

    -- exit early if we're past the exit node
    if exit_node then
      local exit_pos_end = exit_node.mark:pos_end()
      if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    node = snippet.inner_first:jump_into(1, true)
    while node ~= nil and node.next ~= nil and node ~= snippet do
      local n_next = node.next
      local next_pos = n_next and n_next.mark:pos_begin()
      local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
          or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

      -- Past unmarked exit node, exit early
      if n_next == nil or n_next == snippet.next then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end

      if candidate then
        luasnip.session.current_nodes[get_current_buf()] = node
        return true
      end

      local ok
      ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
      if not ok then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    -- No candidate, but have an exit node
    if exit_node then
      -- to jump to the exit node, seek to snippet
      luasnip.session.current_nodes[get_current_buf()] = snippet
      return true
    end

    -- No exit node, exit from snippet
    snippet:remove_from_jumplist()
    luasnip.session.current_nodes[get_current_buf()] = nil
    return false
  end

  if dir == -1 then
    return luasnip.in_snippet() and luasnip.jumpable(-1)
  else
    return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
  end
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
--   ---@diagnostic disable-next-line: deprecated
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
-- end

local icons = require "user.icons"

local kind_icons = icons.kind

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

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
    -- ["<C-[>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    -- ["<C-]>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    -- ['<Esc>'] = cmp.mapping(cmp.mapping.abort(), { 'c' }),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, { "i" }),
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, { "i" }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-y>"] = cmp.mapping {
      i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
        else
          fallback()
        end
      end,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif jumpable(1) then
        luasnip.jump(1)
      elseif has_words_before() then
        -- cmp.complete()
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
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
    -- Copilot CMP
    --    ["<CR>"] = cmp.mapping.confirm({
    --      -- this is the important line
    --      behavior = cmp.ConfirmBehavior.Replace,
    --      select = false,
    --    }),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local confirm_opts = {}
        local is_insert_mode = function()
          return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
        end
        if is_insert_mode() then -- prevent overwriting brackets
          confirm_opts.behavior = cmp.ConfirmBehavior.Insert
        end
        if cmp.confirm(confirm_opts) then
          return -- success, exit early
        end
      end

      fallback() -- if not exited early, always fallback
    end),
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
        vim_item.kind = icons.misc.Copilot
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
        luasnip = "SNIP",
        nvim_lsp = "LSP",
        cmp_tabnine = "TN",
        copilot = "CP",
        nvim_lua = "LSP",
        buffer = "BUF",
        path = "PATH",
        emoji = "E",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "crates",   group_index = 1 },
    --    {
    --      name = "copilot",
    --      -- keyword_length = 0,
    --      -- max_item_count = 3,
    --      group_index = 2,
    --    },
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
    { name = "luasnip",  group_index = 2 },
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
    -- { name = "cmp_tabnine",    group_index = 2 },
    { name = "path",           group_index = 2 },
    { name = "emoji",          group_index = 2 },
    { name = "lab.quick_data", keyword_length = 4, group_index = 2 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      --  require("copilot_cmp.comparators").prioritize,
      --  require("copilot_cmp.comparators").score,
      compare.offset,
      compare.exact,
      -- compare.scopes,
      compare.score,
      compare.recently_used,
      compare.locality,
      --      require('cmp_tabnine.compare'),
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    -- Nightfly Colorscheme
    completion = cmp.config.window.bordered(winhighlight),
    documentation = cmp.config.window.bordered(winhighlight),
    --[[ documentation = false, ]]
    -- documentation = {
    --   border = "rounded",
    --   winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    -- },
    -- completion = {
    --   border = "rounded",
    --   winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    -- },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

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

--cmp.event:on("menu_opened", function()
--  vim.b.copilot_suggestion_hidden = true
--end)
--
--cmp.event:on("menu_closed", function()
--  vim.b.copilot_suggestion_hidden = false
--end)
