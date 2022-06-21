local colorscheme = "tokyonight"

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_variables = 1
vim.g.tokyonight_italic_keywords = 1
vim.g.tokyonight_lualine_bold = 1
vim.g.tokyonight_italic_functions = 1
vim.g.tokyonight_dark_sidebar = 1
-- vim.g.tokyonight_transparent = 0

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
