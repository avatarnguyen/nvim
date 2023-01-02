local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

-- FIXME: caused ui freezed
-- local noice = require("user.noice").noice;

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", 'info' },
  symbols = { error = " ", warn = " ", info = " " },
  colored = false,
  update_in_insert = false,
  always_visible = false,
}

-- local function show_macro_recording()
--   local recording_register = vim.fn.reg_recording()
--   if recording_register == "" then
--     return ""
--   else
--     return "Recording @" .. recording_register
--   end
-- end

local function workspace_diagnostic()
  local error_count, warning_count, info_count, hint_count, todo_count, anh_todo
  local count = { 0, 0, 0, 0, 0, 0 }
  local lsp_diagnostics = vim.diagnostic.get(nil)
  for _, diagnostic in ipairs(lsp_diagnostics) do
    if vim.startswith(
      vim.diagnostic.get_namespace(diagnostic.namespace).name,
      "vim.lsp"
    )
    then
      if string.find(diagnostic.message, 'TODO') then
        -- count[5] = count[5] + 1
        if string.find(diagnostic.message, '@anh') then
          count[6] = count[6] + 1
        end
      else
        count[diagnostic.severity] = count[diagnostic.severity] + 1
      end
    end
  end
  error_count = count[vim.diagnostic.severity.ERROR]
  warning_count = count[vim.diagnostic.severity.WARN]
  info_count = count[vim.diagnostic.severity.INFO]
  hint_count = count[vim.diagnostic.severity.HINT]
  -- todo_count = count[5]
  anh_todo = count[6]

  local str = ""
  if error_count > 0 then
    if string.len(str) > 0 then
      str = str .. " "
    end
    str = str .. " " .. error_count
  end
  if warning_count > 0 then
    if string.len(str) > 0 then
      str = str .. " "
    end
    str = str .. " " .. warning_count
  end
  if info_count > 0 then
    if string.len(str) > 0 then
      str = str .. " "
    end
    str = str .. " " .. info_count
  end
  if hint_count > 0 then
    if string.len(str) > 0 then
      str = str .. " "
    end
    str = str .. " " .. hint_count
  end
  -- if todo_count > 0 then
  --   if string.len(str) > 0 then
  --     str = str .. " "
  --   end
  --   str = str .. " " .. todo_count
  -- end
  if anh_todo > 0 then
    if string.len(str) > 0 then
      str = str .. " "
    end
    str = str .. " " .. anh_todo
  end

  return str
end

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
  -- separator = { left = "" }
}

local location = {
  "location",
  padding = 1,
}

local filepath = {
  'filename',
  file_status = true, -- displays file status (readonly status, modified status)
  path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
  shorting_target = 24,
  colored = true,
}

local fileName = {
  'filename',
  padding = 0,
  file_status = false, -- displays file status (readonly status, modified status)
  path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
  shorting_target = 40,
  colored = false,
}

--[[ local tabs = { ]]
--[[   "tabs", ]]
--[[   mode = 1, ]]
--[[ } ]]

local winbar_symbol = function()
  local exclude = {
    ['teminal'] = true,
    ['toggleterm'] = true,
    ['prompt'] = true,
    ['NvimTree'] = true,
    ['lualine'] = true,
    ['help'] = true,
    ['dap_ui'] = false,
    ['dapui_scopes'] = false,
    ['dap-repl'] = false,
  }
  if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
    return ""
  else
    local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
    local sym
    if ok then sym = lspsaga.get_symbol_node() end
    local win_val = ''
    if sym ~= nil then win_val = win_val .. ' ' .. sym end
    return win_val
  end
end

