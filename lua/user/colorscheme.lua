-- local colorscheme = "kanagawa"
-- local colorscheme = "tokyonight"
-- local colorscheme = "cobalt2"
local colorscheme = "nightfly"
-- local colorscheme = "night-owl"

-- require('night-owl')

-- nightfly
if colorscheme == "nightfly" then
 vim.g.nightflyTransparent = 1
 vim.g.nightflyItalics = 1
 vim.g.nightflyNormalFloat = 1
 vim.g.nightflyCursorColor = 0
 vim.g.nightflyUnderlineMatchParen = 1
 vim.g.nightflyUndercurls = 1
end

if colorscheme == "cobalt2" then
  -- require('colorbuddy').setup()
  require('colorbuddy').colorscheme('cobalt2')
  -- Group.new('italicBoldFunction', colors.green, groups.Function, styles.bold + styles.italic)
end

-- Kanagawa Colorscheme:
if colorscheme == "kanagawa" then
  require('kanagawa').setup({
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = { bold = true },
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = false, -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {},
  })
end

if colorscheme == "tokyonight" then
  -- Tokyonight Storm Colorscheme
  -- vim.g.tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
  -- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
  -- vim.g.tokyonight_transparent_sidebar = 0

  -- Current Use Option
  -- vim.g.tokyonight_style = "night"
  -- vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_italic_variables = 1
  vim.g.tokyonight_italic_keywords = 1
  vim.g.tokyonight_lualine_bold = 1
  vim.g.tokyonight_italic_functions = 1
  vim.g.tokyonight_transparent = 0
  vim.g.tokyonight_dark_sidebar = 1
end


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
