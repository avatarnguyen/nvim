local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

local icons = require("user.icons")


local function diagnostics_indicator(num, _, diagnostics, _)
  local result = {}
  local symbols = {
    error = icons.diagnostics.Error,
    warning = icons.diagnostics.Warning,
    info = icons.diagnostics.Information,
  }
  -- if not icons.use_icons then
  --   return "(" .. num .. ")"
  -- end
  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. " " .. count)
    end
  end
  result = table.concat(result, " ")
  return #result > 0 and result or ""
end

-- local function is_ft(b, ft)
--   return vim.bo[b].filetype == ft
-- end

-- local function custom_filter(buf, buf_nums)
--   local logs = vim.tbl_filter(function(b)
--     return is_ft(b, "log")
--   end, buf_nums)
--   if vim.tbl_isempty(logs) then
--     return true
--   end
--   local tab_num = vim.fn.tabpagenr()
--   local last_tab = vim.fn.tabpagenr "$"
--   local is_log = is_ft(buf, "log")
--   if last_tab == 1 then
--     return true
--   end
--   -- only show log buffers in secondary tabs
--   return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
-- end

bufferline.setup {
  options = {
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    buffer_close_icon = "",
    -- buffer_close_icon = '',
    modified_icon = "●",
    close_icon = "",
    -- close_icon = '',
    left_trunc_marker = "",
    right_trunc_marker = "",
    highlights = {
      background = {
        italic = true,
      },
      buffer_selected = {
        bold = true,
      },
    },
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
    --   -- remove extension from markdown files for example
    --   if buf.name:match('%.md') then
    --     return vim.fn.fnamemodify(buf.name, ':t:r')
    --   end
    -- end,

    max_name_length = 30,
    max_prefix_length = 20, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    truncate_names = true, -- whether or not tab names should be truncated
    diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    --   return "(" .. count .. ")"
    -- end,
    diagnostics_indicator = diagnostics_indicator,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    -- custom_filter = custom_filter,
    --   -- filter out filetypes you don't want to see
    --   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
    --     return true
    --   end
    --   -- filter out by buffer name
    --   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
    --     return true
    --   end
    --   -- filter out based on arbitrary rules
    --   -- e.g. filter out vim wiki buffer from tabline in your work repo
    --   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
    --     return true
    --   end
    -- end,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    --[[ sort_by = 'relative_directory' -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b) ]]
    --   -- add custom logic
    --[[ return buffer_a.modified > buffer_b.modified ]]
    --[[ end ]]
    offsets = {
      {
        filetype = "undotree",
        text = "Undotree",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "NvimTree",
        text = "Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "DiffviewFiles",
        text = "Diff View",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "flutterToolsOutline",
        text = "Flutter Outline",
        highlight = "PanelHeading",
      },
      {
        filetype = "packer",
        text = "Packer",
        highlight = "PanelHeading",
        padding = 1,
      },
    },
  },
  -- highlights = {
  --   fill = {
  --     fg = { attribute = "fg", highlight = "#ff0000" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --   },
  --
  --   background = {
  --     fg = { attribute = "fg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --   },
  --
  --   buffer_visible = {
  --     fg = { attribute = "fg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --   },
  --
  --   close_button = {
  --     fg = { attribute = "fg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --   },
  --   close_button_visible = {
  --     fg = { attribute = "fg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --   },
  --   tab_selected = {
  --     fg = { attribute = "fg", highlight = "Normal" },
  --     bg = { attribute = "bg", highlight = "Normal" },
  --   },
  --
  --   tab = {
  --     fg = { attribute = "fg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --   },
  --
  --   tab_close = {
  --     -- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
  --     fg = { attribute = "fg", highlight = "TabLineSel" },
  --     bg = { attribute = "bg", highlight = "Normal" },
  --   },
  --
  --   duplicate_selected = {
  --     fg = { attribute = "fg", highlight = "TabLineSel" },
  --     bg = { attribute = "bg", highlight = "TabLineSel" },
  --     italic = true,
  --   },
  --
  --   duplicate_visible = {
  --     fg = { attribute = "fg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --     italic = true,
  --   },
  --
  --   duplicate = {
  --     fg = { attribute = "fg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --     italic = true,
  --   },
  --
  --   modified = {
  --     fg = { attribute = "fg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --   },
  --
  --   modified_selected = {
  --     fg = { attribute = "fg", highlight = "Normal" },
  --     bg = { attribute = "bg", highlight = "Normal" },
  --   },
  --
  --   modified_visible = {
  --     fg = { attribute = "fg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --   },
  --
  --   separator = {
  --     fg = { attribute = "bg", highlight = "TabLine" },
  --     bg = { attribute = "bg", highlight = "TabLine" },
  --   },
  --
  --   separator_selected = {
  --     fg = { attribute = "bg", highlight = "Normal" },
  --     bg = { attribute = "bg", highlight = "Normal" },
  --   },
  --
  --   indicator_selected = {
  --     fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
  --     bg = { attribute = "bg", highlight = "Normal" },
  --   },
  -- },
}
