local status_ok, preview = pcall(require, "goto-preview")
if not status_ok then
  return
end

preview.setup {}

vim.api.nvim_set_keymap("n", "gh", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
-- vim.api.nvim_set_keymap("n", "gp", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "gj", "<cmd>lua require('goto-preview').close_all_win()<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", {noremap=true})

