local status_ok, navigator = pcall(require, "navigator")
if not status_ok then
  vim.api.nvim_err_writeln "Failed to load navigator"
  return
end

navigator.setup()

vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")
