local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", 'info' },
  symbols = { error = " ", warn = " ", info = " " },
  colored = true,
  update_in_insert = false,
  always_visible = false,
}

local diff = {
  "diff",
  colored = false,
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
}

local tabs = {
  "tabs",
  mode = 1,
}

-- local filename2 = {
--   'filename',
--   file_status = true, -- displays file status (readonly status, modified status)
--   path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
--   shorting_target = 30,
-- }

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

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
      -- winbar = { "alpha", "dashboard", "neotree", "neo-tree", "NvimTree", "Telescope", "StartupTime" },
      tabline = { "alpha", "dashboard", "neotree", "neo-tree", "NvimTree", "NvimTree_1", "Telescope", "nvim_lsp",
        "fidget", "No name", "No Name" },
    },
    always_divide_middle = false,
    refresh = {
      statusline = 1000,
      tabline = 800,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { branch, diff },
    lualine_b = { tabs },
    lualine_c = { diagnostics },
    lualine_x = { spaces, filetype },
    lualine_y = { location },
    -- lualine_z = { { "progress", separator = { right = "" }, } },
    lualine_z = { "progress" },
  },
  tabline = {
    -- lualine_a = {
    --   nvim_tree_shift,
    -- },
    lualine_a = {
      {
        "buffers",
        -- separator = { left = "", right = "" },
        separator = {  right = '' },
        right_padding = 2,
        symbols = { alternate_file = "" },
        show_filename_only = true, -- Shows shortened relative path when set to false.
        hide_filename_extension = true, -- Hide filename extension when set to true.
        show_modified_status = true, -- Shows indicator when the buffer is modified.
        mode = 0, -- 0: Shows buffer name
        -- 1: Shows buffer index
        -- 2: Shows buffer name + buffer index
        -- 3: Shows buffer number
        -- 4: Shows buffer name + buffer number
        -- max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
        -- it can also be a function that returns
        -- the value of `max_length` dynamically.
      },
    },
    lualine_x = { 'lsp_progress' },
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filepath },
    lualine_x = { diagnostics },
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filepath },
    lualine_x = {},
    lualine_y = {},
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