--[[ local spaces = function() ]]
--[[   return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") ]]
--[[ end ]]

-- local nvim_tree_shift = {
--   function()
--     return string.rep(' ',
--       vim.api.nvim_win_get_width(require 'nvim-tree.view'.get_winnr()) - 1)
--   end,
--   cond = require('nvim-tree.view').is_visible,
--   color = 'NvimTreeNormal'
-- }

local config = {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    -- section_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    -- component_separators = { left = "", right = "" },
    -- component_separators = "|",
    disabled_filetypes = {
      statusline = { "alpha", "dashboard" },
      winbar = { "alpha", "dashboard", "neotree", "neo-tree", "NvimTree", "Telescope", "StartupTime", "term",
        "toggleterm", 'dap_ui', 'dapui_scopes', 'dap-repl',
      },
      tabline = { "alpha", "dashboard", "neotree", "neo-tree", "NvimTree", "NvimTree_1", "Telescope", "nvim_lsp",
        "fidget", "No name", "No Name" },
    },
    always_divide_middle = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 800,
    },
  },
  sections = {
    lualine_a = { branch },
    lualine_b = { filepath },
    lualine_c = { diff },
    lualine_x = {
--      {
--        noice.api.status.command.get,
--        cond = noice.api.status.command.has,
--      },
      -- {
      --   noice.api.status.message.get_hl,
      --   cond = noice.api.status.message.has,
      -- },
--      {
--        noice.api.statusline.mode.get,
--        cond = noice.api.statusline.mode.has,
--        color = { fg = "#ff9e64" },
--      },
--      {
--        noice.api.status.search.get,
--        cond = noice.api.status.search.has,
--        color = { fg = "#ff9e64" },
--      },
      -- 'lsp_progress',
      workspace_diagnostic,
    },
    lualine_y = { filetype, location },
    -- lualine_z = { { "progress", separator = { right = "" }, } },
    lualine_z = { "progress" },
  },
  --[[ tabline = { ]]
  --[[   -- lualine_a = { ]]
  --[[   --   nvim_tree_shift, ]]
  --[[   -- }, ]]
  --[[   lualine_a = { ]]
  --[[     { ]]
  --[[       "buffers", ]]
  --[[       -- separator = { left = "", right = "" }, ]]
  --[[       separator = { right = '' }, ]]
  --[[       right_padding = 2, ]]
  --[[       symbols = { alternate_file = "" }, ]]
  --[[       show_filename_only = true, -- Shows shortened relative path when set to false. ]]
  --[[       hide_filename_extension = true, -- Hide filename extension when set to true. ]]
  --[[       show_modified_status = true, -- Shows indicator when the buffer is modified. ]]
  --[[       mode = 0, -- 0: Shows buffer name ]]
  --[[       -- 1: Shows buffer index ]]
  --[[       -- 2: Shows buffer name + buffer index ]]
  --[[       -- 3: Shows buffer number ]]
  --[[       -- 4: Shows buffer name + buffer number ]]
  --[[       -- max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component, ]]
  --[[       -- it can also be a function that returns ]]
  --[[       -- the value of `max_length` dynamically. ]]
  --[[     }, ]]
  --[[   }, ]]
  --[[   lualine_x = { 'lsp_progress' }, ]]
  --[[   lualine_y = { workspace_diagnostic } ]]
  --[[ }, ]]
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { fileName, winbar_symbol },
    lualine_x = {},
    lualine_y = { diagnostics },
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filepath },
    lualine_x = {},
    lualine_y = { diagnostics },
    lualine_z = {}
  },
  extensions = { 'nvim-tree', 'toggleterm' }
}
-- Color for highlights
-- local colors = {
--   yellow = '#ECBE7B',
--   cyan = '#008080',
--   darkblue = '#081633',
--   green = '#98be65',
--   orange = '#FF8800',
--   violet = '#a9a1e1',
--   magenta = '#c678dd',
--   blue = '#51afef',
--   red = '#ec5f67'
-- }

-- Inserts a component in lualine_c at left section
-- local function ins_left(component)
--   table.insert(config.sections.lualine_c, component)
-- end

-- Inserts a component in lualine_x ot right section
-- local function ins_right(component)
--   table.insert(config.tabline.lualine_x, component)
-- end
--
-- ins_right{
-- 	'lsp_progress',
-- 	-- display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
-- 	-- With spinner
-- 	-- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
-- 	colors = {
-- 	  percentage  = colors.cyan,
-- 	  title  = colors.cyan,
-- 	  message  = colors.cyan,
-- 	  spinner = colors.cyan,
-- 	  lsp_client_name = colors.magenta,
-- 	  use = true,
-- 	},
-- 	separators = {
-- 		component = ' ',
-- 		progress = ' | ',
-- 		-- message = { pre = '(', post = ')'},
-- 		percentage = { pre = '', post = '%% ' },
-- 		title = { pre = '', post = ': ' },
-- 		lsp_client_name = { pre = '[', post = ']' },
-- 		spinner = { pre = '', post = '' },
-- 		message = { commenced = 'In Progress', completed = 'Completed' },
-- 	},
-- 	display_components = {{ 'title', 'message' }},
-- 	-- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
-- 	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
-- 	spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
-- }

lualine.setup(config)

-- vim.api.nvim_create_autocmd("RecordingEnter", {
--   callback = function()
--     lualine.refresh({
--       place = { "statusline" },
--     })
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("RecordingLeave", {
--   callback = function()
--     -- This is going to seem really weird!
--     -- Instead of just calling refresh we need to wait a moment because of the nature of
--     -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
--     -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
--     -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
--     -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
--     local timer = vim.loop.new_timer()
--     timer:start(
--       50,
--       0,
--       vim.schedule_wrap(function()
--         lualine.refresh({
--           place = { "statusline" },
--         })
--       end)
--     )
--   end,
-- })
