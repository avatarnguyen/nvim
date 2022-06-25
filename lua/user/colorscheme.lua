local colorscheme = "kanagawa"
-- local colorscheme = "tokyonight"

-- nightfly
-- vim.g.nightflyTransparent = 0
-- vim.g.nightflyItalics = 1
-- vim.g.nightflyNormalFloat = 1
-- vim.g.nightflyCursorColor = 1
-- vim.g.nightflyUnderlineMatchParen = 1
--   " Vimscript initialization file
--   " set fillchars=horiz:━,horizup:┻,horizdown:┳,vert:┃,vertleft:┨,vertright:┣,verthoriz:╋

-- Kanagawa Colorscheme:
require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = { bold = true },
    variablebuiltinStyle = { italic = true},
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
    globalStatus = false,       -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {},
})

-- Tokyonight Storm Colorscheme
-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
-- vim.g.tokyonight_transparent_sidebar = 0

-- Current Use Option
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_variables = 1
-- vim.g.tokyonight_italic_keywords = 1
-- vim.g.tokyonight_lualine_bold = 1
-- vim.g.tokyonight_italic_functions = 1
-- vim.g.tokyonight_transparent = 0
-- vim.g.tokyonight_dark_sidebar = 1


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
