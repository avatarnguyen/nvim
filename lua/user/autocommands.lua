-- Use 'q' to quit from common plugins
if vim.g.vscode then
  vim.cmd [[
    augroup highlight_yank
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=200 }
    augroup END
  ]]

else
  vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

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

  -- Highlight Yanked Text
  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
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

-- GO 
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
local function go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    go_org_imports(100)
  end,
  group = format_sync_grp,
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
