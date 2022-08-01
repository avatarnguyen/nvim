local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.setup = function()
  local signs = {

    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    style = "minimal",
    width = 110,
    height = 24,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gm", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts) -- does not seems to work
  -- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
  keymap(bufnr, "n", "gL", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(
  bufnr, "n", "gl",
  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)
  keymap(bufnr, "n", "gE", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  keymap(bufnr, "n", "ge", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  keymap(bufnr, 'n', '<C-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  -- keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
  -- keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  -- keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
  -- keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  -- keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  -- keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  -- keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  -- keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not status_cmp_ok then
    return
  end

  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end

  if client.name == "jsonls" or client.name == "json" then
    client.server_capabilities.document_highlight = false
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    client.server_capabilities.document_symbol = false
    client.server_capabilities.workspace_symbol = false
    client.server_capabilities.rename = false
    client.server_capabilities.hover = false
    client.server_capabilities.completion = false
    client.server_capabilities.code_action = false
  end

  -- if client.name == "dartls" then
  --   client.server_capabilities.document_formatting = false
  -- end

  if client.name == "sumneko_lua" then
    client.server_capabilities.document_formatting = false
  end

  M.capabilities.textDocument.completion.completionItem.snippetSupport = true
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

  lsp_keymaps(bufnr)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)

  local ok, lsp_format = pcall(require, "lsp-format")
   if ok then
     lsp_format.on_attach(client)
  end
end

-- possible config: need to investigate
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if not cmp_status_ok then
--   return
-- end
-- M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
--
-- local function lsp_execute_command(val)
--   if val.edit or type(val.command) == "table" then
--     if val.edit then
--       vim.lsp.util.apply_workspace_edit(val.edit)
--     end
--     if type(val.command) == "table" then
--       vim.lsp.buf.execute_command(val.command)
--     end
--   else
--     vim.lsp.buf.execute_command(val)
--   end
-- end
--
-- function M.code_action_fix_all()
--   local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
--   local params = vim.lsp.util.make_range_params()
--   params.context = context
--   vim.lsp.buf_request(
--     0,
--     "textDocument/codeAction",
--     params,
--     function(err, results_lsp)
--       if err then
--         vim.pretty_print(err)
--         if err.message then
--           vim.notify(err.message, "error")
--         end
--         return
--       end
--       if not results_lsp or vim.tbl_isempty(results_lsp) then
--         print "No results from textDocument/codeAction"
--         return
--       end
--       for _, result in pairs(results_lsp) do
--         if
--           result
--           and result.command
--           and result.command.command == "edit.fixAll"
--         then
--           lsp_execute_command(result)
--         end
--       end
--     end
--   )
-- end

return M
