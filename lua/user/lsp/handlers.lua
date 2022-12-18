local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

local M = {}

vim.cmd [[
highlight DiagnosticUnderlineError guifg=Red ctermfg=Red
hi DiagnosticError guifg=Red ctermfg=Red
]]

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

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
    style = "minimal",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>Lspsaga peek_definition<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  keymap(bufnr, "n", "gm", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gu", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
  keymap(bufnr, "n", "gF", "<cmd>Lspsaga lsp_finder<cr>", opts)
  keymap(bufnr, "n", "gL", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(
    bufnr, "n", "<leader>ls",
    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)

  keymap(bufnr, 'n', 'E', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- Standard LSP
  --[[ keymap(bufnr, "n", "ge", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts) ]]
  --[[ keymap(bufnr, "n", "g[", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts) ]]

  keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  keymap(bufnr, "n", "<leader>q", '<cmd>vim.diagnostic.setloclist()<CR>', opts)

  -- LSP Saga
  keymap(bufnr, "n", "ge", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  keymap(bufnr, "n", "gE", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

  keymap(bufnr, "i", "<C-space>", "<Cmd>Lspsaga signature_help<CR>", { silent = true })
  keymap(bufnr, "n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)

end

M.on_attach = function(client, bufnr)

  -- if client.name == "tsserver" then
  --   client.server_capabilities.document_formatting = false
  --   client.server_capabilities.documentFormattingProvider = false
  -- end
  --
  if client.name == "jsonls" or client.name == "json" then
    -- client.server_capabilities.document_highlight = false
    -- client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    client.server_capabilities.document_symbol = false
    client.server_capabilities.workspace_symbol = false
    client.server_capabilities.rename = false
    client.server_capabilities.hover = false
    client.server_capabilities.completion = false
    client.server_capabilities.code_action = false
  end

  if client.name == "dartls" then
    client.server_capabilities.document_formatting = false
  end

  if client.name == "sumneko_lua" then
    client.server_capabilities.document_formatting = true
  end

  lsp_keymaps(bufnr)

  require "user.illuminate"
  if require("user.colorscheme").colorscheme ~= "nightfly" then
    require "user.illuminate".on_attach(client)
  end

  require 'user.fidget'

end

local function lsp_execute_command(val)
  if val.edit or type(val.command) == "table" then
    if val.edit then
      vim.lsp.util.apply_workspace_edit(val.edit)
    end
    if type(val.command) == "table" then
      vim.lsp.buf.execute_command(val.command)
    end
  else
    vim.lsp.buf.execute_command(val)
  end
end

function M.code_action_fix_all()
  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  vim.lsp.buf_request(
    0,
    "textDocument/codeAction",
    params,
    function(err, results_lsp)
      if err then
        vim.pretty_print(err)
        if err.message then
          vim.notify(err.message, "error")
        end
        return
      end
      if not results_lsp or vim.tbl_isempty(results_lsp) then
        print "No results from textDocument/codeAction"
        return
      end
      for _, result in pairs(results_lsp) do
        if result
            and result.command
            and result.command.command == "edit.fixAll"
        then
          lsp_execute_command(result)
        end
      end
    end
  )
end

return M
