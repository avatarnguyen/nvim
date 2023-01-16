-- Use 'q' to quit from common plugins

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

if vim.g.vscode then
  -- VSCODE NEOVIM only auto commands
else
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
    callback = function()
      vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
    ]]
    end,
  })

  -- Remove statusline and tabline when in Alpha
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
      vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
    end,
  })

  -- Set wrap and spell in markdown and gitcommit
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"
  vim.cmd "autocmd BufEnter * ++nested if bufname() == 'neo-tree' . tabpagenr() | quit | endif"

  -- Fixes Autocomment
  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
      vim.cmd "set formatoptions-=cro"
    end,
  })


  -- FileType Autocommand
  vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
    pattern = { "arb", "*.arb" },
    callback = function()
      vim.cmd [[
      set filetype=json
    ]]
    end,
  })

end

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  pattern = { "log", "*.log" },
  callback = function()
    vim.opt.lazyredraw = true
    vim.opt_local.cursorline = false
    vim.opt.relativenumber = false
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   pattern = "*.dart",
--   vim.cmd [[
--     !tmux send-keys -t flutter 'r'<CR><CR>
--   ]]
-- })

--[[ local fix_all_on_save = vim.api.nvim_create_augroup("fix_all_on_save", {}) ]]
--[[]]
--[[ vim.api.nvim_create_autocmd({ "BufWritePre" }, { ]]
--[[   group = fix_all_on_save, ]]
--[[   pattern = "*.dart", ]]
--[[   callback = function() ]]
--[[     require("user.lsp.handlers").code_action_fix_all() ]]
--[[   end, ]]
--[[ }) ]]
