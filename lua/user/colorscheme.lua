local colorscheme = "nightfly"
vim.g.nightflyItalics = 1
vim.g.nightflyNormalFloat = 1

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
