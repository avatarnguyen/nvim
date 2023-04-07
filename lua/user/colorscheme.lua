-- vim:fileencoding=utf-8:foldmethod=marker

local M = {}

-- local colorscheme = "kanagawa"
local colorscheme = "tokyonight"
-- local colorscheme = "cobalt2"
-- local colorscheme = "nightfly"
-- local colorscheme = "catppuccin"
-- local colorscheme = "ayu"
-- local colorscheme = "github"

-- catppuccin {{{
if colorscheme == "catppuccin" then
  require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    -- background = { -- :h background
    --   light = "mocha",
    --   dark = "mocha",
    -- },
    transparent_background = true,
    show_end_of_buffer = true, -- show the '~' characters after the end of buffers
    term_colors = true,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      notify = true,
      mini = false,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  })
end
--}}}

-- nightfly {{{
if colorscheme == "nightfly" then
  vim.g.nightflyTransparent = 1
  vim.g.nightflyTerminalColors = 2
  vim.g.nightflyItalics = 1
  vim.g.nightflyNormalFloat = 1
  vim.g.nightflyCursorColor = 1
  vim.g.nightflyUndercurls = 1
  vim.g.nightflyUnderlineMatchParen = true
  vim.g.nightflyWinSeparator = 2
  vim.g.nightflyVirtualTextColor = true
end
-- }}}

if colorscheme == "cobalt2" then
  require("user.cobalt")
end

-- Kanagawa: {{{
if colorscheme == "kanagawa" then
  require('kanagawa').setup({
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = { bold = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true, italic = true },
    typeStyle = { bold = true },
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = true, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = true, -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {},
  })
end
-- }}}

-- tokyonight {{{

if colorscheme == "tokyonight" then
  require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    style = "moon",
    -- style = "storm",
    -- style = "night",
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = { bold = true },
      variables = { italic = true },
      sidebars = "dark", -- style for sidebars, see below
      floats = "transparent", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    --- param colors ColorScheme
    -- on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    --- param highlights Highlights
    --- param colors ColorScheme
    -- on_highlights = function(highlights, colors) end,
  })
end
---}}}

-- ayu {{{
if colorscheme == "ayu" then
  -- local colors = require('ayu.colors')
  -- colors.generate() --
  require('ayu').setup({
    mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    overrides = {
      -- NormalNC = { bg = nil, fg = '#808080' }
    }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
  })
end
---}}}

-- github {{{
if colorscheme == "github" then
  require("github-theme").setup({
    theme_style = "dark_default",
    function_style = "italic",
    comment_style = "italic",
    keyword_style = "italic",
    -- variable_style = "italic",
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    colors = { hint = "orange", error = "#ff0000" },
    -- Overwrite the highlight groups
    overrides = function(c)
      return {
        htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
        DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
        -- this will remove the highlight groups
        TSField = {},
      }
    end
  })
end
---}}}

-- github {{{
if colorscheme ~= "cobalt2" and colorscheme ~= "github" then
  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not status_ok then
    return
  end
end
---}}}

-- NeoSolarized {{{
-- if colorscheme == "NeoSolarized" then
--   vim.cmd [[
--       highlight FloatBorder guibg=NONE ctermbg=NONE  " Removes the border of float menu (LSP and Autocompletion uses it)
--       highlight link NormalFloat Normal
--       highlight NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
--       highlight Pmenu ctermbg=NONE guibg=NONE
--   ]]
-- end
---}}}

M.colorscheme = colorscheme

return M
