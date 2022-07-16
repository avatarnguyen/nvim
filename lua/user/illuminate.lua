vim.g.Illuminate_ftblacklist = { 'alpha', 'NvimTree', 'neo-tree' }
vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
  { noremap = true })


-- vim.cmd [[
--   augroup illuminate_augroup
--       autocmd!
--       autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
--       autocmd VimEnter * hi link illuminatedWord Error
--   augroup END
-- ]]

-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
--   callback = function()
--     vim.cmd "hi illuminatedWord cterm=underline gui=underline"
--   end,
-- })
